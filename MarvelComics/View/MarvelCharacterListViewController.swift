//
//  MarvelCharacterListViewController.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit
import IHProgressHUD

// Class for list out the marvel characters

class MarvelCharacterListViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var marvelCharacters: [MarvelCharacterData]? {
        
        didSet {
            if let _ = self.marvelCharacters {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var viewModel: MarvelCharacterListViewModel!
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupTableView()
        setupViewModel()
    }

    // MARK: - Helper methods
    
    private func setupUI() {
        
        title = "Marvel Characters"
    }
    
    private func setupTableView() {
        
        tableView.registerCellOf(type: MarvelCharacterTableCell.self)
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        
        viewModel = MarvelCharacterListViewModel(delegate: self)
        viewModel.errorDelegate = self
        viewModel.loaderDelegate = self
        viewModel.getMarvelCharactersList()
    }
}



// MARK: - UITableViewDelegate Methods

extension MarvelCharacterListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = StoryboardConstant.Main.viewController(type: MarvelCharacterDetailViewController.self) {
            vc.characterData = self.marvelCharacters?[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource Methods

extension MarvelCharacterListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return marvelCharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.getReusableCellof(type: MarvelCharacterTableCell.self, forIndexPath: indexPath) else {
            
            return UITableViewCell()
        }
        
        cell.setCharacter(data: marvelCharacters?[indexPath.row])
        
        return cell
    }
    
}



//MARK: - ErrorProtocol

extension MarvelCharacterListViewController : ErrorProtocol {
    
    func didReceiveError(error: ErrorResponse?) {
        self.showToast(message: error?.message ?? "")
    }
    
}

//MARK: - LoaderProtocol

extension MarvelCharacterListViewController : LoaderProtocol {
    
    func showLoader(show: Bool) {
        
        show ? IHProgressHUD.showLoader() : IHProgressHUD.hideLoader()
        
    }
    
}

//MARK: - MarvelCharacterListOutputProtocol

extension MarvelCharacterListViewController : MarvelCharacterListOutputProtocol {
    
    func didReceiveMarvelCharacters(data: MarvelCharactersResponse) {
        self.marvelCharacters = data.data.results
    }
    
}
