//
//  MarvelCharacterDetailTableCell.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit

class MarvelCharacterDetailTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var characterData: [Items]? {
        
        didSet {
            if let _ = self.characterData {
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.itemSize = CGSize(width: 110, height: 110)
        flowLayout.scrollDirection = .horizontal
        
        collectionView.registerCellOf(type: MarvelCharacterDetailCollectionCell.self)
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}


extension MarvelCharacterDetailTableCell : UICollectionViewDelegate {
    
    
}


extension MarvelCharacterDetailTableCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.getResuableCellOf(type: MarvelCharacterDetailCollectionCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.setItem(data: self.characterData?[indexPath.row])
        
        return cell
        
    }
    
}
