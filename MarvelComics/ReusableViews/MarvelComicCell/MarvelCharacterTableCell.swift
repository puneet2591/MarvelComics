//
//  MarvelCharacterTableCell.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit

class MarvelCharacterTableCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCharacter(data: MarvelCharacterData?) {
        
        DispatchQueue.main.async {
            if let data = data {
                self.characterName.text = data.name
            }
        }
    }
    
}
