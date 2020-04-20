import UIKit

let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

let profileIdRegex = "^[0-9a-z]{8}$"
let profileIdPredicate = NSPredicate(format: "SELF MATCHES %@", profileIdRegex)

extension String {
    func isEmail() -> Bool {
        return emailPredicate.evaluate(with: self)
    }
    func isProfileId() -> Bool {
        return profileIdPredicate.evaluate(with: self)
    }
}

extension UITextField {
    func isEmail() -> Bool {
        return self.text?.isEmail() == true
    }
}
