class MainLoginActionPresenter : LoginActionPresenter {
    
    private let loginService: LoginService
    
    private let router: ProfileLoginRouter
    
    private let mapper: ProfileLoginMapper
    
    private let item: ProfileLoginViewModel
    
    private var view: LoginActionView?
    
    private var requestItems: [String : ProfileLoginRequestItem]
    
    init(loginService: LoginService, router: ProfileLoginRouter, mapper: ProfileLoginMapper, item: ProfileLoginViewModel) {
        self.loginService = loginService
        self.router = router
        self.mapper = mapper
        self.item = item
        requestItems = mapper.from(viewModel: item)
    }
    
    func setView(view: LoginActionView) {
        self.view = view
    }
    
    func onViewLoad() {
        view?.prefill(with: requestItems.compactMap { $1 })
    }
    
    func onViewAppear() {
        view?.showRequests()
    }
    
    func onViewReady() {
        requestItems.keys.forEach { url in
            requestItems[url]?.status = .inProgress
        }
        updateItems()
//        loginService.login(mapper.from(viewModel: item), { [weak self] result in
//            guard let self = self else { return }
//            self.requestItems[result.server.toString()]?.status = result.error == nil ? .succeeded : .failed
//            self.updateItems()
//        }) { results in
//            print("presenter requests done")
//        }
    }
    
    private func updateItems() {
        view?.update(with: requestItems.compactMap { $1 })
    }
    
    func onViewDisappear() {
        print("login action view disappear")
    }
    
    
}
