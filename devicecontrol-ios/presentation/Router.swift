protocol Router {
    
    func routeToMain()
    func routeToGetStarted()
    func routeToNearbyProfileLogin(from: View)
    func routeToEditProfileLogin(from: View, item: ProfileServerItem?)
    func routeToLoginAction(from: View, item: ProfileLoginViewModel)
    
    func showMenu()
    func hideMenu()
}
