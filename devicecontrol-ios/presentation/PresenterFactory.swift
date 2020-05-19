protocol PresenterFactory {
    
    func getStartedPresenter(router: Router) -> GetStartedPresenter
    func nearbyProfileLogin(router: Router) -> NearbyProfileLoginPresenter
    func editProfileLogin(router: Router, _ item: ProfileServerItem?) -> EditProfileLoginPresenter
    func loginAction(router: Router, item: ProfileLoginViewModel) -> LoginActionPresenter
    
    func main(router: Router) -> MainPresenter
    func menu(router: Router) -> MenuPresenter
}
