protocol ServerResolver {
    func resolveFor(login: ProfileLogin) -> ProfileServer
}
