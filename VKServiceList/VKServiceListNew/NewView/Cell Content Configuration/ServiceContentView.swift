//
//  ServiceContentView.swift
//  VKServiceList
//
//  Created by Илья Павлов on 14.02.2025.
//

import UIKit

class ServiceContentView: UIView, UIContentView {
    private let imageView = WebImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let iconSize: CGFloat = 55
    private let padding: CGFloat = 16

    var configuration: UIContentConfiguration {
        didSet {
            applyConfiguration()
        }
    }

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupViews()
        applyConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .systemGray
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: iconSize),
            imageView.heightAnchor.constraint(equalToConstant: iconSize),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding / 2),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 2),

            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding / 2)
        ])
    }
    

    private func applyConfiguration() {
        guard let config = configuration as? ServiceContentConfiguration else { return }
        
        if let url = config.serviceImageURL {
            self.imageView.set(imageURL: url)
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        titleLabel.text = config.serviceLabel
        descriptionLabel.text = config.descriptionLabel
    }
}
