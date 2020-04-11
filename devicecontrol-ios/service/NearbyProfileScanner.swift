protocol NearbyProfileScanner {
    func scan(_ resultHandler: ScanResultHandler)
    func stop()
}

protocol ScanResultHandler : AnyObject {
    func onResult(_ result: [String : ServiceBeaconMessage])
}
