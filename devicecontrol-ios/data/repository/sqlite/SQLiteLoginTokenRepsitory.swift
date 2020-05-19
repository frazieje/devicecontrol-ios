import SQLite

class SQLiteLoginTokenRepository : LoginTokenRepository {
    
    let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func put(_ item: LoginToken, _ completion: @escaping (Bool) -> Void) {
        
//        let loginTokens = SQLiteLoginToken.table
//
//        loginTokens.insert(or: .replace, )
//        
//
        
//        try db.run(existingToken.update(
//            SQLiteLoginToken.clientId <- item.clientId,
//            SQLiteLoginToken.
//        ))
    }

}

