import SQLite

class SQLiteRepositoryFactory : RepositoryFactory {
    
    let db: Connection
    
    init() throws {
        self.db = try Connection()
    }
    
    init(dbPath: String) throws {
        self.db = try Connection("\(dbPath)/db.sqlite3")
    }
    
    func getProfileLoginRepository() -> ProfileLoginRepository {
        return SQLiteProfileLoginRepository(db: db)
    }
    
    func getLoginTokenRepository() -> LoginTokenRepository {
        return SQLiteLoginTokenRepository(db: db)
    }
    
    
}
