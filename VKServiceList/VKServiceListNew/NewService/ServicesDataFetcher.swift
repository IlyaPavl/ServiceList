//
//  ServicesDataFetcher.swift
//  VKServiceList
//
//  Created by Илья Павлов on 11.02.2025.
//

import UIKit

protocol ServicesDataFetcherProtocol {
    func getServicesData() async throws -> Body?
}

final class ServicesDataFetcher: ServicesDataFetcherProtocol {
    let networkService: SCNetworkServiceProtocol
    
    init(networkService: SCNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getServicesData() async throws -> Body? {
        let result: ServiceModel = try await networkService.requestData(path: APIUrl.serviceURL)
        return result.body
    }
}
