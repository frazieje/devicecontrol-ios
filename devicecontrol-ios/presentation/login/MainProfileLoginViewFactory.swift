class MainProfileLoginViewFactory : ProfileLoginViewFactory {
    
    func getStarted(presenter: GetStartedPresenter) -> GetStartedView {
        let view = GetStartedViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func nearbyProfileLogin(presenter: NearbyProfileLoginPresenter) -> NearbyProfileLoginView {
        let view = NearbyProfileLoginViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func editProfileLogin(presenter: EditProfileLoginPresenter, _ item: ProfileServerItem?) -> EditProfileLoginView {
        let view = EditProfileLoginViewController(presenter: presenter)
        presenter.setView(view: view)
        if let strongItem = item {
            view.prefill(with: strongItem)
        }
        return view
    }
    
}
