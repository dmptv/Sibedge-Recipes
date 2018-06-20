//
//  TableviewDataSourse.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class MainTableviewDataSourse: NSObject, UITableViewDataSource {
    
    var recipes: [Recipe]!
    var filteredRecipes: [Recipe]!
    var isSeachActive = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes == nil {
            return 0
        }
        
        if isSeachActive {
            return filteredRecipes.count
        }
        
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: MainCellIdentifies.recipeCell, for: indexPath) as! RecipeCell
        
        let recipe: Recipe
        recipe = isSeachActive ? filteredRecipes[indexPath.row] : recipes[indexPath.row]
        cell.configure(recipe: recipe)
        
        return cell
    }
    
    
    
}




















