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
            
            let vc = $0.viewController()
            
            let navController = UINavigationController(rootViewController: vc)
            
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
            
            vc.navigationItem.setRightBarButtonItems([barButton], animated: true)
            
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
    
    func setSelected(view: View) {
        
        let select = self.viewControllers?.filter { vc in
            view.viewController() == vc
        }.first
        
        if let select = select {
            selectedViewController = select
        }
        
    }
    
}

