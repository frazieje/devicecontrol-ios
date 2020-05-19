protocol LoginActionPresenter : Presenter {
    func setView(view: LoginActionView)
    func onViewReady()
    func onViewFinished()
}
