import Foundation

@propertyWrapper
class ObservableObject<T> {
    var projectedValue: ObservableObject<T> { self }
    
    var wrappedValue: T {
        didSet {
            observer?(wrappedValue)
        }
    }
    
    var observer: ((T) -> Void)? {
        didSet {
            observer?(wrappedValue)
        }
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
