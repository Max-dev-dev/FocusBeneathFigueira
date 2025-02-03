import SwiftUI

class TreeSelectionManager: ObservableObject {
    static let shared = TreeSelectionManager()
    
    @Published var selectedTree: String = "fig"

    private init() {} 
}
