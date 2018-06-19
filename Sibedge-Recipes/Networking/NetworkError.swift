//
//  NetworkError.swift
//  Sibedge-Recipes
//
//  Created by 123 on 19.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//


import UIKit

enum NetworkError {
    case failed
}

internal func showNetworkError(controller: UIViewController) {
    let alert = UIAlertController(title: NSLocalizedString("Whoops...", comment: ""),
                                  message: NSLocalizedString("Error", comment: ""),
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
    alert.addAction(action)
    controller.present(alert, animated: true, completion: nil)
}
