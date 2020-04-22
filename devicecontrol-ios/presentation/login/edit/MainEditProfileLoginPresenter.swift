import Foundation

class MainEditProfileLoginPresenter : EditProfileLoginPresenter {
    
    private let loginService: LoginService

    private let router: ProfileLoginRouter
    
    private var view: EditProfileLoginView?
    
    private var prefillServerItem: ProfileServerItem?
    
    private var advancedEnabled: Bool = false
    
    private let mapper: ProfileServerMapper
    
    private var loginInProgress: Bool = false
    
    init(loginService: LoginService, mapper: ProfileServerMapper, router: ProfileLoginRouter, _ item: ProfileServerItem?) {
        self.loginService = loginService
        self.router = router
        self.mapper = mapper
        self.prefillServerItem = item
        if item != nil {
            advancedEnabled = true
        }
    }
    
    func onViewAppear() {
        view?.prefill(with: mapper.from(serverItem: prefillServerItem))
    }
    
    func onViewDisappear() {
        
    }
    
    func advancedTapped() {
        if advancedEnabled {
            if view?.isAdvancedShown() == true {
                view?.hideAdvanced()
            } else {
                view?.showAdvanced()
            }
        }
    }
    
    func plusTapped() {
        if let item = view?.getCurrentItem() {
            if item.servers.count < 10 {
                view?.addServerField()
            }
        }
    }
    
    func minusTapped() {
        if let item = view?.getCurrentItem() {
            if item.servers.count > 1 {
                view?.removeServerField()
            }
        }
    }
    
    func loginTapped() {
        print("loginTapped")
        if !loginInProgress {
            tryLogin()
        }
    }
    
    func tryLogin() {
        
        view?.clearErrors()
        
        var hasError: Bool = false
        
        if let item = view?.getCurrentItem() {
            
            let username = item.username
            let password = item.password
            let profileId = item.profileId
            
            if username.isEmpty {
                hasError = true
                view?.showErrorUsername(errorString: "Required field")
            } else if !username.isEmail() {
                hasError = true
                view?.showErrorUsername(errorString: "Not a valid email address")
            }
            
            if password.isEmpty {
                hasError = true
                view?.showErrorPassword(errorString: "Required field")
            }
            
            if profileId.isEmpty {
                hasError = true
                view?.showErrorProfileId(errorString: "Required field")
            } else if !profileId.isProfileId() {
                hasError = true
                view?.showErrorProfileId(errorString: "Not a vald Profile ID")
            }
            
            var serverItems: [ProfileServer] = []
            
            for (index, serverStr) in item.servers.enumerated() {
                
                if serverStr.isEmpty && index == 0 {
                    hasError = true
                    view?.showErrorServer(index: index, errorString: "Required field")
                    return
                }
                
                if let components = URLComponents(string: serverStr) {
                    let scheme = components.scheme?.lowercased() ?? "http"
                    let secure = scheme == "https"
                    let host = components.host ?? ""
                    let port = components.port ?? (secure ? 443 : 80)
                    
                    if scheme != "http" && scheme != "https" {
                        hasError = true
                        view?.showErrorServer(index: index, errorString: "Must be http or https")
                    }
                    
                    if host.isEmpty {
                        hasError = true
                        view?.showErrorServer(index: index, errorString: "Not a valid url")
                    }
                    
                    serverItems.append(ProfileServer(host: host, port: port, secure: secure))
                } else {
                    hasError = true
                    view?.showErrorServer(index: index, errorString: "Not a valid url")
                }
            }
            
            if !hasError {
                login(username, password, profileId, serverItems)
            }
        }
    }
    
    func login(_ username: String, _ password: String,  _ profileId: String, _ servers: [ProfileServer]) {

        if !loginInProgress {
            print("login starting")
            loginInProgress = true
            loginService.login(username, password, profileId, servers) { result, error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if error == nil {
                        
                    }
                }
            }
        }
    }
    
    func setView(view: EditProfileLoginView) {
        self.view = view
    }
    
    
}
