protocol LoginActionView : View {
    func prefill(with: [ProfileLoginRequestItem])
    func showRequests()
    func update(with: [ProfileLoginRequestItem])
}
