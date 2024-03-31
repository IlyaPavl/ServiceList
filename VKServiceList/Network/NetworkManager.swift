//
//  NetworkManager.swift
//  VKServiceList
//
//  Created by ily.pavlov on 29.03.2024.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func getData<T: Decodable>(from url: URL, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.noData))
                return
            }
            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }
        }.resume()
    }
    
    private func fetchData<T: Decodable>(for type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url.absoluteString) else {
            completion(.failure(APIError.wrongURL))
            return
        }
        getData(from: url, modelType: type, completion: completion)
    }
}

extension NetworkManager {
    func fetchServiceData(completion: @escaping (Result<ServiceModel, Error>) -> Void) {
        fetchData(for: ServiceModel.self, from: URL(string: APIUrl.serviceURL)!, completion: completion)
    }
    
    func loadServiceImages(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(APIError.decodingError))
                }
            }.resume()
        } else {
            completion(.failure(APIError.wrongURL))
        }
    }
}
