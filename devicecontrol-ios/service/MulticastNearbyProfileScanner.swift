import Foundation
import NIO

class MulticastNearbyProfileScanner : NearbyProfileScanner {

    private var isScanning = false
    
    private let serialQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.nearbyProfileScanner")
    
    private var datagramChannel: Channel? = nil
    
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
    
    init() {

    }
    
    func scan(_ resultConsumer: @escaping ([ServiceBeaconMessage]) -> Void) {
        
        do {
            
            let multicastGroup = try! SocketAddress(ipAddress: "224.0.0.147", port: 9889)
            

            let datagramBootstrap = DatagramBootstrap(group: group)
                .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEADDR), value: 1)
                .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEPORT), value: 1)
                .channelInitializer { channel in
                    channel.pipeline.addHandler(MulticastMessageDecoder { [weak self] message, fromAddress in
                        guard let self = self else { return }
                        self.onReceive(message, fromAddress)
                    })
                }
            
            datagramChannel = try datagramBootstrap
                .bind(host: "0.0.0.0", port: 9889)
                .flatMap { channel -> EventLoopFuture<Channel> in
                    let channel = channel as! MulticastChannel
                    return channel.joinGroup(multicastGroup).map { channel }
                }.flatMap { channel -> EventLoopFuture<Channel> in
                    return channel.eventLoop.makeSucceededFuture(channel)
                }.wait()
        } catch {
            print("error starting multicast \(error)")
        }
    }
    
    private func onReceive(_ message: ServiceBeaconMessage, _ fromAddress: String) {
        
    }
    
    func stop() {
        try! datagramChannel?.close().wait()
        try! group.syncShutdownGracefully()
    }
    
}

private final class MulticastMessageDecoder: ChannelInboundHandler {
    
    public typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    private let cons: (ServiceBeaconMessage, String) -> Void
    
    init(_ resultConsumer: @escaping (ServiceBeaconMessage, String) -> Void) {
        cons = resultConsumer
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let envelope = self.unwrapInboundIn(data)
        var buffer = envelope.data
        
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
            cons(beaconMessage, envelope.remoteAddress.ipAddress!)
        } catch {
            print("error decoding string from buffer \(error)")
        }
    }
}
