import Foundation

class DefaultProfileLoginMapper : ProfileLoginMapper {
    
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
            let servers = item.servers.map { server -> String in
                return from(host: server.host, port: server.port, secure: server.secure)
            }
            return ProfileLoginViewModel(username: "", password: "", profileId: item.profileId, servers: servers)
        } else {
            return nil
        }
    }
    
    private func from(host: String, port: Int, secure: Bool) -> String {
        return ProfileServer(host: host, port: port, secure: secure).toString()
    }
    
    func from(viewModel: ProfileLoginViewModel) -> LoginRequest {
        return LoginRequest(username: viewModel.username, password: viewModel.password, profileId: viewModel.profileId, servers: from(serverUrls: viewModel.servers))
    }
    
    func from(serverUrls: [String]) -> [ProfileServer] {
        
        return serverUrls.map { serverUrl in
            
            var url = serverUrl.lowercased()
            
            if !url.starts(with: "http://") && !url.starts(with: "https://") {
                url = "http://" + url
            }
            let components = URLComponents(string: url)!
            let scheme = components.scheme!.lowercased()
            let secure = scheme == "https"
            let host = components.host!
            let port = components.port ?? (secure ? 443 : 80)
                
            return ProfileServer(host: host, port: port, secure: secure)
                
        }
        
    }
    
    func from(viewModel: ProfileLoginViewModel) -> [String : ProfileLoginRequestItem] {
        var requestItems: [String : ProfileLoginRequestItem] = [:]
        viewModel.servers.forEach { requestItems[$0] = ProfileLoginRequestItem(serverUrl: $0, status: .ready) }
        return requestItems
    }
    
}

private struct PendingProfileServerItem {
    
    let profileId: String
    var servers: [ServerItem] = []
    
    func get() -> ProfileServerItem {
        return ProfileServerItem(profileId: profileId, servers: servers)
    }
    
}
