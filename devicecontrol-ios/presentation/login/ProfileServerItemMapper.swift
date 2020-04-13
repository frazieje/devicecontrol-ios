class ProfileServerItemMapper : ServerItemMapper {
    
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem] {
        var items: [ProfileServerItem] = []
        for (key, value) in servers {
            items.append(from(profileId: key, servers: value))
        }
        return items
    }
    
    func from(profileId: String, servers: [ProfileServer]) -> ProfileServerItem {
        return servers.reduce(PendingProfileServerItem(profileId: profileId), { pending, next in
            var result = pending
            if (next.remote) {
                result.remoteHost = next.host
                result.remotePort = next.port
            } else {
                result.host = next.host
                result.port = next.port
            }
            return result
            }).get()
    }
}

private struct PendingProfileServerItem {
    var profileId: String
    var host: String?
    var port: Int?
    var remoteHost: String?
    var remotePort: Int?
    
    func get() -> ProfileServerItem {
        return ProfileServerItem(profileId: profileId, host: host!, port: port!, remoteHost: remoteHost, remotePort: remotePort)
    }
}
