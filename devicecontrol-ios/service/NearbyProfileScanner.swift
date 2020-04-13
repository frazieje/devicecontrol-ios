protocol NearbyProfileScanner {
    func scan(_ resultHandler: ScanResultHandler)
    func isScanning() -> Bool
    func stop()
}

protocol ScanResultHandler : class {
    func onResult(_ result: [String : ServiceBeaconMessage])
}
