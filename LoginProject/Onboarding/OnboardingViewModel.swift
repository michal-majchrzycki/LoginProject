import Foundation

struct OnboardingViewModel {
    @ObservableObject private(set) var user: User?
    
    mutating func setUser(_ user: User) {
        self.user = user
    }
}
