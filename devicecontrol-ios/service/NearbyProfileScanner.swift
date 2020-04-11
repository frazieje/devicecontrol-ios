protocol NearbyProfileScanner {
    func scan(_ resultHandler: ScanResultHandler)
    func stop()
}

protocol ScanResultHandler : class {
    func onResult(_ result: [String : ServiceBeaconMessage])
}
