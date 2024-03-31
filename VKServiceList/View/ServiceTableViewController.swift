//
//  ServiceTableViewController.swift
//  VKServiceList
//
//  Created by ily.pavlov on 29.03.2024.
//

import UIKit

final class ServiceTableViewController: UITableViewController, ServiceViewModelDelegate {
    private let viewModel = ServiceViewModel()
    private let leftSeparatorInset: CGFloat = 92

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.serviceDelegate = self
        viewModel.fetchServicesData()
        setupTableUI()
    }
    
    private func setupTableUI() {
        navigationItem.title = "Сервисы"
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray4
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: leftSeparatorInset, bottom: 0, right: 0)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.numberOfServices }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.cellIdentifier, for: indexPath) as! ServiceTableViewCell
        let service = viewModel.service(at: indexPath.row)
        let image = viewModel.image(for: indexPath.row)
        
        if let image = image {
            cell.configureCell(serviceImage: image, serviceLabel: service.name, descriptionLabel: service.description)
        } else {
            cell.configureCell(serviceImage: UIImage(systemName: "photo.circle.fill")!, serviceLabel: service.name, descriptionLabel: service.description)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = viewModel.service(at: indexPath.row)
        if let url = URL(string: service.link) {
                UIApplication.shared.open(url)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    // MARK: - ServiceViewModelDelegate
    func viewModelDidUpdateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
