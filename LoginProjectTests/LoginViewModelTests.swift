@testable import LoginProject
import XCTest

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var loginService: MockLoginService!
    
    class MockLoginService: LoginServiceInput {
        var verifyLoginEx: XCTestExpectation?
        
        func verifyLogin(login: String, password: String, response: @escaping (User?) -> ()) {
            verifyLoginEx?.fulfill()
        }
    }

    override func setUpWithError() throws {
        viewModel = LoginViewModel()
        viewModel.service = MockLoginService()
        loginService = MockLoginService()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loginService = nil
    }
    
    func test_tryToLogin() {
        let login = "login@test.com"
        let password = "password"
        
        viewModel.tryToLogin(login: login, password: password)
        
        loginService.verifyLogin(login: login, password: password) { [weak self] response in
            self?.loginService.verifyLoginEx = self?.expectation(description: "verify login should be call")
            self?.waitForExpectations(timeout: 1)
            XCTAssertEqual(self?.viewModel.login?.firstName, response?.firstName)
            XCTAssertEqual(self?.viewModel.login?.lastName, response?.lastName)
            XCTAssertEqual(self?.viewModel.login?.email, response?.email)
        }
    }
    
    func test_loginFails() {
        let login = "fail_test_login"
        let password = "fail_test_password"
        
        viewModel.tryToLogin(login: login, password: password)
        
        loginService.verifyLogin(login: "login@test.com", password: "password") { [weak self] response in
            self?.loginService.verifyLoginEx = self?.expectation(description: "verify login should be call")
            self?.waitForExpectations(timeout: 1)
            XCTAssertNotEqual(self?.viewModel.login?.firstName, response?.firstName)
            XCTAssertNotEqual(self?.viewModel.login?.lastName, response?.lastName)
            XCTAssertNotEqual(self?.viewModel.login?.email, response?.email)
        }
    }
    
    func test_timeoutOnLogin() {
        let login = "login@test.com"
        let password = "password"
        
        viewModel.tryToLogin(login: login, password: password)
        loginService.verifyLogin(login: login, password: password) { [weak self] response in
            self?.loginService.verifyLoginEx = self?.expectation(description: "verify login should be call")
            self?.waitForExpectations(timeout: 3)
            XCTAssertNil(self?.viewModel.login)
        }
    }
}
