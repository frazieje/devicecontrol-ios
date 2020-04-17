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
    
    private let lblServer: UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconViewServer)
        
        addSubview(lblProfileId)
        
        addSubview(lblServer)
        
        addSubview(lblSecureRemote)
        
        addSubview(lblSecureRemoteBool)
        
        NSLayoutConstraint.activate([
        
            iconViewServer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconViewServer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lblProfileId.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblProfileId.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            lblServer.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblServer.topAnchor.constraint(equalTo: lblProfileId.bottomAnchor, constant: 5),
            
            lblSecureRemote.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblSecureRemote.topAnchor.constraint(equalTo: lblServer.bottomAnchor, constant: 5),
            
            lblSecureRemoteBool.leadingAnchor.constraint(equalTo: lblSecureRemote.trailingAnchor),
            lblSecureRemoteBool.topAnchor.constraint(equalTo: lblServer.bottomAnchor, constant: 5),
            

            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item : ProfileServerItem? {
        didSet {
            lblProfileId.text = item!.profileId
            lblServer.text = "http://\(item!.host)\(item!.port == 80 ? "" : ":\(item!.port)")"
            lblSecureRemoteBool.textColor = item!.remoteHost != nil && item!.remotePort != nil ? .systemGreen : .lightGray
            lblSecureRemoteBool.text = item!.remoteHost != nil && item!.remotePort != nil ? "Yes" : "No"
        }
    }
    
}
