//
//  ServiceViewModel.swift
//  VKServiceList
//
//  Created by ily.pavlov on 29.03.2024.
//

import UIKit

protocol ServiceViewModelDelegate: AnyObject {
    func viewModelDidUpdateData()
}

final class ServiceViewModel {
    private let networkManager = NetworkManager.shared
    weak var serviceDelegate: ServiceViewModelDelegate?
    private var services: [Service] = []
    private var images: [UIImage?] = []
    private var imageCache = NSCache<NSString, UIImage>()

    var numberOfServices: Int {
        return services.count
    }
    
    func service(at index: Int) -> Service {
        return services[index]
    }
    
    func image(for index: Int) -> UIImage? {
        return images[index]
    }
    
    func fetchServicesData() {
        networkManager.fetchServiceData { [weak self] result in
            switch result {
            case .success(let loadedServices):
                self?.services = loadedServices.body.services
                self?.images = Array(repeating: nil, count: loadedServices.body.services.count)
                self?.serviceDelegate?.viewModelDidUpdateData()
                self?.fetchImages()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImages() {
        for (index, service) in services.enumerated() {
            fetchImage(for: index, from: service.iconURL)
        }
    }
    
    private func fetchImage(for index: Int, from url: String) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            images[index] = cachedImage
            serviceDelegate?.viewModelDidUpdateData()
        } else {
            networkManager.loadServiceImages(from: url) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.imageCache.setObject(image, forKey: url as NSString)
                    self?.images[index] = image
                    self?.serviceDelegate?.viewModelDidUpdateData()
                case .failure(let error):
                    print("Ошибка загрузки изображения: \(error.localizedDescription)")
                }
            }
        }
    }
}
