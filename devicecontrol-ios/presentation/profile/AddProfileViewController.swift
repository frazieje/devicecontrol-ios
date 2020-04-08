
import UIKit

class AddProfileViewController : UIViewController, AddProfileView {
    
    private let contentView: UIView = {
      let view = UIView()
      view.backgroundColor = .gray
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let btnManualEntry: UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("I know my login info", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnSearch: UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = .blue
        btn.setTitle("Find My login", for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let presenter: AddProfilePresenter
    
    init(presenter: AddProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        contentView.addSubview(btnSearch)
        
        contentView.addSubview(btnManualEntry)
        
        view.addSubview(contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Add a Profile"
        
        print("AddProfile viewDidLoad")
        
        contentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        btnSearch.topAnchor.constraint(equalTo:contentView.topAnchor, constant:40).isActive = true
        btnSearch.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant:20).isActive = true
        btnSearch.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant:-20).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        btnManualEntry.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant:20).isActive = true
        btnManualEntry.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant:-20).isActive = true
        btnManualEntry.topAnchor.constraint(equalTo:btnSearch.bottomAnchor, constant:20).isActive = true
        btnManualEntry.heightAnchor.constraint(equalToConstant:50).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("AddProfile viewDidAppear")
    }
    
}
