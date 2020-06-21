import Foundation

class ProfileDoorLockDetailsPresenter : DoorLockDetailsPresenter {

    var view: DoorLockDetailsView?
    
    private let router: Router
    
    private let deviceService: DeviceService
    
    private let mapper: DoorLockMapper
    
    private let item: DoorLock
    
    private var pendingStateAndMessage: (DoorLock.State, DeviceMessage)?
    
    init(router: Router, deviceService: DeviceService, mapper: DoorLockMapper, item: DoorLock, actionUrl: URL?) {
        self.router = router
        self.deviceService = deviceService
        self.mapper = mapper
        self.item = item
        if let url = actionUrl {
            self.pendingStateAndMessage = item.stateAndMessageFrom(url: url)
        } else {
            self.pendingStateAndMessage = nil
        }
    }
    
    func onLock() {
        print("lock")
    }
    
    func onUnlock() {
        print("unlock")
    }
    
    func setView(view: DoorLockDetailsView?) {
        self.view = view
    }
    
    func onViewLoad() {
        if let stateAndMessage = pendingStateAndMessage {
            deviceService.publish(message: stateAndMessage.1) { [weak self] error in
                guard let self = self else { return }
                
                if error == nil {
                    var lock = self.item
                    lock.state = stateAndMessage.0
                    lock.lastStateChange = Date()
                    self.updateLock(newItem: lock)
                } else {
                    self.showError(message: error?.message)
                }
            }
            pendingStateAndMessage = nil
        }
        view?.show(lock: item)
    }
    
    private func updateLock(newItem: DoorLock) {
        DispatchQueue.main.async {
            self.view?.show(lock: newItem)
        }
    }
    
    private func showError(message: String?) {
        DispatchQueue.main.async {
            self.view?.showError(message: message)
        }
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func onMoreHistoryClicked() {
        
        deviceService.getDeviceLog(id: item.deviceId) { [weak self] result, error in
            guard let self = self else { return }
            if error == nil {
                self.updateHistory(messages: self.mapper.from(cachedMessageList: result))
            } else {
                self.view?.showError(message: "Error Retrieving History")
            }
        }
        
    }
    
    private func updateHistory(messages: [DoorLockStateChange]) {
        
        DispatchQueue.main.async {
            
            self.view?.showDeviceLog(messages: messages)
            
        }
        
    }
    
    
}
