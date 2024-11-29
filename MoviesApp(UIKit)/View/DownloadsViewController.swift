import UIKit

class NoCopySelectTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if  action == #selector(copy(_:)) ||  action == #selector(select(_:)) ||  action == #selector(cut(_:)) || action == #selector(selectAll(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

class DownloadsViewController: UIViewController, UITextFieldDelegate {
       
    @IBOutlet var myTextfield: NoCopySelectTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextfield.delegate = self
    }
    
}
