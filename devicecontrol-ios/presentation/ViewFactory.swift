protocol ViewFactory {
    
    func getStarted(presenter: GetStartedPresenter) -> GetStartedView
    func nearbyProfileLogin(presenter: NearbyProfileLoginPresenter) -> NearbyProfileLoginView
    func editProfileLogin(presenter: EditProfileLoginPresenter) -> EditProfileLoginView
    func loginAction(presenter: LoginActionPresenter) -> LoginActionView
    
    func main(presenter: MainPresenter) -> MainView
    func menu(presenter: MenuPresenter) -> MenuView
    
    func devices(presenter: DevicesPresenter) -> DevicesView
    
    func home(presenter: HomePresenter) -> HomeView
    func settings(presenter: SettingsPresenter) -> SettingsView
    
}
