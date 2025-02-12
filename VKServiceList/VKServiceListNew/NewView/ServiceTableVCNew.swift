//
//  ServiceTableVCNew.swift
//  VKServiceList
//
//  Created by Илья Павлов on 11.02.2025.
//

import UIKit

final class ServiceTableVCNew: UIViewController {
    enum Section {
        case main
    }

    private let viewModel: ServiceViewModelNew
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Service>!
    private var currentLoadingTask: Task<Void, Never>?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init(viewModel: ServiceViewModelNew) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        bindViewModel()
        loadData()
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.applySnapshot()
        }
    }
    
    private func setupTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сервисы"
        let action = UIAction { [weak self] _ in
            self?.loadData()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .refresh, primaryAction: action)
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(ServiceTableViewCellNew.self, forCellReuseIdentifier: ServiceTableViewCellNew.cellIdentifier)
        tableView.delegate = self
        view.addSubview(tableView)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Service>(tableView: tableView) { tableView, indexPath, service in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCellNew.cellIdentifier,
                                                           for: indexPath) as? ServiceTableViewCellNew else {
                fatalError("Unable to dequeue ServiceTableViewCellNew")
            }
            cell.configureCell(serviceImageURL: service.iconURL,
                               serviceLabel: service.name,
                               descriptionLabel: service.description)
            return cell
        }
    }

    private func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Service>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.services)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    private func loadData() {
        currentLoadingTask?.cancel()
        
        activityIndicator.startAnimating()
        applySnapshot(animated: false)
        
        currentLoadingTask = Task {
            do {
                await viewModel.getServiceData()
                if !Task.isCancelled {
                    applySnapshot()
                }
            }
            
            if !Task.isCancelled {
                activityIndicator.stopAnimating()
            }
        }
    }
}

extension ServiceTableVCNew: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = viewModel.service(at: indexPath.row)
        if let url = URL(string: service.link) {
            UIApplication.shared.open(url)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
