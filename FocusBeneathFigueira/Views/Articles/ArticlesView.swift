import SwiftUI

struct ArticlesView: View {
    let articles = ArticleType.allCases
    @State private var selectedArticle: ArticleType? = nil
    @State private var showArticle = false
    var body: some View {
        VStack {
            Text("Our articles")
                .font(Font.custom("Righteous", size: 32))
                .frame(maxWidth: .infinity)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(articles, id: \.self) { article in
                        ArticleCardView(article: article) {
                            selectedArticle = article
                            showArticle = true
                        }
                    }
                }
            }
            if let article = selectedArticle {
                NavigationLink(
                    destination: ArticleSomeView(article: article).navigationBarBackButtonHidden(true),
                    isActive: $showArticle
                ) {
                    EmptyView()
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
    }
}

#Preview {
    ArticlesView()
}
