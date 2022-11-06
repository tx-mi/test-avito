//
//  EmployeeCell.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit



class EmployeeCell: UICollectionViewCell {
    
    static let id = "EmployeeCellID"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontModel.nameFont
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = FontModel.numberFont
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.font = FontModel.skillFont
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        backgroundColor = .white
        makeConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: InsetsModel.minInset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -InsetsModel.minInset),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: InsetsModel.minInset),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -InsetsModel.minInset),
        ])
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: -InsetsModel.minInset)
        ])
        contentView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            numberLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: -InsetsModel.minInset)
        ])
        contentView.addSubview(skillsLabel)
        NSLayoutConstraint.activate([
            skillsLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            skillsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            skillsLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(employee: Employee) {
        nameLabel.text = employee.name
        numberLabel.text = employee.phoneNumber
        var skillsText = ""
        for skill in employee.skills {
            skillsText += "►  \(skill)\n"
        }
        skillsLabel.text = skillsText
    }
    
    
}
