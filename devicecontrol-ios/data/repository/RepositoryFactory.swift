protocol RepositoryFactory {
    func getProfileLoginRepository() -> ProfileLoginRepository
    func getLoginTokenRepository() -> LoginTokenRepository
}
