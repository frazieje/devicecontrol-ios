protocol DoorLockDetailsView : DoorLockView {
    func showDeviceLog(messages: [DoorLockStateChange])
}
