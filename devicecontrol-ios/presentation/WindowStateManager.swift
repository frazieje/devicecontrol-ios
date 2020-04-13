protocol WindowStateManager {
    func register(observer: WindowStateObserver) -> WindowStateSubscription
    func unregister(subscription: WindowStateSubscription)
}

protocol WindowStateSubscription {
    func getTag() -> String
}

protocol WindowStateObserver {
    func willResignActive()
    func didEnterBackground()
    func willEnterForeground()
    func didBecomeActive()
}
