//
//  RecipeCell.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var imgVIew: CustomImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(recipe: Recipe) {
        imgVIew.loadImage(urlString: recipe.images[0])
        nameLbl.text = recipe.name
        descriptionLbl.text = recipe.description
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
