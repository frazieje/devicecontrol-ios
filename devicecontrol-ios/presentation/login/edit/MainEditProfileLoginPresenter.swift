import Foundation

class MainEditProfileLoginPresenter : EditProfileLoginPresenter {
    
    private let loginService: LoginService

    private let router: ProfileLoginRouter
    
    private var view: EditProfileLoginView?
    
    private var prefillServerItem: ProfileServerItem?
    
    private var advancedEnabled: Bool = false
    
    private let mapper: ProfileServerMapper
    
    private let validator: ProfileLoginViewModelValidator
    
    private var loginInProgress: Bool = false
    
    init(loginService: LoginService, mapper: ProfileServerMapper, router: ProfileLoginRouter, validator: ProfileLoginViewModelValidator, _ item: ProfileServerItem? = nil) {
        self.loginService = loginService
        self.router = router
        self.mapper = mapper
        self.validator = validator
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

        if let item = view?.getCurrentItem() {
            
            let validationResult = validator.validate(viewModel: item)
            
            if validationResult.isValid {
                
                login(item.username, item.password, item.profileId, mapper.from(serverUrls: item.servers))
                
            } else {
                
                if let usernameError = validationResult.errorMessageUsername {
                    view?.showErrorUsername(errorString: usernameError)
                }
                
                if let passwordError = validationResult.errorMessagePassword {
                    view?.showErrorPassword(errorString: passwordError)
                }
                
                if let profileIdError = validationResult.errorMessageProfileId {
                    view?.showErrorProfileId(errorString: profileIdError)
                }
                
                for (index, serverError) in validationResult.errorMessageServers.enumerated() {
                    view?.showErrorServer(index: index, errorString: serverError)
                }
                
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
