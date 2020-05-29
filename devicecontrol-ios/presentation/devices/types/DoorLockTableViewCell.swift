import Foundation
import UIKit

class DoorLockTableViewCell : UITableViewCell {
    
    var delegate: DoorLockTableViewCellDelegate?
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconViewDoor: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f52a}", textColor: .blackCoral, size: CGSize(width: 35, height: 35))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let iconViewLocked: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage.fontAwesomeIcon(icon: "\u{f023}", textColor: .systemGreen, size: CGSize(width: 35, height: 35))
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.alpha = 0.0
//        return view
//    }()
//
//    let iconViewUnlocked: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage.fontAwesomeIcon(icon: "\u{f3c1}", textColor: .parrotPink, size: CGSize(width: 35, height: 35))
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.alpha = 0.0
//        return view
//    }()
    
    private let lblName: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textColor = .darkDarkGray
        lbl.font = .systemFont(ofSize: 16)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblDeviceId: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblLastStateChange: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 11)
        lbl.textColor = .lightGray
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let btnLocked: UIButton = {
        let btn = UIButton(type: .custom)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f023}", textColor: .systemGreen, size: CGFloat(24.0))
        let highlightedColor = UIColor(red: 46/255, green: 187/255, blue: 70/255, alpha: 1)
        let highlightedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f023}", textColor: highlightedColor, size: CGFloat(24.0))
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.setAttributedTitle(highlightedIconString, for: .highlighted)
        btn.backgroundColor = .clear
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitleColor(highlightedColor, for: .highlighted)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnUnlocked: UIButton = {
        let btn = UIButton(type: .custom)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f3c1}", textColor: .parrotPink, size: CGFloat(24.0))
        let highlightedColor = UIColor(red: 202/255, green: 140/255, blue: 157/255, alpha: 1.0)
        let highlightedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f3c1}", textColor: highlightedColor, size: CGFloat(24.0))
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.setAttributedTitle(highlightedIconString, for: .highlighted)
        btn.backgroundColor = .clear
        btn.setTitleColor(.parrotPink, for: .normal)
        btn.setTitleColor(highlightedColor, for: .highlighted)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear // very important
        
        selectionStyle = .none
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.blackCoral.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        addSubview(iconViewDoor)
        
        addSubview(lblName)
        
        addSubview(lblDeviceId)
        
        addSubview(btnLocked)
        
        addSubview(btnUnlocked)
        
        addSubview(lblLastStateChange)
        
        btnLocked.addTarget(self, action: #selector(onLockedButtonClicked), for: .touchUpInside)
        btnUnlocked.addTarget(self, action: #selector(onUnlockedButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            iconViewDoor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            iconViewDoor.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lblName.leadingAnchor.constraint(equalTo: iconViewDoor.trailingAnchor, constant: 15),
            lblName.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            
            lblDeviceId.leadingAnchor.constraint(equalTo: iconViewDoor.trailingAnchor, constant: 15),
            lblDeviceId.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 8),
            lblDeviceId.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
            btnLocked.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            btnLocked.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            btnUnlocked.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -29),
            btnUnlocked.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lblLastStateChange.topAnchor.constraint(equalTo: btnLocked.bottomAnchor),
            lblLastStateChange.centerXAnchor.constraint(equalTo: btnLocked.centerXAnchor),
            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var index: Int?
    
    var item : DoorLock? {
        didSet {
            lblDeviceId.text = item?.deviceId
            lblName.text = item?.name
            switch item?.state {
                case .locked, .unlocking:
                    btnLocked.isHidden = false
                    btnUnlocked.isHidden = true
                case .unlocked, .locking:
                    btnLocked.isHidden = true
                    btnUnlocked.isHidden = false
                default:
                    btnLocked.isHidden = true
                    btnUnlocked.isHidden = true
            }
            if let lastStateChangeSeconds = item?.lastStateChange?.timeIntervalSinceNow {
                lblLastStateChange.text = "\(lastStateChangeSeconds.stringTime)"
            }
        }
    }

    @objc func onLockedButtonClicked() {
        btnLocked.isHidden = true
        btnUnlocked.isHidden = false
        if let idx = index {
            delegate?.onUnlock(index: idx)
        }
    }
    
    @objc func onUnlockedButtonClicked() {
        btnLocked.isHidden = false
        btnUnlocked.isHidden = true
        if let idx = index {
            delegate?.onLock(index: idx)
        }
    }
    
}

protocol DoorLockTableViewCellDelegate {
    func onLock(index: Int)
    func onUnlock(index: Int)
}

extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

    private var seconds: Int {
        return Int(self) % 60
    }

    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    private var hours: Int {
        return Int(self) / 3600
    }
    
    private var days: Int {
        return Int(self) / (3600 * 24)
    }

    var stringTime: String {
        if days != 0 {
            if abs(days) == 1 {
                return "1 day ago"
            }
            return "\(abs(days)) days ago"
        } else if hours != 0 {
            return "\(abs(hours))h ago"
        } else if minutes != 0 {
            return "\(abs(minutes))m ago"
        } else {
            return abs(seconds) < 10 ? "just now" : "\(abs(seconds))s ago"
        }
    }
}
