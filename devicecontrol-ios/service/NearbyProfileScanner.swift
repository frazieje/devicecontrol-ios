protocol NearbyProfileScanner {
    func scan(_ resultConsumer: @escaping ([ServiceBeaconMessage]) -> Void)
    func stop()
}
