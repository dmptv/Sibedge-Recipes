//
//  DescriptionCell.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    @IBOutlet weak var textlbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var recipeText: String? {
        didSet {
            guard let recipeText = recipeText, recipeText != "" else {
                descriptionLbl.text = ""
                return
            }

            let str = recipeText.replacingOccurrences(of: "<br>", with: "\n", options: .regularExpression, range: nil)
            
            let attributesText = NSMutableAttributedString(string: str, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)])
            
            descriptionLbl.attributedText = attributesText
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(_ recipe: Recipe) {
        textlbl.text = "Description"
    }
    

}















