@testable import LoginProject
import XCTest

class OnboardingViewModelTests: XCTestCase {
    var viewModel: OnboardingViewModel!
    
    override func setUpWithError() throws {
        viewModel = OnboardingViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_ifUserIsntNil() {
        let user = User(firstName: "name", lastName: "name", email: "email")
        viewModel.setUser(user)
        XCTAssertNotNil(viewModel.user)
    }
}
