import SQLite

struct SQLiteLoginToken : SQLiteTable {
    
    static let table = Table("loginTokens")

    static let profileLoginId = Expression<String>("profileLoginId")
    static let clientId = Expression<String>("clientId")
    static let serverId = Expression<String>("serverId")
    static let tokenKey = Expression<String>("tokenKey")
    static let tokenType = Expression<String>("tokenType")
    static let refreshToken = Expression<String>("refreshToken")
    static let expiresIn = Expression<Int64>("expiresIn")
    static let issuedAt = Expression<Int64>("issuedAt")
    
    static func createIn(db: Connection) throws {
        try db.run(table.create { t in
            t.column(tokenKey, primaryKey: true)
            t.column(profileLoginId)
            t.foreignKey(profileLoginId, references: SQLiteProfileLogin.table, SQLiteProfileLogin.id, delete: .cascade)
            t.column(clientId)
            t.column(serverId)
            t.foreignKey(serverId, references: SQLiteProfileServer.table, SQLiteProfileServer.id, delete: .cascade)
            t.column(tokenType)
            t.column(refreshToken)
            t.column(expiresIn)
            t.column(issuedAt)
        })
    }
}
