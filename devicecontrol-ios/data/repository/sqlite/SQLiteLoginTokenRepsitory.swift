import SQLite

class SQLiteLoginTokenRepository : LoginTokenRepository {
    
    let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func put(_ item: LoginToken, _ completion: @escaping (Bool) -> Void) {
        
        let loginTokens = SQLiteLoginToken.table
        
        let existingToken = loginTokens.filter(SQLiteLoginToken.tokenKey == item.tokenKey)
        
//        try db.run(existingToken.update(
//            SQLiteLoginToken.clientId <- item.clientId,
//            SQLiteLoginToken.
//        ))
    }

}

