protocol ProfileLoginRepository {
    func getBy(profileId: String, _ completion: @escaping ([ProfileLogin]) -> Void)
    func getBy(profileName: String, _ completion: @escaping ([ProfileLogin]) -> Void)
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void)
    func put(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void)
    func remove(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void)
}
