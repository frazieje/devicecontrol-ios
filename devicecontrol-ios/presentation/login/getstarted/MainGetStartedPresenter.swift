class MainGetStartedPresenter : GetStartedPresenter {

    private let router: Router
    
    private var view: GetStartedView?
    
    private let windowStateManager: WindowStateManager
    
    init(windowStateManager: WindowStateManager, router: Router) {
        self.windowStateManager = windowStateManager
        self.router = router
    }
    
    func onViewLoad() {
        
    }
    
    func onViewAppear() {
        windowStateManager.lockOrientationPortrait()
        windowStateManager.rotateToPortrait()
    }
    
    func onViewDisappear() {
        windowStateManager.lockOrientationAll()
    }
    
    func setView(view: GetStartedView) {
        self.view = view
    }
    
    func findNearbyClicked() {
        if let strongView = view {
            router.routeToNearbyProfileLogin(from: strongView)
        }
    }
    
    func enterDetailsClicked() {
        if let strongView = view {
            router.routeToEditProfileLogin(from: strongView, item: nil)
        }
    }

}
