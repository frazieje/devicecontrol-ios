protocol ProfileLoginRouter : Router {
    func routeToNearbyProfileLogin(from: View)
    func routeToEditProfileLogin(from: View, item: ProfileServerItem?)
    func routeToLoginAction(from: View, item: ProfileLoginViewModel)
}
