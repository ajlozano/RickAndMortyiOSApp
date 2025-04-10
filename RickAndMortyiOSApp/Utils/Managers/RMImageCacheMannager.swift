//
//  RMImageCacheMannager.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 9/4/25.
//

import Foundation

final class RMImageCacheManager {
    
    static let shared = RMImageCacheManager()
    
    private init() {}
    
    /// The cache where the images that are downloaded as the cells are displayed are stored.
    private let cache = NSCache<NSString, NSData>()
    
    // MARK: - Store Image on Cache
    private func cache(image: Data, forKey value: String) {
        let image = NSData(data: image)
        let itemKey = NSString(string: value)
        self.cache.setObject(image, forKey: itemKey)
    }
    
    // MARK: - Image Cache
    /// Private getter for a cache image for key imput
    /// - Parameter value: key for the cached image (image url path)
    /// - Returns: Return the Data os the image stored
    private func getImageCache(forKey value: String) -> Data? {
        let itemKey = NSString(string: value)
        return cache.object(forKey: itemKey) as? Data
    }
    
    // MARK: - Image Downloading
    /// Download a image from given image path.
    /// Store the downloaded Image in the internal cache.
    /// - Parameters:
    ///   - imagePath: url path for download image.
    /// - Returns: Return the Data os the image downloaded.
    private func downloadImage(imagePath: String) async -> Data? {
        guard let imageUrl = URL(string: imagePath) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            self.cache(image: data, forKey: imagePath)
            return data
        } catch {
            return nil
        }
    }
}

// MARK: ImageCache - Public Methods

extension RMImageCacheManager {
    
    // MARK: - Image Loading
    /// Return the cached image for the key if its posible.
    /// If the image is not being cached, the method downloads it, caches the image, and returns it on completion.
    /// - Parameters:
    ///   - value: url path for the cache or download image.
    /// - Returns: Return the Data os the image cached or downloaded.
    public func loadImage(forKey value: String) async -> Data? {
        if let cachedImage = getImageCache(forKey: value) {
            return cachedImage
        } else {
            return await downloadImage(imagePath: value)
        }
    }
}
