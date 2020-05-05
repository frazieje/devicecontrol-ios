import SQLite

struct SQLiteLoginToken : SQLiteTable {
    
    static let table = Table("loginTokens")

    static let id = Expression<Int64>("id")
    static let profileLoginId = Expression<Int64>("profileLoginId")
    static let clientId = Expression<String>("clientId")
    static let serverId = Expression<Int64>("serverId")
    static let tokenKey = Expression<String>("tokenKey")
    static let tokenType = Expression<String>("tokenType")
    static let refreshToken = Expression<String>("refreshToken")
    static let expiresIn = Expression<Int64>("expiresIn")
    static let issuedAt = Expression<Int64>("issuedAt")
    
    static func createIn(db: Connection) throws {

        try db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(tokenKey)
            t.column(profileLoginId)
            t.column(clientId)
            t.column(serverId)
            t.column(tokenType)
            t.column(refreshToken)
            t.column(expiresIn)
            t.column(issuedAt)
            t.foreignKey(profileLoginId, references: SQLiteProfileLogin.table, SQLiteProfileLogin.id, delete: .cascade)
            t.foreignKey(serverId, references: SQLiteProfileServer.table, SQLiteProfileServer.id, delete: .cascade)
        })
        
    }
}
