//
//  UINavigationController+Ext.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 06.11.2022.
//

import UIKit

extension UINavigationController {
    func setTitle(with color: UIColor) {
        navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
}
