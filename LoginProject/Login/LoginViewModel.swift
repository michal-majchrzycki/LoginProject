import Foundation

class LoginViewModel {
    @ObservableObject private(set) var login: User?
    var service: LoginServiceInput?
    
    init() {
        service = LogInService()
    }
    
    func tryToLogin(login: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.login = nil
        }
        
        service?.verifyLogin(login: login, password: password) { [weak self] response in
            self?.login = response
        }
    }
}
