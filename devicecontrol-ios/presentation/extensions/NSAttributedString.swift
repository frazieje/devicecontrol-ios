import Foundation
import CoreGraphics
import UIKit

public extension NSAttributedString {
    
    static func fontAwesomeIcon(icon: String, textColor: UIColor, size: CGFloat) -> NSAttributedString {
        
        let faFont = UIFont(name: "FontAwesome5Free-Solid", size: size)!
        
        let attributedString = NSAttributedString(string: icon, attributes: [
            NSAttributedString.Key.font: faFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ])
        
        return attributedString
        
    }
    
}
