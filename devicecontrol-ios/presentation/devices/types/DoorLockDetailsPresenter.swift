protocol DoorLockDetailsPresenter : Presenter {
    func onLock()
    func onUnlock()
    func setView(view: DoorLockDetailsView?)
    func onMoreHistoryClicked()
}
