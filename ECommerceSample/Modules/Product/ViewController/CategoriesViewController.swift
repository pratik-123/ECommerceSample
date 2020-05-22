//
//  CategoriesViewController.swift
//  ECommerceSample
//
//  Created by Pratik on 18/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseViewController {
    let viewModel = CategoriesViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    private func pageSetup() {
        title = "ECommerceSample"
        tableViewSetup()
        closureSetup()
        displayActivityIndicator(onView: self.view)
        viewModel.getCategoryData()
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
    
    @IBAction func buttonHandlerViewAll(_ sender: UIButton) {
        let section = sender.tag
        let array = viewModel.getAllProducts(index: section)
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
            nextVC.viewModel.arrayOfProducts = array
            nextVC.title = viewModel.titleForHeader(index: section)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    private func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = 200
    }
    private func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeActivityIndicator()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "CategoriTableViewHeader") as? CategoriTableViewHeader
        header?.setCellData(title: viewModel.titleForHeader(index: section))
        if let button = header?.buttonViewAll {
            button.tag = section
            button.addTarget(self, action: #selector(buttonHandlerViewAll(_:)), for: .touchUpInside)
        }
        return header?.contentView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriTableViewCell") as? CategoriTableViewCell else {
            return UITableViewCell()
        }
        cell.numberOfProducts = viewModel.numberOfProducts(section: indexPath.section)
        cell.arrayOfProducts = viewModel.productList(section: indexPath.section)
        cell.didSelectProduct = { (row) in
            self.selectProduct(row: row, section: indexPath.section)
        }
        return cell
    }
    func selectProduct(row: Int, section: Int) {
        let product = viewModel.getProduct(row: row, section: section)
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            nextVC.viewModel.product = product
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
}
