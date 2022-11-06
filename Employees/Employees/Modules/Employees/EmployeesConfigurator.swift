//
//  EmployeesConfigurator.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

final class EmployeesConfigurator {
    
    static func configure() -> UIViewController {
        let view = EmployeesVC()
        let presenter = EmployeesPresenter(view: view)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
}
