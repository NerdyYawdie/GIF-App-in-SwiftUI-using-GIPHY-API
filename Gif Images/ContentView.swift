//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GifListView()
                .tabItem {
                    VStack {
                        Image(systemName: "photo")
                        
                        Text("GIFs")
                    }
                }
        }
    }
}

#Preview {
    //
    ContentView()
}
