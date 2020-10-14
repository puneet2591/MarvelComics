//
//  MarvelCharacterDetailCollectionCell.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit
import SDWebImage

class MarvelCharacterDetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItem(data: Items?) {
        
        DispatchQueue.main.async {
            if let comic = data {
                self.name.text = comic.name
                
                //self.poster.sd_setImage(with: comic, completed: nil)
            }
        }
    }

}
