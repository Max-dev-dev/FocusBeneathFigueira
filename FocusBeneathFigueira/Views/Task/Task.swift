import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
}
