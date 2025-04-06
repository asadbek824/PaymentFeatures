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
    func updateBannerImageAndTitle(_ imageUrl: String, _ title: String)
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
        collectionView.register(PaymeGoCell.self, forCellWithReuseIdentifier: PaymeGoCell.identifier)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        
        return collectionView
    }()
    
    //MARK: Properties
    private var userBalance: (balance: String, expenses: String, currency: String)?
    private var bannerImageAndTitle: (image: String, title: String)?
    
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
            await interactor.loadBanner()
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
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(UIScreen.main.bounds.width),
                    heightDimension: .absolute(100)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
            case .paymeGo:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1 / 3),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(UIScreen.main.bounds.width),
                    heightDimension: .estimated(150)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case .banner:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(UIScreen.main.bounds.width),
                    heightDimension: .absolute(96)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)

                let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: BackgrounViewWhiteIsCornerRadiusExsist.reuseIdentifier)
                backgroundDecoration.contentInsets = .zero

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.decorationItems = [backgroundDecoration]
            @unknown default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .estimated(120)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(320),
                    heightDimension: .estimated(120)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }
            
            return section
        }
        
        layout.register(BackgrounViewWhite.self, forDecorationViewOfKind: BackgrounViewWhite.reuseIdentifier)
        layout.register(BackgrounViewWhiteIsCornerRadiusExsist.self, forDecorationViewOfKind: BackgrounViewWhiteIsCornerRadiusExsist.reuseIdentifier)
        
        return layout
    }
    
    func collectionViewReloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - HomeViewDisplayProtocol Implementation
extension HomeViewController: HomeViewDisplayProtocol {
    
    func updateUserInitials(_ initials: String) {
        navLeftButton.setTitle(initials, for: .normal)
    }
    
    func updateUserBalanceAndExpensess(_ balance: String, _ expensess: String, _ currency: String) {
        self.userBalance = (balance, expensess, currency)
        
        collectionViewReloadData()
    }
    
    func updateBannerImageAndTitle(_ imageUrl: String, _ title: String) {
        self.bannerImageAndTitle = (imageUrl, title)
        
        collectionViewReloadData()
    }
}

//MARK: - CollectionView UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeViewSectionTypes.allCases.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let sectionType = HomeViewSectionTypes(rawValue: section) else { return 0 }
        return sectionType.getNumberOfItems()
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let sectionType = HomeViewSectionTypes(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch sectionType {
        case .balance:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BalanceCell.identifier,
                for: indexPath
            ) as? BalanceCell else { return UICollectionViewCell() }
            
            if let userBalance = userBalance {
                cell.balanceLabel.text = userBalance.balance
                cell.expenseLabel.text = "- \(userBalance.expenses)"
                cell.balanceCurrencyLabel.text = userBalance.currency
                cell.expenseCurrencyLabel.text = userBalance.currency
            }
            return cell
        case .paymeGo:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymeGoCell.identifier,
                for: indexPath
            ) as? PaymeGoCell else { return UICollectionViewCell() }
            
            switch indexPath.item {
            case 0: cell.configure(with: UIImage(systemName: "applelogo"), title: "Мои карты")
            case 1: cell.configure(with: UIImage(systemName: "applelogo"), title: "Payme Go")
            case 2: cell.configure(with: UIImage(systemName: "applelogo"), title: "QR оплата")
            default: break
            }
            
            return cell
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath
            ) as? BannerCell else { return UICollectionViewCell() }
            
            if let bannerImageAndTitle = bannerImageAndTitle {
                cell.configure(with: bannerImageAndTitle.image, title: bannerImageAndTitle.title)
            }
            
            return cell
        @unknown default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            return cell
        }
        
    }
}
