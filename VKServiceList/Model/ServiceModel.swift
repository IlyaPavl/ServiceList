//
//  ServiceModel.swift
//  VKServiceList
//
//  Created by ily.pavlov on 29.03.2024.
//

import Foundation

struct ServiceModel: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}

struct Service: Codable, Hashable {
    let name, description: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
