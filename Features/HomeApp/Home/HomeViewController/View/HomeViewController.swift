//
//  HomeViewController.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import UIKit
import Core

protocol HomeViewDisplayProtocol: AnyObject {
    func updateUserInitials(_ initials: String)
}

public final class HomeViewController: UIViewController {
    
    private let interactor: HomeBusseinessProtocol
    private let router: HomeRoutingProtocol
    
    private let navLeftButton = UIButton()
    private let navRightButton1 = UIButton()
    private let navRightButton2 = UIButton()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(interactor: HomeBusseinessProtocol, router: HomeRoutingProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        loadUserData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: LoadUser Data
extension HomeViewController {
    
    func loadUserData() {
        Task {
            await interactor.loadUserData()
        }
    }
}

//MARK: - SetUpView
extension HomeViewController {
    
    func setUpView() {
        view.backgroundColor = .appColor.primary
        
        setUpNavBar()
    }
    
    func setUpNavBar() {
        navLeftButton.setTitle("??", for: .normal)
        navLeftButton.setTitleColor(.white, for: .normal)
        navLeftButton.backgroundColor = .appColor.green
        navLeftButton.setConstraint(.width, from: view, 40)
        navLeftButton.setConstraint(.height, from: view, 40)
        navLeftButton.layer.cornerRadius = 20
        navLeftButton.clipsToBounds = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLeftButton)

        let config = UIImage.SymbolConfiguration(pointSize: 22)

        let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
        navRightButton1.setImage(searchImage, for: .normal)
        navRightButton1.tintColor = .appColor.secondary
        navRightButton1.setConstraint(.width, from: view, 40)
        navRightButton1.setConstraint(.height, from: view, 40)
        let barButton1 = UIBarButtonItem(customView: navRightButton1)

        let bellImage = UIImage(systemName: "bell", withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
        navRightButton2.setImage(bellImage, for: .normal)
        navRightButton2.tintColor = .appColor.secondary
        navRightButton2.setConstraint(.width, from: view, 40)
        navRightButton2.setConstraint(.height, from: view, 40)
        let barButton2 = UIBarButtonItem(customView: navRightButton2)

        navigationItem.rightBarButtonItems = [barButton2, barButton1]
    }
}

//MARK: - HomeViewDisplayProtocol Implementation
extension HomeViewController: HomeViewDisplayProtocol {
    func updateUserInitials(_ initials: String) {
        navLeftButton.setTitle(initials, for: .normal)
    }
}
