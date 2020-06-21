import Foundation

class ProfileDoorLockPresenter : DoorLockPresenter {

    var view: DoorLockView?
    
    private let router: Router
    
    private let deviceService: DeviceService
    
    init(router: Router, deviceService: DeviceService) {
        self.router = router
        self.deviceService = deviceService
    }
    
    func setView(view: DoorLockView?) {
        self.view = view
    }
    
    func onViewLoad() {
        
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func onLock(item: DoorLock) {
        if item.state == .unlocked, let lockDoor = item.messageFor(lockState: .locked) {
            deviceService.publish(message: lockDoor) { [weak self] error in
                guard let self = self else { return }
                
                if error == nil {
                    var lock = item
                    lock.state = .locked
                    lock.lastStateChange = Date()
                    self.updateLock(item: lock)
                } else {
                    self.showError(message: error?.message)
                }
            }
        }
    }
    
    func onUnlock(item: DoorLock) {
        if item.state == .locked, let unlockDoor = item.messageFor(lockState: .unlocked) {
            deviceService.publish(message: unlockDoor) { [weak self] error in
                
                guard let self = self else { return }
                
                if error == nil {
                    var lock = item
                    lock.state = .unlocked
                    lock.lastStateChange = Date()
                    self.updateLock(item: lock)
                } else {
                    self.showError(message: error?.message)
                }
            }
        }
    }
    
    func updateLock(item: DoorLock) {
        DispatchQueue.main.async {
            self.view?.show(lock: item)
        }
    }
    
    func showError(message: String?) {
        DispatchQueue.main.async {
            self.view?.showError(message: message)
        }
    }
    
    
}
