//
//  EmployeesVC.swift
//  EmployeesVC
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import UIKit

protocol EmployeesViewInput: AnyObject {
    
}

final class EmployeesVC: UIViewController {
    
    // MARK: Properties
    private let network = NetworkDataFetch()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresher
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UICollectionViewFlowLayout()
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
        // get data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
    }
    
    // MARK: Methods
    @objc private func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    
}


// MARK: - DataSource and Delegate

extension EmployeesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmployeeCell.id,
            for: indexPath) as? EmployeeCell
        else { return UICollectionViewCell() }
//        cell.configure()
        return cell
    }
    
}

// MARK: - FlowLayout

extension EmployeesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 32, height: view.frame.height / 6)
    }
    
}
