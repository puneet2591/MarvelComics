//
//  MarvelHomeViewController.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit
import IHProgressHUD

// Class for marvel comics

class MarvelHomeViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var viewModel: MarvelHomeViewModel!
    var marvelComics: [MarvelComicData]? {
        
        didSet {
            if let _ = self.marvelComics {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupTableView()
        setupViewModel()
    }
    
    // MARK: - Helper methods
    private func setupViewModel() {
        
        viewModel = MarvelHomeViewModel(delegate: self)
        viewModel.errorDelegate = self
        viewModel.loaderDelegate = self
        viewModel.getMarvelComicsList()
    }
    
    private func setupUI() {
        
        title = "Marvel Comics"
    }
    
    private func setupTableView() {
        
        tableView.registerCellOf(type: MarvellComicTableCell.self)
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: - ErrorProtocol

extension MarvelHomeViewController : ErrorProtocol {
    
    func didReceiveError(error: ErrorResponse?) {
        self.showToast(message: error?.message ?? "")
    }
    
}

//MARK: - LoaderProtocol

extension MarvelHomeViewController : LoaderProtocol {
    
    func showLoader(show: Bool) {
        
        show ? IHProgressHUD.showLoader() : IHProgressHUD.hideLoader()
        
    }
    
}


extension MarvelHomeViewController : MarvelHomeOutputProtocol {
    
    func didReceiveMarvelComics(data: MarvelComicsResponse) {
        self.marvelComics = data.data.results
    }
    
}



// MARK: - UITableViewDelegate Methods

extension MarvelHomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = StoryboardConstant.Main.viewController(type: MarvelCharacterListViewController.self) {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource Methods

extension MarvelHomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return marvelComics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.getReusableCellof(type: MarvellComicTableCell.self, forIndexPath: indexPath) else {
            
            return UITableViewCell()
        }
        
        cell.set(data: marvelComics?[indexPath.row])
        
        return cell
    }
    
}
