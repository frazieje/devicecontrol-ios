import SQLite

protocol SQLiteTable {
    static var table: Table { get }
    static func createIn(db: Connection) throws -> Void
}
