//
//  SCNetworkManager.swift
//  VKServiceList
//
//  Created by Илья Павлов on 11.02.2025.
//

import UIKit

protocol SCNetworkServiceProtocol {
    func requestData<T: Decodable>(path: String) async throws -> T
}

final class SCNetworkService: SCNetworkServiceProtocol {
    func requestData<T: Decodable>(path: String) async throws -> T {
        guard let url = URL(string: path) else {
            throw APIError.wrongURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.decodingError
        }
    }
}
