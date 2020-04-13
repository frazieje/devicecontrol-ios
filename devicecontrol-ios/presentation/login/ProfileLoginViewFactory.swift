protocol ProfileLoginViewFactory : ViewFactory {
    func addProfileLogin(presenter: AddProfileLoginPresenter) -> AddProfileLoginView
    func editProfileLogin(presenter: EditProfileLoginPresenter, _ item: ProfileServerItem?) -> EditProfileLoginView
}
