//
//  ViewController.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private let networkDataFetch = NetworkDataFetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        networkDataFetch.fetchCompany { result in
            switch result {
            case .success(let company):
                print(company)
            case .failure(let error):
                print(error.localizedDescription)
                if error._code == -1009 {
                    print("No internet")
                }
            case .none:
                print("none")
            }
        }
        
    }


}

