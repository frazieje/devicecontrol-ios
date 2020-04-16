protocol NearbyProfileLoginPresenter : Presenter {
    func setView(view: NearbyProfileLoginView)
    func serverItemClicked(_ item: ProfileServerItem)
}
