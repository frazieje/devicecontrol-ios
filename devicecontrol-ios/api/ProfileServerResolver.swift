class ProfileServerResolver : ServerResolver {
    
    func resolveFor(login: ProfileLogin) -> ProfileServer {
        return login.loginTokens.first!.key
    }
    
}
