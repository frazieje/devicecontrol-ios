import UIKit

class MoreHistoryTableViewCell : UITableViewCell {

    var presenter: DoorLockDetailsPresenter?

    let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("More History", for: .normal)
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        button.addTarget(self, action: #selector(onMoreClicked), for: .touchUpInside)
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onMoreClicked() {
        presenter?.onMoreHistoryClicked()
    }

}
