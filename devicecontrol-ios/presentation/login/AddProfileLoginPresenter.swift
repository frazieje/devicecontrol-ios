protocol AddProfileLoginPresenter : Presenter {
    func setView(view: AddProfileLoginView)
    func serverItemClicked(_ item: ProfileServerItem)
}
