//
//  ProductDetailsViewController.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ProductDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }

    private func pageSetup() {
        title = viewModel.product?.name
        tableViewSetup()
        closureSetup()
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
}
extension ProductDetailsViewController: UITableViewDataSource, UITableViewDelegate {
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return "Variants"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell") as? ProductDetailsTableViewCell else {
                return UITableViewCell()
            }
            cell.cellDataSet(obj: viewModel.cellProductData())
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductVariantTableViewCell") as? ProductVariantTableViewCell else {
                return UITableViewCell()
            }
            let object = viewModel.variantData(index: indexPath.row)
            cell.cellDataSetup(variant: object)
            return cell
        }
    }
}
