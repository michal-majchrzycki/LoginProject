import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var topLable: UILabel!
    @IBOutlet weak var bottomLable: UILabel!
    
    var viewModel = OnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$user.observer = { [weak self] response in
            let string = String(format:" Hello %@ %@!", (response?.firstName ?? ""), (response?.lastName ?? ""))
            self?.topLable.text = string
        }
    }
    
}
