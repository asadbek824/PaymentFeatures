//
//  HomeViewController.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Core
import UIKit
import SharedUI

protocol HomeViewDisplayProtocol: AnyObject {
    func displayUserInitials(_ initials: String)
    func display(sections: [HomeSectionItem])
    func payShareTapped(senderModel: SenderModel)
    func payShareIntroTapped()
}

public final class HomeViewController: UIViewController {
    
    //MARK: Interactor And Router && Navigator
    private let interactor: HomeBusseinessProtocol
    private let router: HomeRoutingProtocol
    private var bannerCarousel: PopularBannerCarouselController?
    
    //MARK: UIElements
    private let navLeftButton = UIButton()
    private let navRightButton1 = UIButton()
    private let navRightButton2 = UIButton()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    )
    
    private var sections: [HomeSectionItem] = []
    
    //MARK: Properties
    private var userBalance: (balance: String, expenses: String, currency: String)?
    private var bannerImageAndTitle: (image: String, title: String)?
    
    init(
        interactor: HomeBusseinessProtocol,
        router: HomeRoutingProtocol
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadAllData()
        setUpView()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bannerCarousel?.stop()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(BalanceCell.self, forCellWithReuseIdentifier: BalanceCell.identifier)
        collectionView.register(PaymeGoCell.self, forCellWithReuseIdentifier: PaymeGoCell.identifier)
        collectionView.register(
            PayShareIntroCell.self,
            forCellWithReuseIdentifier: PayShareIntroCell.identifier
        )
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.register(
            FinicalServicesCell.self,
            forCellWithReuseIdentifier: FinicalServicesCell.identifier
        )
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - Creat Layout For CollectionView
private extension HomeViewController {
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard sectionIndex < self.sections.count else { return nil }
            switch self.sections[sectionIndex] {
            case .balance: return LayoutFactory.balanceLayout()
            case .paymeGo: return LayoutFactory.paymeGoLayout()
            case .payShareIntro: return LayoutFactory.payShareIntroLayout()
            case .banner: return LayoutFactory.bannerLayout()
            case .finicalServices: return LayoutFactory.financeServiceLayout()
            case .popular: return LayoutFactory.popularLayout()
            }
        }
        
        layout.register(
            BackgrounViewWhiteIsCornerRadiusExsistToTop.self,
            forDecorationViewOfKind: BackgrounViewWhiteIsCornerRadiusExsistToTop.reuseIdentifier
        )
        layout.register(
            BackgrounViewWhiteIsCornerRadiusExsistToBottom.self,
            forDecorationViewOfKind: BackgrounViewWhiteIsCornerRadiusExsistToBottom.reuseIdentifier
        )
        layout.register(
            BackgrounViewWhite.self,
            forDecorationViewOfKind: BackgrounViewWhite.reuseIdentifier
        )
        
        return layout
    }
}

//MARK: - HomeViewDisplayProtocol Implementation
extension HomeViewController: HomeViewDisplayProtocol {
    
    func payShareIntroTapped() {
        router.routeToPayShareIntro()
    }
    
    func payShareTapped(senderModel: SenderModel) {
        router.routeToPayShare(senderModel: senderModel)
    }
    
    func displayUserInitials(_ initials: String) {
        navLeftButton.setTitle(initials, for: .normal)
    }
    
    func display(sections: [HomeSectionItem]) {
        self.sections = sections
        DispatchQueue.main.async { self.collectionView.reloadData() }
        
        if let sectionIndex = sections.firstIndex(
            where: { if case .popular = $0 { return true } else { return false } }
        ),
           case .popular(let items) = sections[sectionIndex] {
            bannerCarousel = PopularBannerCarouselController(
                collectionView: collectionView,
                sectionIndex: sectionIndex,
                numberOfItems: items.count
            )
            bannerCarousel?.start()
        }
    }
}

//MARK: - CollectionView UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int { sections.count }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch sections[section] {
        case .balance: return 1
        case .banner: return 1
        case .payShareIntro: return 1
        case .paymeGo(let items): return items.count
        case .finicalServices(let items): return items.count
        case .popular(let items): return items.count
        }
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .balance(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BalanceCell.identifier,
                for: indexPath
            ) as? BalanceCell else { return UICollectionViewCell() }
            
            cell.configure(
                balance: viewModel.balance,
                balanceCurrency: viewModel.currency,
                expenses: viewModel.expenses,
                expenseCurrency: viewModel.currency,
                isHidden: viewModel.isHidden
            )
            
            return cell
        case .paymeGo(let items):
            let vm = items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymeGoCell.identifier,
                for: indexPath
            ) as? PaymeGoCell else { return UICollectionViewCell() }
            
            cell.configure(with: vm.image, title: vm.title)
            
            return cell
            
        case .payShareIntro(let item):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PayShareIntroCell.identifier,
                for: indexPath
            ) as? PayShareIntroCell else { return UICollectionViewCell() }
            
            cell.configure(with: item.image, title: item.title)
            
            return cell
        case .banner(let item):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath
            ) as? BannerCell  else { return UICollectionViewCell() }
            
            cell.configure(with: item.imageUrl, title: item.title)
            
            return cell
        case .finicalServices(let items):
            let vm = items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinicalServicesCell.identifier,
                for: indexPath
            ) as? FinicalServicesCell else { return UICollectionViewCell() }
            
            cell.configure(with: vm.title, image: vm.image)
            
            return cell
        case .popular(let items):
            let vm = items[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularCell.identifier,
                for: indexPath
            ) as? PopularCell else { return UICollectionViewCell() }
            
            cell.configure(with: vm.image, title: vm.title)
            
            return cell
        }
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch sections[indexPath.section] {
            case .finicalServices(_):
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? SectionHeaderView else {
                    return UICollectionReusableView()
                }
                header.configure(title: "Финансовые услуги")
                return header
            default: break
            }
        }
        return UICollectionReusableView()
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = sections[indexPath.section]
        
        switch section {
        case .paymeGo(let items):
            let item = items[indexPath.item]
            
            if item.title == "Payme Share" {
                interactor.payShareButtonTapped()
            }
            
        case .payShareIntro:
            
            interactor.payShareIntroSectionTapped()
            
        default: break
        }
    }
}
