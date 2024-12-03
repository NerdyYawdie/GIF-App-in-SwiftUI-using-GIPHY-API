//

import Foundation

class GIFListViewModel: ObservableObject {
    
    @Published var gifs: [GIFModel] = []
    @Published var searchTerm: String = ""
    
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    let services: GIFServices
    
    init(services: GIFServices = GIFServicesImpl()) {
        self.services = services
    }
    
    @MainActor
    func fetchTrendingGIFs() async {
        
        do {
            isLoading = true
           gifs = try await services.fetchTrendingGifs()
            
            isLoading = false
        } catch {
            isLoading = false
            if let customError = error as? GIFServiceError {
                errorMessage = customError.errorTitle
            }
            showErrorAlert.toggle()
        }
    }
    
    @MainActor
    func searchGifs() async {
        do {
            isLoading = true
            gifs = try await services.searchGifs(endpoint: .search(searchTerm))
            
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Unable to find GIFs using \(searchTerm)"
            showErrorAlert.toggle()
        }
    }
}
