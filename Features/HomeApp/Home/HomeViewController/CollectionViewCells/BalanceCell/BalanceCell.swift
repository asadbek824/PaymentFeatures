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

    // MARK: - State
    private var isBalanceHidden = false {
        didSet {
            updateUIVisibility()
        }
    }
    
    // MARK: - UI Components
    private lazy var titleLabel = makeLabel(
        text: "Общий баланс",
        font: .systemFont(ofSize: 16),
        alignment: .center
    )

    private lazy var expensesLabel = makeLabel(
        text: "расход за",
        font: .systemFont(ofSize: 14)
    )
    lazy var balanceLabel = makeLabel(font: .boldSystemFont(ofSize: 32))
    lazy var balanceCurrencyLabel = makeLabel(font: .systemFont(ofSize: 16))
    lazy var expenseLabel = makeLabel(font: .systemFont(ofSize: 14))
    lazy var expenseCurrencyLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var balanceHiddenLabel = makeLabel(
        text: "ПОКАЗАТЬ БАЛАНС",
        font: .boldSystemFont(ofSize: 16),
        alignment: .center
    )

    private lazy var eyeButton: UIButton = makeIconButton(
        systemName: "eye.slash",
        action: #selector(toggleBalanceVisibility)
    )
    private lazy var moreButton: UIButton = makeIconButton(systemName: "ellipsis")

    private let contentStack = UIStackView()
    private let balanceStack = UIStackView()
    private let expenseStack = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        updateUIVisibility()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Method
extension BalanceCell {
    func configure(
        balance: String,
        balanceCurrency: String,
        expenses: String,
        expenseCurrency: String,
        isHidden: Bool
    ) {
        balanceLabel.text = balance
        balanceCurrencyLabel.text = balanceCurrency
        expenseLabel.text = expenses
        expenseCurrencyLabel.text = expenseCurrency
        isBalanceHidden = isHidden
    }
}

// MARK: - Layout & UI
private extension BalanceCell {
    
    func setupLayout() {
        backgroundColor = .clear

        let balanceRow = UIStackView(arrangedSubviews: [eyeButton, makeBalanceRow(), moreButton])
        balanceRow.axis = .horizontal
        balanceRow.spacing = 24
        balanceRow.alignment = .center

        expenseStack.axis = .horizontal
        expenseStack.spacing = 8
        expenseStack.alignment = .center
        expenseStack.addArrangedSubview(expensesLabel)
        expenseStack.addArrangedSubview(expenseLabel)
        expenseStack.addArrangedSubview(expenseCurrencyLabel)

        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(balanceRow)
        contentStack.addArrangedSubview(expenseStack)
        
        contentView.addSubview(contentStack)

        contentStack.setConstraint(.top, from: self, 10)
        contentStack.setConstraint(.bottom, from: self, 10)
        contentStack.setConstraint(.left, from: self, 10)
        contentStack.setConstraint(.right, from: self, 10)
    }
    
    func makeBalanceRow() -> UIStackView {
        let stack = UIStackView(
            arrangedSubviews: [balanceLabel, balanceHiddenLabel, balanceCurrencyLabel]
        )
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .bottom
        return stack
    }
    
    func updateUIVisibility() {
        UIView.transition(with: contentView, duration: 0.3, options: [.transitionCrossDissolve]) {
            self.titleLabel.isHidden = self.isBalanceHidden
            self.balanceLabel.isHidden = self.isBalanceHidden
            self.balanceCurrencyLabel.isHidden = self.isBalanceHidden
            self.expenseLabel.isHidden = self.isBalanceHidden
            self.expenseCurrencyLabel.isHidden = self.isBalanceHidden
            self.expensesLabel.isHidden = self.isBalanceHidden
            self.balanceHiddenLabel.isHidden = !self.isBalanceHidden

            let iconName = self.isBalanceHidden ? "eye" : "eye.slash"
            self.eyeButton.setImage(UIImage(systemName: iconName), for: .normal)
        }
    }
    
    @objc func toggleBalanceVisibility() {
        isBalanceHidden.toggle()
    }
}

// MARK: - Factory Methods
private extension BalanceCell {
    
    func makeLabel(
        text: String? = nil,
        font: UIFont,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = .appColor.secondary
        label.textAlignment = alignment
        return label
    }

    func makeIconButton(systemName: String, action: Selector? = nil) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .appColor.secondary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        return button
    }
}
