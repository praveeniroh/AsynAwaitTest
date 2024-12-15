//
//  ItemListViewController.swift
//  AsyncAwaitTest
//
//  Created by praveen-12298 on 14/12/24.
//


import UIKit

protocol ItemListViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showItems(_ items: [ListUIData])
    func showError(_ message: String)
    func endPullToRefreshing()
}

class ItemListViewController: UIViewController, ItemListViewProtocol {
    private var presenter: ItemListPresenterProtocol!
    private var tableView: UITableView!
    private var data: [ListUIData] = []
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTableView()
        setupActivityIndicator()
        presenter.viewDidLoad()
    }

    func inject(presenter: ItemListPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - ItemListViewProtocol

    func showLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func showItems(_ items: [ListUIData]) {
        data = items
        tableView.reloadData()
    }

    func showError(_ message: String) {
        print("Error: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc private func handlePullToRefresh() {
        presenter.pullToRefreshTriggerred()
    }

    func endPullToRefreshing() {
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row].displayTitle
        return cell
    }
}
