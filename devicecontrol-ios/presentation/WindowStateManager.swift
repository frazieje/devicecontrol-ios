protocol WindowStateManager : WindowStateController {
    func register(observer: WindowStateObserver) -> WindowStateSubscription
    func unregister(subscription: WindowStateSubscription)
}

protocol WindowStateController {
    func lockOrientationPortrait()
    func lockOrientationLandscape()
    func lockOrientationAll()
    func rotateToPortrait()
    func rotateToLandscape()
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
