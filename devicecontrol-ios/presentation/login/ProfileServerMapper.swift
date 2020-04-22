protocol ProfileServerMapper {
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem]
    func from(serverItem: ProfileServerItem?) -> ProfileLoginViewModel?
    func from(serverUrls: [String]) -> [ProfileServer]
}
