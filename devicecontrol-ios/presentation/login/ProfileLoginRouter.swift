protocol ProfileLoginRouter : Router {
    func routeToAddProfileLogin(from: View)
    func routeToEditProfileLogin(from: View, _ item: ProfileServerItem?)
}
