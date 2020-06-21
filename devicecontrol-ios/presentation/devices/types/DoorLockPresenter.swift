protocol DoorLockPresenter : Presenter {
    func onLock(item: DoorLock)
    func onUnlock(item: DoorLock)
    func setView(view: DoorLockView?)
}
