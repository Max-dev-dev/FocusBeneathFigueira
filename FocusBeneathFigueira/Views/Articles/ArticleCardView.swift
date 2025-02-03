import SwiftUI

struct ArticleCardView: View {
    let article: ArticleType
    let open: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(article.title)
                    .font(Font.custom("Righteous", size: 18))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Spacer()
                
                Button(action: {
                    open()
                }, label: {
                    Image(.openButton)
                })
            }
            
            Text(article.content)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.white)
                .lineLimit(2)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        
        .cornerRadius(16)
    }
}

#Preview {
    ArticleCardView(article: .dailyRest) {
        
    }
}
