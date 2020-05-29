import SQLite

class SQLiteLoginTokenRepository : LoginTokenRepository {
    
    let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func put(_ item: LoginToken) throws -> LoginToken {
        
        if (item.id >= 0) {
            return try updateWith(item: item)
        } else {
            return try createWith(item: item)
        }
        
    }
    
    private func updateWith(item: LoginToken) throws -> LoginToken {
        
        let token = SQLiteLoginToken.table.filter(SQLiteLoginToken.id == item.id)
        
        try db.run(token.update(
            SQLiteLoginToken.tokenKey <- item.tokenKey,
            SQLiteLoginToken.clientId <- item.clientId,
            SQLiteLoginToken.tokenType <- item.tokenType,
            SQLiteLoginToken.refreshToken <- item.refreshToken,
            SQLiteLoginToken.expiresIn <- item.expiresIn,
            SQLiteLoginToken.issuedAt <- Int64(item.issuedAt.timeIntervalSince1970 * 1000)))
        
        return item
        
    }
    
    private func createWith(item: LoginToken) throws -> LoginToken {
        
        var newToken = LoginToken(
                            clientId: item.clientId,
                            tokenKey: item.tokenKey,
                            tokenType: item.tokenType,
                            refreshToken: item.refreshToken,
                            expiresIn: item.expiresIn,
                            issuedAt: item.issuedAt)
        
        newToken.clientId = item.clientId
        
        let newId = try db.run(SQLiteLoginToken.table.insert(
            SQLiteLoginToken.tokenKey <- newToken.tokenKey,
            SQLiteLoginToken.clientId <- newToken.clientId,
            SQLiteLoginToken.tokenType <- newToken.tokenType,
            SQLiteLoginToken.refreshToken <- newToken.refreshToken,
            SQLiteLoginToken.expiresIn <- newToken.expiresIn,
            SQLiteLoginToken.issuedAt <- Int64(newToken.issuedAt.timeIntervalSince1970 * 1000)))
        
        newToken.id = newId
        
        return newToken
        
    }

}

