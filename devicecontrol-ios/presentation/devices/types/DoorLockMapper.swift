protocol DoorLockMapper {
    func from(cachedDevice: CachedDevice, deviceId: String, name: String) -> DoorLock
    func from(cachedMessageList: [CachedMessage]) -> [DoorLockStateChange]
}
