//
//  MarvelCharacterDetailViewController.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit

// Class for character detail like: Comics, Series, Stories

class MarvelCharacterDetailViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var characterData: MarvelCharacterData?
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        bindData()
    }
    
    //MARK: - Helper methods
    
    private func bindData() {
        
        DispatchQueue.main.async {

            if let character = self.characterData {
                self.title = character.name
                
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        
        tableView.registerCellOf(type: MarvelCharacterDetailTableCell.self)
        tableView.registerCellOf(type: MarvellCharacterHeaderTableCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    

}


//MARK: - UITableViewDelegate

extension MarvelCharacterDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 { return 0 }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width, height: 50))
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        if section == 0 {
            return nil
        } else if section == 1 {
            if self.characterData?.comics.items.count ?? 0 > 0 {
                label.text = "Comics"
            } else {
                label.text = ""
            }
        } else if section == 2 {
            if self.characterData?.stories.items.count ?? 0 > 0 {
                label.text = "Stories"
            } else {
                label.text = ""
            }
            
        } else {
            if self.characterData?.series.items.count ?? 0 > 0 {
                label.text = "Series"
            } else {
                label.text = ""
            }
            
        }
        
        return label
    }
}

//MARK: - UITableViewDataSource

extension MarvelCharacterDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return UITableView.automaticDimension }
        
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.getReusableCellof(type: MarvellCharacterHeaderTableCell.self, forIndexPath: indexPath) else {
                
                return UITableViewCell()
            }
            
            cell.set(data: self.characterData)
            
            return cell
        }
        else if indexPath.section == 1 {
            
            guard let cell = tableView.getReusableCellof(type: MarvelCharacterDetailTableCell.self, forIndexPath: indexPath) else {
                
                return UITableViewCell()
            }
            
            
            cell.characterData = self.characterData?.comics.items
            
            return cell
        }
        else if indexPath.section == 2 {
            
            guard let cell = tableView.getReusableCellof(type: MarvelCharacterDetailTableCell.self, forIndexPath: indexPath) else {
                
                return UITableViewCell()
            }
            
            cell.characterData = self.characterData?.stories.items
            
            return cell
        }
        else {
            
            guard let cell = tableView.getReusableCellof(type: MarvelCharacterDetailTableCell.self, forIndexPath: indexPath) else {
                
                return UITableViewCell()
            }
            
            cell.characterData = self.characterData?.series.items
            
            return cell
        }
    }
    
}
