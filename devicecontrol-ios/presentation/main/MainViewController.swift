import UIKit

class MainViewController : UITabBarController, MainView {
    
    private let presenter: MainPresenter
    
    private var childViews: [View] = []
    
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
    
    func setChildViews(_ views: View...) {
        self.childViews = views
    }
    
    func loadChildViews(profileName: String, selectedIndex: Int) {
        
        self.viewControllers = childViews.map {
            
            let navController = UINavigationController(rootViewController: $0.viewController())
            
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.isTranslucent = true
            
            let button  = UIButton(type: .custom)
            
            let profileIcon = UIImage.profileIcon(profileName: profileName, size: CGSize(width: 35.0, height: 35.0), color: .mayaBlue, textColor: .white)
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            button.setImage(profileIcon, for: .normal)
            
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            button.addTarget(self, action: #selector(onProfileButtonClicked), for: .touchUpInside)
            
            let barButton = UIBarButtonItem(customView: button)
            
            $0.viewController().navigationItem.setRightBarButtonItems([barButton], animated: true)
            
            return navController
        }
        
        self.selectedIndex = selectedIndex
    }
    
    
    @objc func onProfileButtonClicked() {
        presenter.onProfileButtonClicked()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}

