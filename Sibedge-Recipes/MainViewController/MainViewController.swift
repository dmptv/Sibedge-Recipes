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
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([Recipe])
    }

    private var state: State = .notSearchedYet
    private var sortCase = false
    
     var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()

    let seachController = UISearchController(searchResultsController: nil)
    var mainTableviewDatasourse = MainTableviewDataSourse()
    
    private var recipes = [Recipe]()
    private var filteredRecipes = [Recipe]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewLoadings()
        setupTableView()
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
                    
                    strongSelf.recipes.sort(by: { (r1, r2) -> Bool in
                        return r1.lastUpdated < r2.lastUpdated
                    })

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
        
        seachController.searchBar.scopeButtonTitles = ["Name", "Description", "Instruction"]
        seachController.searchBar.placeholder = "Search"
        seachController.searchBar.delegate = self
        
        navigationItem.title = "Recipes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleSort))
    }
    
    @objc fileprivate func handleSort() {
        sortCase = !sortCase
        recipes.sort(by: { (r1, r2) -> Bool in
            return sortCase ? r1.lastUpdated > r2.lastUpdated : r1.lastUpdated < r2.lastUpdated
        })
        DispatchQueue.main.async {
            self.mainTableviewDatasourse.recipes = self.recipes
            self.tableView.reloadData()
        }
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

    fileprivate func setupTableVIewCells() {
        let cellNib = UINib(nibName: MainCellIdentifies.recipeCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainCellIdentifies.recipeCell)
    }

}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let detailVC = DetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let recipe: Recipe = seachController.isActive ? filteredRecipes[indexPath.row] : recipes[indexPath.row]
        
        detailVC.recipe = recipe
        detailVC.navigationItem.title = recipe.name
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        perfomSearch(searchController.searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        perfomSearch(searchBar)
    }
    
    private func perfomSearch(_ searchBar: UISearchBar) {
        filteredRecipes = recipes.filter { recipe -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                return recipe.name.contains(searchBar.text!)
            case 1:
                return recipe.description.contains(searchBar.text!)
            case 2:
                return recipe.instructions.contains(searchBar.text!)
            default:
                return recipe.name.contains(searchBar.text!)
            }
        }
        mainTableviewDatasourse.filteredRecipes = filteredRecipes
        mainTableviewDatasourse.isSeachActive = seachController.isActive
        tableView.reloadData()
    }
    
}













