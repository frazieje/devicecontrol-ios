import Foundation

protocol ApiFactory {
    func oAuthApi(responseQueue: DispatchQueue, server: ProfileServer) -> OAuthApi
    func profileApi(responseQueue: DispatchQueue, login: ProfileLogin) -> ProfileApi
}
