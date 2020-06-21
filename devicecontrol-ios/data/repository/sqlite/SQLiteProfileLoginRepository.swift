import SQLite
import Foundation

class SQLiteProfileLoginRepository : ProfileLoginRepository {
    
    let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func getBy(profileId: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getBy(profileName: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getBy(id: Int64) throws -> ProfileLogin {

        var result: ProfileLogin?
        
        try db.transaction {

            let row = try db.pluck(SQLiteProfileLogin.table.filter(SQLiteProfileLogin.id == id))
            
            guard let profileLoginRow = row else { throw RepositoryError.recordNotFound }
            
            let profileLoginId = profileLoginRow[SQLiteProfileLogin.id]
            
            var loginTokenHash: [ProfileServer : LoginToken] = [:]
            
            for token in try db.prepare(SQLiteLoginToken.table.filter(SQLiteLoginToken.profileLoginId == profileLoginId)) {

                let loginToken = LoginToken(
                                    id: token[SQLiteLoginToken.id],
                                    clientId: token[SQLiteLoginToken.clientId],
                                    tokenKey: token[SQLiteLoginToken.tokenKey],
                                    tokenType: token[SQLiteLoginToken.tokenType],
                                    refreshToken: token[SQLiteLoginToken.refreshToken],
                                    expiresIn: token[SQLiteLoginToken.expiresIn],
                                    issuedAt: Date(timeIntervalSince1970: Double(token[SQLiteLoginToken.issuedAt] / 1000)))
                
                let serverRow = try db.pluck(SQLiteProfileServer.table.filter(SQLiteProfileServer.id == token[SQLiteLoginToken.serverId]))!
                
                let profileServer = ProfileServer(
                    id: serverRow[SQLiteProfileServer.id],
                    host: serverRow[SQLiteProfileServer.host],
                    port: serverRow[SQLiteProfileServer.port],
                    secure: serverRow[SQLiteProfileServer.secure])
                
                loginTokenHash[profileServer] = loginToken
                
            }
        
            result = ProfileLogin(
                            id: profileLoginId,
                            profileId: profileLoginRow[SQLiteProfileLogin.profileId],
                            name: profileLoginRow[SQLiteProfileLogin.name],
                            description: profileLoginRow[SQLiteProfileLogin.description],
                            username: profileLoginRow[SQLiteProfileLogin.username],
                            loginTokens: loginTokenHash)
            
        }
        
        if let result = result {
        
            return result
            
        } else {
            
            throw RepositoryError.recordNotFound
            
        }
        
    }
    
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func put(_ item: ProfileLogin) throws -> ProfileLogin {
        
        if item.id >= 0 {
            
            return try updateWith(item: item)
            
        } else {
            
            return try createWith(item: item)
            
        }
    }
    
    func remove(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void) {
        
    }
    
    private func createWith(item: ProfileLogin) throws -> ProfileLogin {
        
        var newLogin = ProfileLogin(profileId: item.profileId, name: item.name, description: item.description, username: item.username, loginTokens: item.loginTokens)
        
        try db.transaction {
            
            let profileLoginId = try db.run(SQLiteProfileLogin.table.insert(
                SQLiteProfileLogin.profileId <- newLogin.profileId,
                SQLiteProfileLogin.username <- newLogin.username))
            
            newLogin.id = profileLoginId
            
            try item.loginTokens.forEach { key, value in
                
                let profileServerId = try db.run(SQLiteProfileServer.table.insert(
                    SQLiteProfileServer.host <- key.host,
                    SQLiteProfileServer.port <- key.port,
                    SQLiteProfileServer.secure <- key.secure))
                
                try db.run(SQLiteLoginToken.table.insert(
                    SQLiteLoginToken.tokenKey <- value.tokenKey,
                    SQLiteLoginToken.profileLoginId <- profileLoginId,
                    SQLiteLoginToken.clientId <- newLogin.profileId,
                    SQLiteLoginToken.serverId <- profileServerId,
                    SQLiteLoginToken.tokenType <- value.tokenType,
                    SQLiteLoginToken.refreshToken <- value.refreshToken,
                    SQLiteLoginToken.expiresIn <- value.expiresIn,
                    SQLiteLoginToken.issuedAt <- Int64(value.issuedAt.timeIntervalSince1970 * 1000)))
            }
            
        }
        
        return newLogin
    }
    
    private func updateWith(item: ProfileLogin) throws -> ProfileLogin {
        
        try db.transaction {
            
            let record = SQLiteProfileLogin.table.filter(SQLiteProfileLogin.id == item.id)
            
            try db.run(record.update(
                SQLiteProfileLogin.profileId <- item.profileId,
                SQLiteProfileLogin.username <- item.username))
            
            try item.loginTokens.forEach { key, value in
                
                if key.id >= 0 {
                    
                    let server = SQLiteProfileServer.table.filter(SQLiteProfileServer.id == key.id)
                
                    try db.run(server.update(
                        SQLiteProfileServer.host <- key.host,
                        SQLiteProfileServer.port <- key.port,
                        SQLiteProfileServer.secure <- key.secure))
                    
                    if value.id >= 0 {
                        
                        let token = SQLiteLoginToken.table.filter(SQLiteLoginToken.id == value.id)
                    
                        try db.run(token.update(
                            SQLiteLoginToken.tokenKey <- value.tokenKey,
                            SQLiteLoginToken.profileLoginId <- item.id,
                            SQLiteLoginToken.clientId <- value.clientId,
                            SQLiteLoginToken.serverId <- key.id,
                            SQLiteLoginToken.tokenType <- value.tokenType,
                            SQLiteLoginToken.refreshToken <- value.refreshToken,
                            SQLiteLoginToken.expiresIn <- value.expiresIn,
                            SQLiteLoginToken.issuedAt <- Int64(value.issuedAt.timeIntervalSince1970 * 1000)))
                        
                    }
                    
                }
                
            }
            
        }
        
        return item
    }
    
}
