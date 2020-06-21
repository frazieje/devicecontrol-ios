import UIKit

class DoorLockHistoryTableViewCell : UITableViewCell {
    
    let iconViewLocked: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f023}", textColor: .systemGreen, size: CGSize(width: 35, height: 35))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let iconViewUnlocked: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f3c1}", textColor: .parrotPink, size: CGSize(width: 35, height: 35))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textColor = .darkDarkGray
        lbl.font = .systemFont(ofSize: 16)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblUser: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textColor = .darkDarkGray
        lbl.font = .systemFont(ofSize: 16)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(lblDate)
        
        addSubview(iconViewLocked)
        
        addSubview(iconViewUnlocked)
        
        addSubview(lblUser)
        
        let lineView = UIView(frame: CGRect(x: frame.width/2, y: 0, width: 2, height: 30))
        lineView.backgroundColor = .darkGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
        
            iconViewLocked.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconViewLocked.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            iconViewUnlocked.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconViewUnlocked.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            lblDate.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            lblDate.trailingAnchor.constraint(equalTo: iconViewLocked.leadingAnchor, constant: -10),
            
            lblUser.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            lblUser.leadingAnchor.constraint(equalTo: iconViewLocked.trailingAnchor, constant: 10),
            
            lineView.topAnchor.constraint(equalTo: iconViewLocked.bottomAnchor, constant: 2),
            lineView.widthAnchor.constraint(equalToConstant: 2),
            lineView.heightAnchor.constraint(equalToConstant: 30),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
        
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item : DoorLockStateChange? {
        didSet {
            switch item?.state {
                case .locked, .unlocking:
                    iconViewLocked.isHidden = false
                    iconViewUnlocked.isHidden = true
                case .unlocked, .locking:
                    iconViewLocked.isHidden = true
                    iconViewUnlocked.isHidden = false
                default:
                    iconViewLocked.isHidden = true
                    iconViewUnlocked.isHidden = true
            }
            let df = DateFormatter()
            df.dateFormat = "MMM d, h:mm a"
            lblDate.text = df.string(from: item?.date ?? Date())
            lblUser.text = item?.user
        }
    }
    
}
