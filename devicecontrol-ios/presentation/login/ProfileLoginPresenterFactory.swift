protocol ProfileLoginPresenterFactory {
    func addProfileLogin(router: ProfileLoginRouter) -> AddProfileLoginPresenter
    func editProfileLogin(router: ProfileLoginRouter) -> EditProfileLoginPresenter
}
