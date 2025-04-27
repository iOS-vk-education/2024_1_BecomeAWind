import Foundation
import UIKit

final class GestureRecognizer: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func kokstyle() {}
}


//extension GestureRecognizer {
//    func keyboardWill() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
//    }
//    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    @objc func didTapView() {
//        view.endEditing(true)
//    }
//}
