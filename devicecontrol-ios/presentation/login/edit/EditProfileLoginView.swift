protocol EditProfileLoginView : View {
    func prefill(with: ProfileLoginViewModel?)
    func isAdvancedShown() -> Bool
    func showAdvanced()
    func hideAdvanced()
    func addServerField()
    func removeServerField()
    func showErrorUsername(errorString: String)
    func showErrorPassword(errorString: String)
    func showErrorProfileId(errorString: String)
    func showErrorServer(index: Int, errorString: String)
    func clearErrors()
    func getCurrentItem() -> ProfileLoginViewModel
}
