//
//  ServiceContentConfiguration.swift
//  VKServiceList
//
//  Created by Илья Павлов on 14.02.2025.
//


import UIKit

struct ServiceContentConfiguration: UIContentConfiguration {
    var serviceImageURL: String?
    var serviceLabel: String?
    var descriptionLabel: String?

    func makeContentView() -> UIView & UIContentView {
        return ServiceContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> ServiceContentConfiguration {
        return self
    }
}
