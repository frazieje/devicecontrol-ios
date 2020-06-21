import UIKit

class ProfileDeviceViewFactory : DeviceViewFactory {

    private let router: Router
    
    private let deviceService: DeviceService
    
    init(router: Router, deviceService: DeviceService) {
        self.router = router
        self.deviceService = deviceService
    }
    
    func tableViewCellFor(device: ProfileDevice, tableView: UITableView) -> UITableViewCell {
        switch device {
            case let lock as DoorLock:
                var cell = tableView.dequeueReusableCell(withIdentifier: "DoorLockTableViewCell") as? DoorLockTableViewCell
                if cell == nil {
                    cell = DoorLockTableViewCell()
                    let presenter = ProfileDoorLockPresenter(router: router, deviceService: deviceService)
                    cell?.presenter = presenter
                    presenter.setView(view: cell)
                }
                cell?.show(lock: lock)
                return cell!
            default:
                return UITableViewCell()
        }
    }
    
    func detailsViewControllerFor(device: ProfileDevice, withUrl: URL?) -> UIViewController {
        switch device {
            case let lock as DoorLock:
                let doorLockMapper = ProfileDoorLockMapper()
                let doorLockPresenter = ProfileDoorLockDetailsPresenter(router: router, deviceService: deviceService, mapper: doorLockMapper, item: lock, actionUrl: withUrl)
                let doorLockDetails = DoorLockDetailsViewController(presenter: doorLockPresenter)
                doorLockPresenter.setView(view: doorLockDetails)
                return doorLockDetails
            default:
                return UIViewController()
        }
    }
    
    
}
