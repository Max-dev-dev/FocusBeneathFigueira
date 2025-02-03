import SwiftUI

struct ArticleSomeView: View {
    @Environment(\.dismiss) private var dismiss
    let article: ArticleType
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(.backButton)
                })
                Spacer()
                
                Text(article.title)
                    .font(Font.custom("Righteous", size: 18))
                    .foregroundColor(.white)

                    .lineLimit(2)
                
                
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    Text(article.content)
                        .font(.system(size: 18, weight: .light))
                }
            }
            
            Button(action: {
                shareArticle(article: article)
            }, label: {
                HStack {
                    Text("Share")
                    .font(Font.custom("Righteous", size: 18))
                    
                    Spacer()
                    
                    Image(.shareButton)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                .cornerRadius(16)
            })
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
    
    private func shareArticle(article: ArticleType) {
            let text = "\(article.title)\n\n\(article.content)"
            let activityView = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
        }
}

#Preview {
    ArticleSomeView(article: .dailyRest)
}
