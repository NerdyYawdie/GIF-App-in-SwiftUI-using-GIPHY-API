//

import SwiftUI

struct GifListView: View {
    
    @StateObject var viewModel = GIFListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.gifs.isEmpty {
                    List(viewModel.gifs) { gif in
                        GIFRowView(gif: gif)
                    }
                } else {
                    ContentUnavailableView("Unable to fetch GIFs", systemImage: "magnifyingglass", description: Text("Please recheck your internet connection & retry."))
                }
                
            }
            .searchable(text: $viewModel.searchTerm, prompt: Text("Search for Gifs"))
            .onSubmit(of: .search, {
                Task {
                    await viewModel.searchGifs()
                }
            })
            .task {
                await viewModel.fetchTrendingGIFs()
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }
            .navigationTitle(Text("GIFs"))
            .overlay {
                if viewModel.isLoading {
                    ProgressView(LocalizedStringKey("Fetching Gifs...😪"))
                }
            }
            .refreshable {
                await viewModel.fetchTrendingGIFs()
            }
            .toolbar {
                ToolbarItem {
                    Button(LocalizedStringKey("Show Trending")) {
                        Task {
                            await viewModel.fetchTrendingGIFs()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GifListView()
}
