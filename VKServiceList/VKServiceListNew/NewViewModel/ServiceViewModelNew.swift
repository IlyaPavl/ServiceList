//
//  ServiceViewModelNew.swift
//  VKServiceList
//
//  Created by Илья Павлов on 11.02.2025.
//

import UIKit

protocol ServiceViewModelDelegateProtocol: AnyObject {
    func viewModelDataDidUpdate()
}

final class ServiceViewModelNew {
    let serviceFetcher: ServicesDataFetcherProtocol = ServicesDataFetcher(networkService: SCNetworkService())
    var services: [Service] = []
    var onDataUpdated: (() -> Void)?
    
    func service(at index: Int) -> Service {
        return services[index]
    }
    
    func getServiceData() async {
        do {
            let data = try await serviceFetcher.getServicesData()
            guard let data else { return }
            services = data.services
            onDataUpdated?()
        } catch {
            print("Error fetching services: \(error)")
        }
    }
}
