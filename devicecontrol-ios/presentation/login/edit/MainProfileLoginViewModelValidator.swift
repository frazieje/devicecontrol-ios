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
        
        for (index, serverStr) in viewModel.servers.enumerated() {
            
            if serverStr.isEmpty && index == 0 {
                result.errorMessageServers[index] = "Required field"
            } else {
            
                if let components = URLComponents(string: serverStr) {
                    let scheme = components.scheme?.lowercased() ?? "http"
                    let host = components.host ?? ""
                    
                    if scheme != "http" && scheme != "https" {
                        result.errorMessageServers[index] = "Must be http or https"
                    }
                    
                    if host.isEmpty {
                        result.errorMessageServers[index] = "Not a valid url"
                    }
                    
                } else {
                    result.errorMessageServers[index] = "Not a valid url"
                }
                
            }
            
        }
        
        result.isValid = result.errorMessageUsername != nil
                        || result.errorMessagePassword != nil
                        || result.errorMessageProfileId != nil
                        || result.errorMessagGeneric != nil
                        || !result.errorMessageServers.isEmpty
        
        return result
        
    }
    
}
