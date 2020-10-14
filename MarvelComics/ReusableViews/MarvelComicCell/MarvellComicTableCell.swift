//
//  MarvellComicTableCell.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit
import SDWebImage

class MarvellComicTableCell: UITableViewCell {

    @IBOutlet weak var comicDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var marvelImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: MarvelComicData?) {
        
        // Since this is ui binding
        // This should happen in main thread
        
        DispatchQueue.main.async {
            
            if let data = data {
                
                // Bind data
                self.name.text = data.title
                self.comicDescription.text = data.description ?? "N/A"
                
                self.marvelImage.sd_setImage(with: data.getThumbnailUrl(), completed: nil)
            }
        }
    }
    
}
