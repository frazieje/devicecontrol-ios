import SQLite

class SQLiteProfileLoginRepository : ProfileLoginRepository {

    let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    func getBy(profileId: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getBy(profileName: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func put(_ item: ProfileLogin, _ completion: @escaping (Bool) -> Void) {
        
    }
    
    func remove(_ item: ProfileLogin, _ completion: @escaping (Bool) -> Void) {
        
    }
    
}
