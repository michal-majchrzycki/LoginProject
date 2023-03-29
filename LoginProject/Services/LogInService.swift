import Foundation

protocol LoginServiceInput {
    func verifyLogin(login: String, password: String, response: @escaping (User?) -> ())
}

struct LogInService: LoginServiceInput {    
    func verifyLogin(login: String, password: String, response: @escaping (User?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        (login == "login@test.com" && password == "password") ? response(self.createUser()) : response(nil)
    }
    }
    
    private func createUser() -> User {
        return User(firstName: "Test", lastName: "User", email: "login@test.com")
    }
}
