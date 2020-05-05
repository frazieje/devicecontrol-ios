import SQLite

struct SQLiteProfileServer : SQLiteTable {
    
    static var table = Table("profileServers")
    
    static let id = Expression<Int64>("id")
    static let host = Expression<String>("host")
    static let port = Expression<Int>("port")
    static let secure = Expression<Bool>("secure")
    
    static func createIn(db: Connection) throws {
        try db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(host)
            t.column(port)
            t.column(secure)
        })
    }
}
