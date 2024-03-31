//
//  ServiceTableViewCell.swift
//  VKServiceList
//
//  Created by ily.pavlov on 29.03.2024.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {
    static let cellIdentifier = "ServiceCell"
    
    private var serviceImage = UIImageView()
    private let serviceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let iconSize: CGFloat = 55
    private let padding: CGFloat = 16
    private let chevronSize: CGFloat = 14
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(serviceImage: UIImage, serviceLabel: String, descriptionLabel: String) {
        self.serviceImage.image = serviceImage
        self.serviceLabel.text = serviceLabel
        self.descriptionLabel.text = descriptionLabel
    }
}

extension ServiceTableViewCell {
    private func setupCellUI() {
        contentView.addSubview(serviceImage)
        contentView.addSubview(serviceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(chevronImageView)
        setupConstraints()
        
        serviceLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        serviceLabel.textColor = .systemGray
        serviceLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        
        chevronImageView.image = UIImage(systemName: "chevron.forward")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .systemGray
    }
    
    private func setupConstraints() {
        serviceImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            serviceImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            serviceImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            serviceImage.widthAnchor.constraint(equalToConstant: iconSize),
            serviceImage.heightAnchor.constraint(equalToConstant: iconSize)
        ])
        
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            serviceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding / 2),
            serviceLabel.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: padding),
            serviceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding * 2)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: padding / 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding * 2),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding / 2)
        ])
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: chevronSize),
            chevronImageView.heightAnchor.constraint(equalToConstant: chevronSize)
        ])
    }
}
