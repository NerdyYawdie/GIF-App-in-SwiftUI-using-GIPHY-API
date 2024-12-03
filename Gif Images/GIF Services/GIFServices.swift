//

import Foundation

protocol GIFServices {
    func fetchTrendingGifs() async throws -> [GIFModel]
    func searchGifs(endpoint: Endpoints) async throws -> [GIFModel]
}

enum GIFServiceError: Error {
    case invalidURL
    case invalidResponse
    case custom(String)
    
    var errorTitle: String {
        switch self {
        case .invalidURL:
            return "Bad URL"
        case .invalidResponse:
            return "Bad Response"
        case .custom(let error):
            return "Something horribly went wrong \(error)"
        }
    }
    
}

class GIFServicesImpl: GIFServices {
    
    func fetchTrendingGifs() async throws -> [GIFModel] {
        
        guard let url = URL(string: Endpoints.trending.resource) else {
            throw GIFServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpURLResponse.statusCode) else {
                throw GIFServiceError.invalidResponse
            }
            
            let gifResponse = try JSONDecoder().decode(GIFResponse.self, from: data)
            let gifs = gifResponse.data
            return gifs
        } catch {
            throw GIFServiceError.custom(error.localizedDescription)
        }
    }
    
    func searchGifs(endpoint: Endpoints) async throws -> [GIFModel] {
        
        guard let url = URL(string: endpoint.resource) else {
            throw GIFServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpURLResponse.statusCode) else {
                throw GIFServiceError.invalidResponse
            }
            
            let gifResponse = try JSONDecoder().decode(GIFResponse.self, from: data)
            return gifResponse.data
        } catch {
            throw GIFServiceError.custom(error.localizedDescription)
        }
    }
    
}
