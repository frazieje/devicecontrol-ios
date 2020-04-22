import Foundation

class MainProfileLoginViewModelValidator : ProfileLoginViewModelValidator {
    
    func validate(viewModel: ProfileLoginViewModel) -> ValidationResult {
        
        var result: ValidationResult = ValidationResult(
                        errorMessageUsername: nil,
                        errorMessagePassword: nil,
                        errorMessageProfileId: nil,
                        errorMessageServers: [],
                        errorMessagGeneric: nil,
                        isValid: true)
        
        let username = viewModel.username
        let password = viewModel.password
        let profileId = viewModel.profileId
        
        if username.isEmpty {
            result.errorMessageUsername = "Required field"
        } else if !username.isEmail() {
            result.errorMessageUsername = "Not a valid email address"
        }
        
        if password.isEmpty {
            result.errorMessagePassword = "Required field"
        }
        
        if profileId.isEmpty {
            result.errorMessageProfileId = "Required field"
        } else if !profileId.isProfileId() {
            result.errorMessageProfileId = "Not a vald Profile ID"
        }
        
        viewModel.servers.forEach { serverStr in
            
            var serverError: String? = nil
            
            if serverStr.isEmpty {
                serverError = "Required field"
            } else {
            
                if let components = URLComponents(string: serverStr) {
                    let scheme = components.scheme?.lowercased() ?? "http"
                    let host = components.host ?? components.path
                    
                    if scheme != "http" && scheme != "https" {
                        serverError = "Must be http or https"
                    }
                    
                    if host.isEmpty {
                        serverError = "Not a valid url"
                    }
                    
                } else {
                    serverError = "Not a valid url"
                }
                
            }
            
            result.errorMessageServers.append(serverError)
            
        }
        
        let hasError = result.errorMessageUsername != nil
                        || result.errorMessagePassword != nil
                        || result.errorMessageProfileId != nil
                        || result.errorMessagGeneric != nil
                        || result.errorMessageServers.filter { s in s != nil }.count > 0
        
        result.isValid = !hasError
        
        return result
        
    }
    
}
