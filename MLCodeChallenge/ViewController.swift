//
//  ViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas 
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServiceFacade.searchItem(query: "ifon") { response in
            switch response {
            case .success(let items): print(items)
            case .failure(let error): print(error)
            }
        }
    }
}

