import UIKit

protocol ImageCacheProtocol {
    func cacheAndDisplayImage(on imageView: UIImageView, imageURL: URL?)
}

class ImageCacheWrapper: ImageCacheProtocol {
    func cacheAndDisplayImage(on imageView: UIImageView, imageURL: URL?) {
        imageView.kf.setImage(with: imageURL)
    }
}
