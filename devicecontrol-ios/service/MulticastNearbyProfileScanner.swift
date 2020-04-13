import Foundation
import NIO

class MulticastNearbyProfileScanner : NearbyProfileScanner, ChannelInboundHandler {

    public typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    private var beaconMessages: [String : ServiceBeaconMessage] = [:]
    
    private let concurrentQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.nearbyProfileScanner",
      attributes: .concurrent)
    
    private var datagramChannel: Channel?
    
    private var group: EventLoopGroup?
    
    private let groupAddress: String
    private let port: Int
    
    private weak var consumer: ScanResultHandler?
    
    private var callbackWorkItem: DispatchWorkItem?
    
    init(groupAddress: String, port: Int) {
        self.groupAddress = groupAddress
        self.port = port
    }
    
    func scan(_ resultHandler: ScanResultHandler) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            guard self.consumer == nil else { return }
            do {
                print("starting multicast scan")
                self.consumer = resultHandler
                
                self.beaconMessages = [:]
                
                let multicastGroup = try! SocketAddress(ipAddress: self.groupAddress, port: self.port)
                
                self.group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
                
                let datagramBootstrap = DatagramBootstrap(group: self.group!)
                    .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEADDR), value: 1)
                    .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEPORT), value: 1)
                    .channelInitializer(self.initChannel(channel:))
                
                self.datagramChannel = try datagramBootstrap
                    .bind(host: self.groupAddress, port: self.port)
                    .flatMap { channel -> EventLoopFuture<Channel> in
                        let channel = channel as! MulticastChannel
                        return channel.joinGroup(multicastGroup).map { channel }
                    }.flatMap { channel -> EventLoopFuture<Channel> in
                        return channel.eventLoop.makeSucceededFuture(channel)
                    }.wait()
                
                if self.datagramChannel?.isActive == true {
                    self.callbackWorkItem = DispatchWorkItem { [weak self] in
                        guard let self = self else { return }
                        let results = self.beaconMessages
                        if let resultConsumer = self.consumer {
                            if (!results.isEmpty) {
                                resultConsumer.onResult(results)
                            }
                            self.tryReturnResult()
                        }
                    }
                    self.tryReturnResult()
                }

            } catch {
                print("error starting multicast \(error)")
            }
        }
    }
    
    public func initChannel(channel: Channel) -> EventLoopFuture<Void> {
        return channel.pipeline.addHandler(self)
    }
    
    private func tryReturnResult() {
        self.concurrentQueue.asyncAfter(deadline: .now() + .seconds(1), execute: callbackWorkItem!)
    }
    
    private func onReceive(_ message: ServiceBeaconMessage, _ fromAddress: String) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.beaconMessages[fromAddress] = message
        }
    }
    
    func stop() {
        print("stopping multicast scan")
        callbackWorkItem?.cancel()
        concurrentQueue.sync(flags: .barrier) {
            consumer = nil
            callbackWorkItem = nil
        }
        try! datagramChannel?.close().wait()
        try! group?.syncShutdownGracefully()
        datagramChannel = nil
        group = nil
    }
    
    func isScanning() -> Bool {
        var result = false
        concurrentQueue.sync {
            result = consumer != nil
        }
        return result
    }
    
    public func onChannelRead(data: () -> ByteBuffer, fromAddress: String?) {
        
        var buffer = data()
        
        guard let length: Int32 = buffer.readInteger() else {
            print("Error: length could not be parsed")
            return
        }

        guard let message = buffer.readString(length: Int(length)) else {
            print("Error: invalid string received")
            return
        }

        let jsonDecoder = JSONDecoder()
        do {
            let beaconMessage = try jsonDecoder.decode(ServiceBeaconMessage.self, from: message.data(using: .utf8)!)
            let remoteIp = fromAddress!
            guard !remoteIp.isEmpty else {
                print("Error: could not resolve remote ip")
                return
            }
            onReceive(beaconMessage, remoteIp)
        } catch {
            print("error decoding beacon message from buffer \(error)")
        }
        
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let envelope = self.unwrapInboundIn(data)
        
        onChannelRead(data: { envelope.data }, fromAddress: envelope.remoteAddress.ipAddress)
    }
    
}
