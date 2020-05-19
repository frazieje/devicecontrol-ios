import Foundation

class MainNearbyProfileLoginPresenter : NearbyProfileLoginPresenter, WindowStateObserver {

    private let nearbyProfileService: NearbyProfileService
    
    private var view: NearbyProfileLoginView?
    
    private let mapper: ProfileLoginMapper
    
    private let windowStateManager: WindowStateManager
    
    private var nearbyProfileSubscription: NearbyProfileServiceSubscription?
    
    private var windowStateSubscription: WindowStateSubscription?
    
    private let router: Router
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService, mapper: ProfileLoginMapper, router: Router) {
        self.nearbyProfileService = nearbyProfileService
        self.mapper = mapper
        self.windowStateManager = windowStateManager
        self.router = router
    }
    
    func setView(view: NearbyProfileLoginView) {
        self.view = view
    }
    
    func onViewLoad() {
        
    }
    
    func onViewAppear() {
        windowStateManager.lockOrientationPortrait()
        windowStateManager.rotateToPortrait()
        subscribeWindowStateEvents()
        subscribeNearbyProfileEvents()
    }
    
    func onViewDisappear() {
        unsubscribeNearbyProfileEvents()
        unsubscribeWindowStateEvents()
        windowStateManager.lockOrientationAll()
    }
    
    func serverItemClicked(_ item: ProfileServerItem) {
        if let strongView = view {
            router.routeToEditProfileLogin(from: strongView, item: item)
        }
    }
    
    private func showItems(_ results: [String : [ProfileServer]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showItems(self.mapper.from(servers: results))
        }
    }
    
    func subscribeWindowStateEvents() {
        print("add profile try subscribe to window state events")
        if windowStateSubscription == nil {
            print("add profile subscribe to window state events")
            windowStateSubscription = windowStateManager.register(observer: self)
        }
    }
    
    func unsubscribeWindowStateEvents() {
        print("add profile try unsubscribe from window state events")
        if let subscription = windowStateSubscription {
            print("add profile presenter unregistering from window state events")
            windowStateManager.unregister(subscription: subscription)
            windowStateSubscription = nil
        }
    }
    
    func subscribeNearbyProfileEvents() {
        print("add profile try subscribe to nearby profile events")
        if nearbyProfileSubscription == nil {
            print("add profile subscribed to nearby profile events")
            nearbyProfileSubscription = nearbyProfileService.register { [weak self] results in
                guard let self = self else { return }
                self.showItems(results)
            }
        }
    }
    
    func unsubscribeNearbyProfileEvents() {
        print("add profile try unsubscribe from nearby profile events")
        if let subscription = nearbyProfileSubscription {
            print("add profile presenter unregistering")
            nearbyProfileService.unregister(subscription)
            nearbyProfileSubscription = nil
        }
    }
    
    func willResignActive() {
        unsubscribeNearbyProfileEvents()
        unsubscribeWindowStateEvents()
    }
    
    func didEnterBackground() {
        
    }
    
    func willEnterForeground() {
        
    }
    
    func didBecomeActive() {
        subscribeWindowStateEvents()
        subscribeNearbyProfileEvents()
    }
    

    
}
