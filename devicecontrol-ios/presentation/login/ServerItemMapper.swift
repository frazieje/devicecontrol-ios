protocol ServerItemMapper {
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem]
}
