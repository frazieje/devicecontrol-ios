protocol DevicesView : View {
    func showDevices(devices: [ProfileDevice])
    func showError(message: String)
}
