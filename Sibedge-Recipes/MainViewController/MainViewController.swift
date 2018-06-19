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
    enum SearchState {
        case name
        case description
        case instruction
    }
    
     var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        tableView.estimatedRowHeight = 110
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Name", "Description", "Instruction"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentChanged(_ :)), for: .valueChanged)
        return sc
    }()
    
    @objc private func segmentChanged(_ control: UISegmentedControl) {
        
        switch control.selectedSegmentIndex {
        case 1:
           searchState = .name
        case 2:
            searchState = .description
        case 3:
            searchState = .instruction
        default:
            searchState = .name
        }
    }
    
    let seachController = UISearchController(searchResultsController: nil)
    var mainTableviewDatasourse = MainTableviewDataSourse()
    var searchState = SearchState.name

    private var recipes = [Recipe]()
    private var filteredRecipes = [Recipe]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewLoadings()
        setupTableView()
        setupSegmentedControl()
        
        getData()
    }
    
    private func getData() {
        ApiClient.shared.loadData { [weak self]  result in
            
             guard let strongSelf = self else { return }
            
            switch result {
            case .sucsess(let value as AnyObject):
                
                if let data = value["recipes"] as? [Json] {
                    
                    data.forEach { json in
                        let recipe = Recipe.createRecipe(json: json)
                        strongSelf.recipes.append(recipe)
                    }

                    DispatchQueue.main.async {
                        strongSelf.mainTableviewDatasourse.recipes = strongSelf.recipes
                        strongSelf.tableView.reloadData()
                    }

                }
           
                break
            case .failure:
                printMine("failure")
                break
            }
        }
    }
    
    private func setupViewLoadings() {
        view.backgroundColor = .white

        navigationItem.searchController = seachController
        navigationItem.hidesSearchBarWhenScrolling = true
        seachController.searchResultsUpdater = self
        seachController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        navigationItem.title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleSort))
    }
    
    @objc fileprivate func handleSort() {
        // FIXME: - implement sorting
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = mainTableviewDatasourse
        tableView.pinEdgesToSafeArea(of: view)
        
        setupTableVIewCells()
        tableView.reloadData()
    }
    
    private func setupSegmentedControl() {
        navigationItem.titleView = segmentedControl
    }
  
    fileprivate func setupTableVIewCells() {
        let cellNib = UINib(nibName: MainCellIdentifies.recipeCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainCellIdentifies.recipeCell)
    }

    deinit {
        printMine("deinit: \(self)")
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailVC = DetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        //FIXME: -  pass real data
        detailVC.recipe = Recipe.mockRecipe
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        //FIXME: - implement search result
        
        filteredRecipes = recipes.filter({ [weak self] (recipe) -> Bool in
            guard let strongSelf = self else {return false}
            switch strongSelf.searchState {
            case .name:
                 return recipe.name.contains(searchController.searchBar.text!)
            case .description:
                 return recipe.description.contains(searchController.searchBar.text!)
            case .instruction:
                 return recipe.instructions.contains(searchController.searchBar.text!)
            }
        })
        
        tableView.reloadData()
    }
    
}













