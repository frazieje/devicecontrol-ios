import UIKit

protocol DevicesPresenter : Presenter {
    
    func deviceClicked(_ device: ProfileDevice)
    
    func deviceGroupClicked(type: String)
    
    func setView(view: DevicesView)
    
    func tableViewCellFor(device: ProfileDevice, tableView: UITableView) -> UITableViewCell
    
    func onRefresh()
    
}
