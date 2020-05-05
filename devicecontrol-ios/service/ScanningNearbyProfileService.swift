import Foundation

class ScanningNearbyProfileService : NearbyProfileService, ScanResultHandler {
    
    private let concurrentQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.scanningNearbyProfileService",
      attributes: .concurrent)
    
    private let concurrentCallbackQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.scanningNearbyProfileServiceCallbacks",
      attributes: .concurrent)

    let scanner: NearbyProfileScanner
    
    var observers: [String : ([String : [ProfileServer]]) -> Void] = [:]
    
    init(scanner: NearbyProfileScanner) {
        self.scanner = scanner
    }
    
    func register(_ listener: @escaping ([String : [ProfileServer]]) -> Void) -> NearbyProfileServiceSubscription {
        var subscription: Subscription?
        concurrentQueue.sync(flags: .barrier) {
            subscription = Subscription()
            observers[subscription!.getTag()] = listener
            if (!scanner.isScanning()) {
                scanner.scan(self)
            }
        }
        return subscription!
    }
    
    func unregister(_ subscription: NearbyProfileServiceSubscription) {
        concurrentQueue.sync(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.observers.removeValue(forKey: subscription.getTag())
            if (self.observers.isEmpty) {
                self.scanner.stop()
            }
        }
    }
    
    func onResult(_ result: [String : ServiceBeaconMessage]) {

        let results = result
        if !results.isEmpty {
            var servers: [String : [ProfileServer]] = [:]
            for (key, value) in results {
                var serverArray: [ProfileServer] = []
                serverArray.append(ProfileServer(host: key, port: value.apiPort, secure: false))
                if let remoteHost = value.replicationRemoteHost {
                    serverArray.append(ProfileServer(host: remoteHost, port: 443, secure: true))
                }
                servers[value.profileId] = serverArray
            }
            concurrentQueue.async { [weak self] in
                guard let self = self else { return }
                self.observers.values.forEach { observe in
                    self.concurrentCallbackQueue.async {
                        observe(servers)
                    }
                }
            }
        }
    
    }
    
    class Subscription : NearbyProfileServiceSubscription {
        private let tag: String
        
        init() {
            let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
            tag = String((0..<8).map{ _ in letters.randomElement()! })
        }
        
        func getTag() -> String {
            return tag
        }
    }
    
}
