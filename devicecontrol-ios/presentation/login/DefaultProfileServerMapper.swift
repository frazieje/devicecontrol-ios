class DefaultProfileServerMapper : ProfileServerMapper {
    
    func from(servers: [String : [ProfileServer]]) -> [ProfileServerItem] {
        var items: [ProfileServerItem] = []
        for (key, value) in servers {
            items.append(from(profileId: key, servers: value))
        }
        return items
    }
    
    private func from(profileId: String, servers: [ProfileServer]) -> ProfileServerItem {
        return servers.reduce(PendingProfileServerItem(profileId: profileId), { pending, next in
            var updated = pending
            updated.servers.append(ServerItem(host: next.host, port: next.port, secure: next.secure))
            return updated
            }).get()
    }
    
    func from(serverItem: ProfileServerItem?) -> ProfileLoginViewModel? {
        if let item = serverItem {
            let servers = item.servers.map { server in
                "http\(server.secure ? "s" : "")://\(server.host)\(server.port == 80 ? "" : ":\(server.port)")"
            }
            return ProfileLoginViewModel(username: "", password: "", profileId: item.profileId, servers: servers)
        } else {
            return nil
        }
    }
}

private struct PendingProfileServerItem {
    
    let profileId: String
    var servers: [ServerItem] = []
    
    func get() -> ProfileServerItem {
        return ProfileServerItem(profileId: profileId, servers: servers)
    }
    
}
