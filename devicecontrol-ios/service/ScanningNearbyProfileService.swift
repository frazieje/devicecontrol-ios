class ScanningNearbyProfileService : NearbyProfileService {
    
    let scanner: NearbyProfileScanner
    
    init(scanner: NearbyProfileScanner) {
        self.scanner = scanner
    }
    
    func register(listener: NearbyProfileListener) {
        
    }
    
    func unregister(listener: NearbyProfileListener) {
        
    }
    
    
}
