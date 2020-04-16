protocol ProfileLoginPresenterFactory {
    func nearbyProfileLogin(router: ProfileLoginRouter) -> NearbyProfileLoginPresenter
    func editProfileLogin(router: ProfileLoginRouter) -> EditProfileLoginPresenter
}
