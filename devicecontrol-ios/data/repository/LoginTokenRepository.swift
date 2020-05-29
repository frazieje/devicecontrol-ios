protocol LoginTokenRepository {
    func put(_ item: LoginToken) throws -> LoginToken
}
