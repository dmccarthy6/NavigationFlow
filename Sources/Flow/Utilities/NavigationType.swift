import SwiftUI

public enum NavigationType {
    case push
    case present(PresentationType)
}

public extension NavigationType {
    var presentationType: PresentationType? {
        guard case .present(let presentationType) = self else {
            return nil
        }
        return presentationType
    }
}
