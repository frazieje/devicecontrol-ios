class ProfileServerResolver : ServerResolver {
    
    func resolveFor(login: ProfileLogin) -> ProfileServer {
        return login.loginTokens.filter {
            try! $0.key.asURL().absoluteString.hasPrefix("https://www.spoohapps.com")
            }.first!.key
//        return login.loginTokens.first!.key
    }
    
}
