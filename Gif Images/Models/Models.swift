//

import Foundation

struct GIFResponse: Decodable {
    let data: [GIFModel]
}

struct GIFModel: Decodable, Identifiable {
    let id: String
    let username: String
    let title: String
    let images: GIFImage
}

struct GIFImage: Decodable {
    let original: GIFOriginalImage
}

struct GIFOriginalImage: Decodable {
    let url: URL
}
