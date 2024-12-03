//
import SDWebImageSwiftUI
import SwiftUI

struct GIFRowView: View {
    
    let gif: GIFModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(gif.username)
                .font(.headline)
            
            WebImage(url: gif.images.original.url) { image in
                
                image
                    .resizable()
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(4)
                
            } placeholder: {
                ProgressView()
            }

            
            Text(gif.title)
                .padding(.vertical)
        }
    }
}

#Preview {
    GIFRowView(gif: GIFModel(id: "H1vJZzQAiILUUq0FUL", username: "imariajohnsen", title: "Happy December GIF by Maria Johnsen", images: GIFImage(original: GIFOriginalImage(url: URL(string: "https://media2.giphy.com/media/H1vJZzQAiILUUq0FUL/giphy.gif?cid=5058e9a29iuik2y5t0b8c3c211d6f7x5hu6wdxs5xforqeqe&ep=v1_gifs_trending&rid=giphy.gif&ct=g")!))))
}
