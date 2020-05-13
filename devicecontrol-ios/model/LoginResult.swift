struct LoginResult {
    var error: LoginServiceError?
    var server: ProfileServer
    var token: LoginToken?
}
