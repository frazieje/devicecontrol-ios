import SQLite

struct SQLiteProfileLogin : SQLiteTable {
    
    static let table = Table("profileLogins")
    
    static let id = Expression<Int64>("id")
    static let profileId = Expression<String>("profileId")
    static let name = Expression<String?>("name")
    static let description = Expression<String?>("description")
    static let username = Expression<String>("username")
    
    static func createIn(db: Connection) throws {
        try db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(profileId)
            t.column(name)
            t.column(description)
            t.column(username)
        })
        
    }

}
