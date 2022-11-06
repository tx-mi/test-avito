//
//  EmployeesVC.swift
//  EmployeesVC
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

protocol EmployeesViewInput: AnyObject {
    func setup(employees: [Employee]?, title: String, cachedData: Company?)
}

final class EmployeesVC: UIViewController {
    
    // MARK: Properties
    var presenter: EmployeesViewOutput?
    
    private var employees: [Employee] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresher
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = self.refreshControl
        collectionView.register(
            EmployeeCell.self,
            forCellWithReuseIdentifier: EmployeeCell.id
        )
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .lightBlue
        view.addSubview(collectionView)
        presenter?.viewIsReady()
        refreshControl.beginRefreshing()
    }
    
    // MARK: Methods
    @objc private func refreshData() {
        presenter?.viewIsReady()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    
}


// MARK: - DataSource and Delegate

extension EmployeesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmployeeCell.id,
            for: indexPath) as? EmployeeCell
        else { return UICollectionViewCell() }
        cell.configure(employee: employees[indexPath.row])
        return cell
    }
    
}

// MARK: - FlowLayout

extension EmployeesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - InsetsModel.maxInset * 2
        // calc height offset
        var heightOffset: CGFloat = InsetsModel.minInset * 2
        let numberOfSkills = employees[indexPath.row].skills.count
        if numberOfSkills > 2 {
            heightOffset += FontModel.skillHeight * CGFloat(numberOfSkills - 2)
        }
        let height = FontModel.nameHeight + FontModel.numberHeight + heightOffset
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - ViewInput

extension EmployeesVC: EmployeesViewInput {
    
    func setup(employees: [Employee]?, title: String, cachedData: Company?) {
        guard let presenter else { return }
        guard let employees else {
            let alertController = presenter.errorLoadingAlert {[weak self] (action) in
                guard let self else { return }
                self.refreshControl.endRefreshing()
                if self.employees.isEmpty == false {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                // Show Cached data
                self.title = cachedData?.name
                self.navigationController?.setTitle(with: .black)
                self.employees = cachedData?.employees ?? []
            } retryActionHandler: {[weak self] (action) in
                self?.presenter?.viewIsReady()
            }
            navigationController?.present(alertController, animated: true)
            return
        }
        self.refreshControl.endRefreshing()
        self.title = title
        navigationController?.setTitle(with: .black)
        self.employees = employees
    }
    
    
}
