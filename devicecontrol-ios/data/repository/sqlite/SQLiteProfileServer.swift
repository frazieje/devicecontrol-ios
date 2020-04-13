import SQLite

struct SQLiteProfileServer : SQLiteTable {
    
    static var table = Table("profileServers")
    
    static let id = Expression<String>("id")
    static let host = Expression<String>("host")
    static let port = Expression<Int>("port")
    static let remote = Expression<Bool>("remote")
    
    static func createIn(db: Connection) throws {
        try db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(host)
            t.column(port)
            t.column(remote)
        })
    }
}
