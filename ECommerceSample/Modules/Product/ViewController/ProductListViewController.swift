//
//  ProductListViewController.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProductListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    private func pageSetup() {
        navigationBarButtonSettings()
        tableViewSetup()
        closureSetup()
        viewModel.getRangkings()
    }
    /// closure setup
    private func closureSetup() {
        viewModel.displayMessage = { [weak self] (message) in
            DispatchQueue.main.async {
                self?.removeActivityIndicator()
                guard let message = message, !message.isEmpty else {
                    return
                }
                self?.showAlert(message: message)
            }
        }
        viewModel.refreshData = { [weak self] in
            self?.tableViewReload()
        }
    }
    private func navigationBarButtonSettings() {
        let navFilterGraphButton = UIBarButtonItem(image: UIImage(named: "ic_filter"), style: .plain, target: self, action: #selector(filterChartData))
        navigationItem.rightBarButtonItem = navFilterGraphButton
    }
    @objc private func filterChartData() {
        func filterData(title: String?) {
            if let key = viewModel.arrayOfRankings.first(where: {$0.ranking == title})?.key {
                viewModel.filterData(forKey: key)
            }
        }
        let alert = UIAlertController(title: "Select filter type", message: nil, preferredStyle: .actionSheet)
        for range in viewModel.arrayOfRankings {
            let action = UIAlertAction(title: range.ranking, style: .default , handler:{ (alertAction)in
                filterData(title: alertAction.title)
            })
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(alert, animated: true)
    }
}
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    private func tableViewSetup() {
        tableView.register(UINib(nibName: "ProductDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
    }
    private func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell") as? ProductDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.cellDataSet(obj: viewModel.cellData(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            nextVC.viewModel.product = viewModel.getProduct(index: indexPath.row)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
