class ProfileViewFactory : ViewFactory {

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
    
    func editProfileLogin(presenter: EditProfileLoginPresenter) -> EditProfileLoginView {
        let view = EditProfileLoginViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func loginAction(presenter: LoginActionPresenter) -> LoginActionView {
        let view = LoginActionViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func devices(presenter: DevicesPresenter) -> DevicesView {
        let view = DevicesViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func home(presenter: HomePresenter) -> HomeView {
        let view = HomeViewController()
        return view
    }
    
    func settings(presenter: SettingsPresenter) -> SettingsView {
        let view = SettingsViewController()
        return view
    }
    
    func main(presenter: MainPresenter) -> MainView {
        let view = MainViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func menu(presenter: MenuPresenter) -> MenuView {
        
        let view = ProfileMenuViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
}
