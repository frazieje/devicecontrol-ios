class ScanningNearbyProfileService : NearbyProfileService, ScanResultHandler {

    let scanner: NearbyProfileScanner
    
    var observers: WeakArray<NearbyProfileListener>
    
    init(scanner: NearbyProfileScanner) {
        self.scanner = scanner
        self.observers = WeakArray()
    }
    
    func register(listener: NearbyProfileListener) {
        
    }
    
    func unregister(listener: NearbyProfileListener) {
        
    }
    
    func onResult(_ result: [String : ServiceBeaconMessage]) {
        
    }
    
}
