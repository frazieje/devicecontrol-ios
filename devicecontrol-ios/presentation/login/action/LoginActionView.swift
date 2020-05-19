protocol LoginActionView : View {
    func prefill(with: [ProfileLoginRequestItem])
    func showRequests()
    func updateItems(with: [ProfileLoginRequestItem])
    func showSuccess()
    func showPartialSuccess(errors: [String])
    func showError(errors: [String])
}
