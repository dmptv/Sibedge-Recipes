//
//  ViewController.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

internal struct MainCellIdentifies {
    static var loadingCell = "LoadingCell"
    static var recipeCell = "RecipeCell"
    static var nothingFoundCell = "NothingFoundCell"
}

class MainViewController: UIViewController {
    
    var tableView: UITableView!
    var tableviewDatasourse = TableviewDataSourse()
    let seachController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewLoadings()
        setupTableView()
    }
    
    private func setupViewLoadings() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationItem.searchController = seachController
        navigationItem.hidesSearchBarWhenScrolling = true
        seachController.searchResultsUpdater = self
        seachController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        navigationItem.title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleSort))
        
    }
    
    @objc fileprivate func handleSort() {
        printMine("Sort Handle")
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = tableviewDatasourse
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinEdgesToSafeArea(of: view)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupTableVIewCells()
        
        tableView.reloadData()
    }
  
    fileprivate func setupTableVIewCells() {
//        var cellNib = UINib(nibName: MainCellIdentifies.loadingCell, bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: MainCellIdentifies.loadingCell)
        let cellNib = UINib(nibName: MainCellIdentifies.recipeCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainCellIdentifies.recipeCell)
//        cellNib = UINib(nibName: MainCellIdentifies.nothingFoundCell, bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: MainCellIdentifies.nothingFoundCell)
    }

    deinit {
        printMine("deinit: \(self)")
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailVC = DetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        // fix
        detailVC.recipe = Recipe.mockRecipe
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        tableView.reloadData()
    }
    
    
}










































