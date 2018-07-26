import UIKit

@testable import BeerFacts

class MockImageCache: ImageCacheProtocol {
    var inputImageView: UIImageView?
    var inputImageURL: URL?
    
    func cacheAndDisplayImage(on imageView: UIImageView, imageURL: URL?) {
        inputImageView = imageView
        inputImageURL = imageURL
    }
}
