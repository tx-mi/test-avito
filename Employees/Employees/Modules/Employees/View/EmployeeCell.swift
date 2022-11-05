//
//  EmployeeCell.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

class EmployeeCell: UICollectionViewCell {
    
    static let id = "EmployeeCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
