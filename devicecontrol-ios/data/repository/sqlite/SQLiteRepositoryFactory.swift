import SQLite

class SQLiteRepositoryFactory : RepositoryFactory {
    
    private let db: Connection
    
    init() throws {
        self.db = try Connection()
        try createTables()
    }
    
    init(dbPath: String) throws {
        self.db = try Connection("\(dbPath)/db.sqlite3")
        try createTables()
    }
    
    private func createTables() throws {
        try SQLiteProfileServer.createIn(db: db)
        try SQLiteProfileLogin.createIn(db: db)
        try SQLiteLoginToken.createIn(db: db)
    }
    
    func getProfileLoginRepository() -> ProfileLoginRepository {
        return SQLiteProfileLoginRepository(db: db)
    }
    
    func getLoginTokenRepository() -> LoginTokenRepository {
        return SQLiteLoginTokenRepository(db: db)
    }
    
    
}
