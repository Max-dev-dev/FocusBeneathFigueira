import SwiftUI

struct ChooseTreeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var treeManager = TreeSelectionManager.shared
    let treeIcons = ["fig", "plum", "orange", "apple", "pear", "lemon"]

    var body: some View {
        VStack(spacing: 36) {
            Text("Choose your tree")
                .font(Font.custom("Righteous", size: 32))
                .frame(maxWidth: .infinity)
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(treeIcons, id: \.self) { tree in
                        VStack {
                            Image(tree)
                                .resizable()
                                .scaledToFit()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(treeManager.selectedTree == tree ? Color.white : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    treeManager.selectedTree = tree
                                }
                            
                            Text(tree.capitalized)
                                .font(Font.custom("Righteous", size: 18))
                        }
                    }
                }
            }
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Set")
                    .font(Font.custom("Righteous", size: 18))
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.95, green: 0, blue: 0))
                    .cornerRadius(16)
            })
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
}

#Preview {
    ChooseTreeView()
}
