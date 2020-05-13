import UIKit

class ProfileServerItemTableViewCell : UITableViewCell {
    
    let iconViewServer: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f233}", textColor: .blackCoral, size: CGSize(width: 85, height: 85))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblProfileId: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .darkDarkGray
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblServers: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblSecureRemote: UILabel = {
        let lbl = UILabel()
        lbl.text = "Secure Remote: "
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblSecureRemoteBool: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f105}", textColor: .snow, size: CGFloat(18.0))
        let login = NSMutableAttributedString(string: "Log in ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)])
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(login)
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.tintColor = .snow
        btn.backgroundColor = .mayaBlue
        btn.setTitleColor(.snow, for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(iconViewServer)
        
        addSubview(lblProfileId)
        
        addSubview(lblServers)
        
        addSubview(lblSecureRemote)
        
        addSubview(lblSecureRemoteBool)
        
        NSLayoutConstraint.activate([
        
            iconViewServer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconViewServer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lblProfileId.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblProfileId.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            lblServers.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblServers.topAnchor.constraint(equalTo: lblProfileId.bottomAnchor, constant: 5),
            
            lblSecureRemote.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblSecureRemote.topAnchor.constraint(equalTo: lblServers.bottomAnchor, constant: 5),
            
            lblSecureRemoteBool.leadingAnchor.constraint(equalTo: lblSecureRemote.trailingAnchor),
            lblSecureRemoteBool.topAnchor.constraint(equalTo: lblServers.bottomAnchor, constant: 5),
            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item : ProfileServerItem? {
        didSet {
            let serversCount = item!.servers.count
            let hasSecure = item!.servers.filter { $0.secure }.count > 0
            lblProfileId.text = item!.profileId
            lblServers.text = "\(serversCount) Server\(serversCount > 1 ? "s" : "")"
            lblSecureRemoteBool.textColor = hasSecure ? .systemGreen : .lightGray
            lblSecureRemoteBool.text = hasSecure ? "Yes" : "No"
        }
    }
    
}
