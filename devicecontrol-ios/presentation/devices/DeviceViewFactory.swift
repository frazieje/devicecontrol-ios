import UIKit

protocol DeviceViewFactory {
    func tableViewCellFor(device: ProfileDevice, tableView: UITableView) -> UITableViewCell
    func detailsViewControllerFor(device: ProfileDevice, withUrl: URL?) -> UIViewController
}
