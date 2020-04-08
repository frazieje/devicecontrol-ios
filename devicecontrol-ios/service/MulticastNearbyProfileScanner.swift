import Foundation
import NIO

class MulticastNearbyProfileScanner : NearbyProfileScanner {

    private var isScanning = false
    
    private let serialQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.nearbyProfileScanner")
    
    private var datagramChannel: Channel? = nil
    
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    init() {

    }
    
    func scan(_ resultConsumer: @escaping ([ServiceBeaconMessage]) -> Void) {
        
        do {
            let chatMulticastGroup = try! SocketAddress(ipAddress: "224.0.0.147", port: 9889)
            
            // Begin by setting up the basics of the bootstrap.
            let datagramBootstrap = DatagramBootstrap(group: group)
                .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEADDR), value: 1)
                .channelOption(ChannelOptions.Types.SocketOption(level: SOL_SOCKET, name: SO_REUSEPORT), value: 1)
                .channelInitializer { channel in
                    channel.pipeline.addHandler(ChatMessageDecoder())
                }
            
            datagramChannel = try datagramBootstrap
                .bind(host: "0.0.0.0", port: 9889)
                .flatMap { channel -> EventLoopFuture<Channel> in
                    let channel = channel as! MulticastChannel
                    return channel.joinGroup(chatMulticastGroup, interface: nil).map { channel }
                }.flatMap { channel -> EventLoopFuture<Channel> in
                    return channel.eventLoop.makeSucceededFuture(channel)
                }.wait()
        } catch {
            print("error starting multicast \(error)")
        }
    }
    
    func stop() {
        try! datagramChannel?.close().wait()
        try! group.syncShutdownGracefully()
    }
    
}

private final class ChatMessageDecoder: ChannelInboundHandler {
    public typealias InboundIn = AddressedEnvelope<ByteBuffer>

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let envelope = self.unwrapInboundIn(data)
        var buffer = envelope.data

        // To begin with, the chat messages are simply whole datagrams, no other length.
        guard let message = buffer.readString(length: buffer.readableBytes) else {
            print("Error: invalid string received")
            return
        }

        print("\(envelope.remoteAddress): \(message)")
    }
}
