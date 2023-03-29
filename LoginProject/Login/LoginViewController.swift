import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var inputContainer: UIStackView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @ObservableObject var viewModel = LoginViewModel()
    
    private lazy var spinner: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.style = .large
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return view
    }()
    
    private func setupFormStyle() {
        inputContainer.layer.cornerRadius = 8.0
        inputContainer.layer.shadowColor = UIColor.black.cgColor
        inputContainer.layer.shadowOpacity = 0.2
        inputContainer.layer.shadowRadius = 6.0
        inputContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormStyle()
        observeViewModel()
    }

    @IBAction func onLoginClick(_ sender: UIButton) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showSpinner()
        viewModel.tryToLogin(login: login, password: password)
    }
    
    private func observeViewModel() {
        viewModel.$login.observer = { [weak self] response in
            guard let user = response else {
                self?.showLoginErrorAlert()
                return
            }
            self?.openOnboardingModule(user)
        }
    }
    
    private func openOnboardingModule(_ user: User) {
        hideSpinner()
        if let next = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController() as? OnboardingViewController {
            next.viewModel.setUser(user)
            self.present(next, animated: true)
        }
    }
    
    private func showLoginErrorAlert() {
        hideSpinner()
        let alert = UIAlertController(title: "Login error!", message: "Wrong password/username", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    private func showSpinner() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spinner.leftAnchor.constraint(equalTo: view.leftAnchor),
            spinner.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func hideSpinner() {
        spinner.removeFromSuperview()
    }
}
