//
//  MarvellCharacterHeaderTableCell.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit

class MarvellCharacterHeaderTableCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: MarvelCharacterData?) {
        
        DispatchQueue.main.async {
            
            if let character = data {
                self.characterImage.sd_setImage(with: character.getThumbnailUrl(), completed: nil)
                
                self.characterDescription.text = character.description ?? "N/A"
            }
        }
    }
    
}
