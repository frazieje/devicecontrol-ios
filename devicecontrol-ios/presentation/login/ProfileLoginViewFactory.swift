protocol ProfileLoginViewFactory : ViewFactory {
    func getStarted(presenter: GetStartedPresenter) -> GetStartedView
    func nearbyProfileLogin(presenter: NearbyProfileLoginPresenter) -> NearbyProfileLoginView
    func editProfileLogin(presenter: EditProfileLoginPresenter, _ item: ProfileServerItem?) -> EditProfileLoginView
}
