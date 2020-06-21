import UIKit

protocol Router {
    
    func routeToMain()
    func routeToGetStarted()
    func routeToNearbyProfileLogin(from: View)
    func routeToEditProfileLogin(from: View, item: ProfileServerItem?)
    func routeToLoginAction(from: View, item: ProfileLoginViewModel)
    
    func routeToViewController(_ vc: UIViewController, from: View)
    
    func showMenu()
    func hideMenu()
}
