protocol ApiFactory {
    func oAuthApi(server: ProfileServer) -> OAuthApi
    func profileApi(login: ProfileLogin) -> ProfileApi
}
