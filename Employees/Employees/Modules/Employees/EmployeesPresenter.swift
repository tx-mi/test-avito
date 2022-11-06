//
//  EmployeesPresenter.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import Foundation

protocol EmployeesViewOutput: AnyObject {
    func viewIsReady()
}

final class EmployeesPresenter: EmployeesViewOutput {
    
    private var view: EmployeesViewInput
    
    private let networkFetcher = NetworkDataFetch()
    
    init(view: EmployeesViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        networkFetcher.fetchCompany { result in
            switch result {
            case .success(let company):
                self.view.setup(employees: company.employees, title: company.name)
            case .failure(let error):
                print(error.localizedDescription)
                if error._code == -1009 {
                    self.view.setup(employees: [Employee(name: "Net ineta", phoneNumber: "", skills: [])], title: "Error")
                    print("Net ineta!!!")
                }
            case .none:
                print("none")
            }
        }
        
    }
    
}
