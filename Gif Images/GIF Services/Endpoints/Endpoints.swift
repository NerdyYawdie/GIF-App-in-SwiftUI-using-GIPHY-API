//

import Foundation

enum Endpoints {
    case trending
    case search(String)
    
    private var apiKey: String {
        return "bLmuQINg5Ab5xki799UCs0UJWhQLL2zv"
    }
    
    var resource: String {
        switch self {
        case .trending:
            return "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)"
        case .search(let searchTerm):
            return "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchTerm)"
        }
    }
}
