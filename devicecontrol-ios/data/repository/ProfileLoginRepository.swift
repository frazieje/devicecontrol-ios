protocol ProfileLoginRepository {
    func getBy(profileId: String, _ completion: @escaping ([ProfileLogin]) -> Void)
    func getBy(profileName: String, _ completion: @escaping ([ProfileLogin]) -> Void)
    func getBy(id: Int64) throws -> ProfileLogin
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void)
    func put(_ item: ProfileLogin) throws -> ProfileLogin
    func remove(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void)
}
