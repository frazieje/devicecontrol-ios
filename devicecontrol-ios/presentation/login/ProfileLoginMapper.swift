protocol ProfileLoginMapper {
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem]
    func from(serverItem: ProfileServerItem?) -> ProfileLoginViewModel?
    func from(viewModel: ProfileLoginViewModel) -> [String : ProfileLoginRequestItem]
    func from(viewModel: ProfileLoginViewModel) -> LoginRequest
}
