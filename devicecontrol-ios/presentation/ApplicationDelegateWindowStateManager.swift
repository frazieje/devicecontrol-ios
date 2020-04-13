import Foundation

class ApplicationDelegateWindowStateManager : WindowStateManager, WindowStateObserver {
    
    private let concurrentQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.windowStateManager",
      attributes: .concurrent)

    var observers: [String : WindowStateObserver] = [:]

    func register(observer: WindowStateObserver) -> WindowStateSubscription {
        class Subscription : WindowStateSubscription {
            private let tag: String
            
            init() {
                let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
                tag = String((0..<8).map{ _ in letters.randomElement()! })
            }
            
            func getTag() -> String {
                return tag
            }
        }
        let subscription = Subscription()
        concurrentQueue.sync(flags: .barrier) {
            observers[subscription.getTag()] = observer
        }
        return subscription
    }
    
    func unregister(subscription: WindowStateSubscription) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.observers.removeValue(forKey: subscription.getTag())
        }
    }
    
    func willResignActive() {
        concurrentQueue.async { [weak self] in
            guard let self = self else { return }
            self.observers.values.forEach { observer in
                DispatchQueue.main.async {
                    observer.willResignActive()
                }
            }
        }
    }
    
    func didEnterBackground() {
        concurrentQueue.async { [weak self] in
            guard let self = self else { return }
            self.observers.values.forEach { observer in
                DispatchQueue.main.async {
                    observer.didEnterBackground()
                }
            }
        }
    }
    
    func willEnterForeground() {
        concurrentQueue.async { [weak self] in
            guard let self = self else { return }
            self.observers.values.forEach { observer in
                DispatchQueue.main.async {
                    observer.willEnterForeground()
                }
            }
        }
    }
    
    func didBecomeActive() {
        concurrentQueue.async { [weak self] in
            guard let self = self else { return }
            self.observers.values.forEach { observer in
                DispatchQueue.main.async {
                    observer.didBecomeActive()
                }
            }
        }
    }
    
    
    
}
