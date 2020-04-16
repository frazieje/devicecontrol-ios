protocol ProfileLoginPresenterFactory {
    func getStartedPresenter(router: ProfileLoginRouter) -> GetStartedPresenter
    func nearbyProfileLogin(router: ProfileLoginRouter) -> NearbyProfileLoginPresenter
    func editProfileLogin(router: ProfileLoginRouter) -> EditProfileLoginPresenter
}
