import Foundation

class MainLoginActionPresenter : LoginActionPresenter {

    private let loginService: LoginService
    
    private let router: Router
    
    private let mapper: ProfileLoginMapper
    
    private let item: ProfileLoginViewModel
    
    private var view: LoginActionView?
    
    private let windowStateManager: WindowStateManager
    
    private var requestItems: [String : ProfileLoginRequestItem]
    
    init(loginService: LoginService, windowStateManager: WindowStateManager, router: Router, mapper: ProfileLoginMapper, item: ProfileLoginViewModel) {
        self.loginService = loginService
        self.windowStateManager = windowStateManager
        self.router = router
        self.mapper = mapper
        self.item = item
        requestItems = mapper.from(viewModel: item)
    }
    
    func setView(view: LoginActionView) {
        self.view = view
    }
    
    func onViewLoad() {
        requestItems.keys.forEach { url in
            requestItems[url]?.status = .inProgress
        }
        view?.prefill(with: requestItems.compactMap { $1 })
    }
    
    func onViewAppear() {
        windowStateManager.lockOrientationPortrait()
        windowStateManager.rotateToPortrait()
        view?.showRequests()
    }
    
    func onViewReady() {
        loginService.login(mapper.from(viewModel: item), onResult(result:), onComplete(results:))
    }
    
    private func onResult(result: LoginResult) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.requestItems[result.server.toString()]?.status = result.error == nil ? .succeeded : .failed
            self.updateItems()
        }
    }
    
    func onViewFinished() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("done")
        }
    }
    
    private func onComplete(results: [LoginResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let errors = results.filter { $0.error != nil }.map { $0.error!.message }
            if errors.count < results.count {
                if errors.isEmpty {
                    self.view?.showSuccess()
                } else {
                    self.view?.showPartialSuccess(errors: errors)
                }
            } else {
                self.view?.showError(errors: errors)
            }
        }
    }
    
    private func updateItems() {
        view?.updateItems(with: requestItems.compactMap { $1 })
    }
    
    func onViewDisappear() {
        windowStateManager.lockOrientationAll()
    }
    
    
}
