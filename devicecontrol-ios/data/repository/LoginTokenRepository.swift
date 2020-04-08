protocol LoginTokenRepository {
    func put(_ item: LoginToken, _ completion: @escaping (Bool) -> Void)
}
