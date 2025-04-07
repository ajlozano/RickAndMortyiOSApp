//
//  ImageLoader.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import UIKit

protocol ImageService {
    func loadImage(from url: URL) async -> UIImage?
}

class ImageServiceImpl: ImageService {
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        do {
            // Descarga asíncrona usando URLSession con async/await
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validación del código de respuesta HTTP
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return nil
            }
            
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: url as NSURL)
                return image
            }
        } catch {
            return nil
        }
        return nil
    }
}
