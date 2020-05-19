import SQLite

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

            let profileloginRow = try db.pluck(SQLiteProfileLogin.table.filter(SQLiteProfileLogin.id == id))
            
            let profileLoginId = profileloginRow![SQLiteProfileLogin.id]
            
            var loginTokenHash: [ProfileServer : LoginToken] = [:]
            
            for token in try db.prepare(SQLiteLoginToken.table.filter(SQLiteLoginToken.profileLoginId == profileLoginId)) {
                
                let loginToken = LoginToken(
                                    clientId: token[SQLiteLoginToken.clientId],
                                    tokenKey: token[SQLiteLoginToken.tokenKey],
                                    tokenType: token[SQLiteLoginToken.tokenType],
                                    refreshToken: token[SQLiteLoginToken.refreshToken],
                                    expiresIn: token[SQLiteLoginToken.expiresIn],
                                    issuedAt: token[SQLiteLoginToken.issuedAt])
                
                let serverRow = try db.pluck(SQLiteProfileServer.table.filter(SQLiteProfileServer.id == token[SQLiteLoginToken.serverId]))!
                
                let profileServer = ProfileServer(
                    host: serverRow[SQLiteProfileServer.host],
                    port: serverRow[SQLiteProfileServer.port],
                    secure: serverRow[SQLiteProfileServer.secure])
                
                loginTokenHash[profileServer] = loginToken
                
            }
        
            result = ProfileLogin(
                            id: profileLoginId,
                            profileId: profileloginRow![SQLiteProfileLogin.profileId],
                            name: profileloginRow![SQLiteProfileLogin.name],
                            description: profileloginRow![SQLiteProfileLogin.description],
                            username: profileloginRow![SQLiteProfileLogin.username],
                            loginTokens: loginTokenHash)
            
        }
        
        return result!
        
    }
    
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func put(_ item: ProfileLogin) throws -> ProfileLogin {
        
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
                    SQLiteLoginToken.issuedAt <- value.issuedAt))
            }
            
        }
        
        return newLogin
    }
    
    func remove(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void) {
        
    }
    
}
