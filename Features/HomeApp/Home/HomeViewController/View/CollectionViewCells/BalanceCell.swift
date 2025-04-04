//
//  BalanceCell.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import UIKit
import Core

final class BalanceCell: UICollectionViewCell {
    
    static let identifier = "BalanceCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Общий баланс"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .appColor.secondary
        label.textAlignment = .center
        return label
    }()
    private let expensesLabel: UILabel = {
        let label = UILabel()
        label.text = "расход за"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .appColor.secondary
        label.textAlignment = .center
        return label
    }()
    private let balanceHideLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .appColor.secondary
        button
        return button
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .appColor.secondary
        return button
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .appColor.secondary
        return label
    }()
    let balanceCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .appColor.secondary
        return label
    }()
    let expenseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .appColor.secondary
        return label
    }()
    let expenseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .appColor.secondary
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View
private extension BalanceCell {
    
    func setUpView() {
        backgroundColor = .clear
        
        let balanceAndCurrencyStack = UIStackView(arrangedSubviews: [balanceLabel, balanceCurrencyLabel])
        balanceAndCurrencyStack.axis = .horizontal
        balanceAndCurrencyStack.spacing = CGFloat(integerLiteral: .eight)
        balanceAndCurrencyStack.alignment = .bottom
        balanceAndCurrencyStack.distribution = .fill
        
        let stack = UIStackView(arrangedSubviews: [eyeButton, balanceAndCurrencyStack, moreButton])
        stack.axis = .horizontal
        stack.spacing = CGFloat(integerLiteral: .twentyFour)
        stack.alignment = .center
        stack.distribution = .fill
        
        let expensessStackView = UIStackView(arrangedSubviews: [expensesLabel, expenseLabel, expenseCurrencyLabel])
        expensessStackView.axis = .horizontal
        expensessStackView.spacing = CGFloat(integerLiteral: .eight)
        expensessStackView.alignment = .center
        expensessStackView.distribution = .fill
        
        let mainStack = UIStackView(arrangedSubviews: [titleLabel, stack, expensessStackView])
        mainStack.axis = .vertical
        mainStack.spacing = CGFloat(integerLiteral: .eight)
        mainStack.alignment = .center
        
        contentView.addSubview(mainStack)
        
        mainStack.setConstraint(.top, from: self, CGFloat(integerLiteral: .ten))
        mainStack.setConstraint(.bottom, from: self, CGFloat(integerLiteral: .ten))
        mainStack.setConstraint(.left, from: self, CGFloat(integerLiteral: .ten))
        mainStack.setConstraint(.right, from: self, CGFloat(integerLiteral: .ten))
    }
}

//MARK: - @objc Functions
private extension BalanceCell {
    
    @objc func eyeButtonTapped() {
        
    }
}
