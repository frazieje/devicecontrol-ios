protocol ProfileLoginMapper {
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem]
    func from(profileId: String, servers: [ProfileServer]) -> ProfileServerItem
    func from(serverItem: ProfileServerItem?, user: String?) -> ProfileLoginViewModel?
    func from(viewModel: ProfileLoginViewModel) -> [String : ProfileLoginRequestItem]
    func from(viewModel: ProfileLoginViewModel) -> LoginRequest
    func from(serverUrls: [String]) -> [ProfileServer]
}
