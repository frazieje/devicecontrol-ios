import Foundation

class MainEditProfileLoginPresenter : EditProfileLoginPresenter {
    
    private let router: Router
    
    private var view: EditProfileLoginView?
    
    private var prefillServerItem: ProfileServerItem?
    
    private var advancedEnabled: Bool = false
    
    private let mapper: ProfileLoginMapper
    
    private let validator: ProfileLoginViewModelValidator
    
    private var loginInProgress: Bool = false
    
    init(mapper: ProfileLoginMapper, router: Router, validator: ProfileLoginViewModelValidator, _ item: ProfileServerItem? = nil) {
        self.router = router
        self.mapper = mapper
        self.validator = validator
        self.prefillServerItem = item
        if item != nil {
            advancedEnabled = true
        }
    }
    
    func onViewLoad() {
        print("presenter view load")
        view?.prefill(with: mapper.from(serverItem: prefillServerItem))
    }
    
    func onViewAppear() {
        print("presenter view appear")
    }
    
    func onViewDisappear() {
        loginInProgress = false
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
            if item.servers.count <= 4 {
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
                
                login(viewModel: item)
                
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
                    if let strongError = serverError {
                        view?.showErrorServer(index: index, errorString: strongError)
                    }
                }
                
            }
        }
    }
    
    func login(viewModel: ProfileLoginViewModel) {

        if !loginInProgress {
            print("login starting")
            loginInProgress = true
            if let strongView = view {
                router.routeToLoginAction(from: strongView, item: viewModel)
            }
        }
        
    }
    
    func setView(view: EditProfileLoginView) {
        self.view = view
    }
    
    
}
