//
//  EmployeesPresenter.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

protocol EmployeesViewOutput: AnyObject {
    func viewIsReady()
    func errorLoadingAlert(
        downloadActionHandler: @escaping ((UIAlertAction) -> Void),
        retryActionHandler: @escaping ((UIAlertAction) -> Void)
    ) -> UIAlertController
    
}

final class EmployeesPresenter: EmployeesViewOutput {
    
    private var view: EmployeesViewInput
    
    private let networkFetcher = NetworkDataFetch()
    private var cache = Cache<Int, Company>()
    
    init(view: EmployeesViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        networkFetcher.fetchCompany { result in
            switch result {
            case .success(let company):
                self.cache[0] = nil
                self.cache[0] = company
                self.view.setup(employees: company.employees, title: company.name, cachedData: self.cache[0])
            case .failure(let error):
                print(error.localizedDescription)
                if error._code == -1009 {
                    self.view.setup(employees: nil, title: "Error", cachedData: self.cache[0])
                    print("Net ineta!!!")
                }
            case .none:
                print("none")
            }
        }
        
    }
    
    func errorLoadingAlert(downloadActionHandler: @escaping ((UIAlertAction) -> Void),
                                   retryActionHandler: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: "Не удалось загрузить данные изза отсутсвия интернета.\nЗагрузить последние закэшированные данные?",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default, handler: downloadActionHandler)
        let retryAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: retryActionHandler)
        alertController.addAction(yesAction)
        alertController.addAction(retryAction)
        return alertController
    }
    
}
