protocol DoorLockView : View {
    func show(lock: DoorLock)
    func showError(message: String?)
}
