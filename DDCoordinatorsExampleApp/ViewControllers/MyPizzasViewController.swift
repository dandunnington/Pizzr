//
//  MyPizzasViewController.swift
//  DDCoordinatorsExampleApp
//
//  Created by Dan Dunnington on 05/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import DDCoordinators
import UIKit

class MyPizzasViewController: ViewModelledViewController<MyPizzasViewModel> {
    
    // MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    override var navigationItem: UINavigationItem {
        let navItem = super.navigationItem
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        return navItem
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UI Actions
    @objc private func addTapped() {
        viewModel.addTapped()
    }
    
    // MARK: - Private Interface
    private let cellIdentifier = "cell"
}

extension MyPizzasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cellForRowAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
}

extension MyPizzasViewController {
    
    class Cell: UITableViewCell {
        
        // MARK: - Public Interface
        internal func configure(with viewModel: MyPizzasViewModel.Cell) {
            mainLabel.text = viewModel.titleText
            middleLabel.text = viewModel.middleText
            bottomLabel.text = viewModel.bottomText
        }
        
        // MARK: - UI Elements
        private lazy var mainLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            return label
        }()
        
        private lazy var middleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .gray
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        private lazy var bottomLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 12)
            label.textColor = .gray
            return label
        }()
        
        private lazy var stackView: UIStackView = {
            let stackView = UIStackView(
                arrangedSubviews: [mainLabel, middleLabel, bottomLabel]
            )
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 8
            stackView.axis = .vertical
            return stackView
        }()
        
        // MARK: - Overrides
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}
