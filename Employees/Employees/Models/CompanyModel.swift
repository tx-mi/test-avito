//
//  CompanyModel.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import Foundation

// MARK: - CompanyModel
struct CompanyModel: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
