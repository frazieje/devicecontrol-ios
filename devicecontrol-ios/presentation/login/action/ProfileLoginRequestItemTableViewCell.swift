import UIKit

class ProfileLoginRequestItemTableViewCell : UITableViewCell {
    
    let iconViewServer: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f233}", textColor: .blackCoral, size: CGSize(width: 45, height: 45))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .lightGray
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconViewCheck: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f00c}", textColor: .systemGreen, size: CGSize(width: 25, height: 25))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        return view
    }()
    
    let iconViewRetry: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f01e}", textColor: .blackCoral, size: CGSize(width: 25, height: 25))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        return view
    }()
    
    
    private let lblServerUrl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightGray
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
    
    let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(mainContentView)
        
        mainContentView.addSubview(iconViewServer)
        
        mainContentView.addSubview(lblServerUrl)
        
        mainContentView.addSubview(activityIndicator)
        
        mainContentView.addSubview(iconViewCheck)
        
        mainContentView.addSubview(iconViewRetry)
        
        NSLayoutConstraint.activate([
            
            mainContentView.topAnchor.constraint(equalTo: topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        
            iconViewServer.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 10),
            iconViewServer.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            
            lblServerUrl.leadingAnchor.constraint(equalTo: iconViewServer.trailingAnchor, constant: 10),
            lblServerUrl.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            
            activityIndicator.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -15),
            activityIndicator.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
            
            iconViewCheck.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -15),
            iconViewCheck.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            iconViewCheck.widthAnchor.constraint(equalToConstant: 20),
            iconViewCheck.heightAnchor.constraint(equalToConstant: 20),
            
            iconViewRetry.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -15),
            iconViewRetry.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            iconViewRetry.widthAnchor.constraint(equalToConstant: 20),
            iconViewRetry.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item : ProfileLoginRequestItem? {
        didSet {
            lblServerUrl.text = item?.serverUrl
            if let status = item?.status {
                switch status {
                    case .inProgress:
                        activityIndicator.startAnimating()
                        iconViewCheck.alpha = 0.0
                        iconViewRetry.alpha = 0.0
                    case .ready:
                        activityIndicator.stopAnimating()
                        iconViewCheck.alpha = 0.0
                        iconViewRetry.alpha = 0.0
                    case .succeeded:
                        activityIndicator.stopAnimating()
                        iconViewCheck.alpha = 1.0
                        iconViewRetry.alpha = 0.0
                    case .failed:
                        activityIndicator.stopAnimating()
                        iconViewCheck.alpha = 0.0
                        iconViewRetry.alpha = 1.0
                }
            }
        }
    }
}

