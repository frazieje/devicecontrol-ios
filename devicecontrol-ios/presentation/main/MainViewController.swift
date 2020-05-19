import UIKit

class MainViewController : UITabBarController, MainView {

    private let presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        presenter.onViewLoad()

    }
    
    func showProfileButton(profileName: String) {
        
        self.viewControllers.forEach {
            
            let button  = UIButton(type: .custom)
            
            let profileIcon = UIImage.profileIcon(profileName: profileName, size: CGSize(width: 30.0, height: 30.0), color: .orange, textColor: .white)
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            button.setImage(profileIcon, for: .normal)
            
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            button.addTarget(self, action: #selector(onProfileButtonClicked), for: .touchUpInside)
            
            let barButton = UIBarButtonItem(customView: button)
            
            $0.navigationItem.setRightBarButtonItems([barButton], animated: true)

        }
    }
    
    @objc func onProfileButtonClicked() {
        presenter.onProfileButtonClicked()
    }
    
}

