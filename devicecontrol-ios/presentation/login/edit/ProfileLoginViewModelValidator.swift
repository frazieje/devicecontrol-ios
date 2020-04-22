protocol ProfileLoginViewModelValidator {
    func validate(viewModel: ProfileLoginViewModel) -> ValidationResult
}

struct ValidationResult {
    var errorMessageUsername: String?
    var errorMessagePassword: String?
    var errorMessageProfileId: String?
    var errorMessageServers: [String?]
    var errorMessagGeneric: String?
    var isValid: Bool
}
