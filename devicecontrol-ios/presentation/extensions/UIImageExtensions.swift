import UIKit
import CoreGraphics

public extension UIImage {
    
    static func fontAwesomeIcon(icon: String, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage {
        
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        let fontAspectRatio: CGFloat = 1.28571429
        
        let fontSize = min(size.width / fontAspectRatio, size.height)
        
        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)
        
        let faFont = UIFont(name: "FontAwesome5Free-Solid", size: fontSize)!
        
        let attributedString = NSAttributedString(string: icon, attributes: [
            NSAttributedString.Key.font: faFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: backgroundColor,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: borderColor
            ])
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
    static func profileIcon(profileName: String, size: CGSize, color: UIColor, textColor: UIColor) -> UIImage {
        
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        let fontSize = min(size.width / 2, size.height / 2)
        
        let background = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 5.0)
        
        let attributedString = NSAttributedString(string: String(profileName.first!), attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: UIColor.clear,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: CGFloat(0.0),
            NSAttributedString.Key.strokeColor: UIColor.clear
            ])
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)

            context.addPath(background.cgPath)

            context.drawPath(using: .fill)
            
            let line = CTLineCreateWithAttributedString(attributedString)
            
            let bounds = CTLineGetBoundsWithOptions(line, .useOpticalBounds)
            
            context.setTextDrawingMode(.fill)
            
            let xn = (size.width / 2) - (bounds.width/2)
            let yn = (size.height / 2) - bounds.midY

            context.textPosition = CGPoint(x: xn, y: yn)
            
            CTLineDraw(line, context)
            
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
        
    }
    
}
