//
//  FontModels.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 06.11.2022.
//

import UIKit

enum FontModel {
    static let nameFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let numberFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let skillFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    static let nameHeight = "NAME".height(withConstrainedWidth: 100, font: nameFont)
    static let numberHeight = "1234567".height(withConstrainedWidth: 100, font: numberFont)
    static let skillHeight = "> Skill".height(withConstrainedWidth: 100, font: skillFont)
}
