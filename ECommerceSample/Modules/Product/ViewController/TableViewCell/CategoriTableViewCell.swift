//
//  CategoriTableViewCell.swift
//  ECommerceSample
//
//  Created by Pratik on 22/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

class CategoriTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberOfProducts = 0
    var arrayOfProducts = [String?]() {
        didSet {
            reloadCollectionView()
        }
    }
    var didSelectProduct:((_ index: Int)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CategoriTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionViewSetup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.layoutSubviews()
            self.collectionView.layoutIfNeeded()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriContentCollectionViewCell", for: indexPath) as? CategoriContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.clipsToBounds = true
        if arrayOfProducts.indices.contains(indexPath.item) {
            cell.cellDataSet(title: arrayOfProducts[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectProduct?(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let xSpace : CGFloat = 16
        let ySpace : CGFloat = 16
        let height = collectionView.bounds.size.height
        let cellWidth = CGFloat(height - (xSpace + ySpace))
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
