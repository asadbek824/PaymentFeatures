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
    func updateUserBalanceAndExpensess(_ balance: String, _ expensess: String, _ currency: String)
}

public final class HomeViewController: UIViewController {
    
    //MARK: Interactor And Router
    private let interactor: HomeBusseinessProtocol
    private let router: HomeRoutingProtocol
    
    //MARK: UIElements
    private let navLeftButton = UIButton()
    private let navRightButton1 = UIButton()
    private let navRightButton2 = UIButton()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout(
                sectionStates: Array(repeating: false, count: HomeViewSectionTypes.allCases.count),
                sectionIndex: .zero
            )
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(BalanceCell.self, forCellWithReuseIdentifier: BalanceCell.identifier)
        
        
        return collectionView
    }()
    
    //MARK: Properties
    private var userBalance: (balance: String, expenses: String, currency: String)?
    
    init(interactor: HomeBusseinessProtocol, router: HomeRoutingProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: LoadUser Data
private extension HomeViewController {
    
    func loadUserData() {
        Task {
            await interactor.loadUserData()
            await interactor.loadUserCarts()
        }
    }
}

//MARK: - SetUpView
private extension HomeViewController {
    
    func setUpView() {
        view.backgroundColor = .appColor.primary
        
        setUpNavBar()
        setUpCollectionView()
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
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.setConstraint(.bottom, from: view, .zero)
        collectionView.setConstraint(.left, from: view, .zero)
        collectionView.setConstraint(.right, from: view, .zero)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - Creat Layout For CollectionView
private extension HomeViewController {
    
    func createLayout(sectionStates: [Bool], sectionIndex: Int) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (
            sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment
        ) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            guard let sectionType = HomeViewSectionTypes(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .balance:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(UIScreen.main.bounds.width),
                    heightDimension: .absolute(100)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
//            case .paymeGo:
//                <#code#>
//            case .banner:
//                <#code#>
//            case .popular:
//                <#code#>
            }
            
            return section
        }
        return layout
    }
}

//MARK: - HomeViewDisplayProtocol Implementation
extension HomeViewController: HomeViewDisplayProtocol {
    
    func updateUserInitials(_ initials: String) {
        navLeftButton.setTitle(initials, for: .normal)
    }
    
    func updateUserBalanceAndExpensess(_ balance: String, _ expensess: String, _ currency: String) {
        self.userBalance = (balance, expensess, currency)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - CollectionView UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return HomeViewSectionTypes.allCases.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let sectionType = HomeViewSectionTypes(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BalanceCell.identifier,
            for: indexPath
        ) as? BalanceCell else { return UICollectionViewCell() }
        
        switch sectionType {
        case .balance:
            if let userBalance = userBalance {
                cell.balanceLabel.text = userBalance.balance
                cell.expenseLabel.text = "- \(userBalance.expenses)"
                cell.balanceCurrencyLabel.text = userBalance.currency
                cell.expenseCurrencyLabel.text = userBalance.currency
            }
        }
        return cell
    }
}
