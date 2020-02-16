//
//  AddPizzaViewController.swift
//  Pizzr
//
//  Created by Dan Dunnington on 26/01/2020.
//  Copyright © 2020 Dan Dunnington. All rights reserved.
//

import Foundation
import UIKit
import LittleJohn

class AddPizzaViewController: ViewModelledViewController<AddPizzaViewModel> {
    
    // MARK: - UI Elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = "Name:"
        return label
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.addTarget(self, action: #selector(textInNameFieldChanged), for: .editingChanged)
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        return field
    }()
    
    private lazy var cheeseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cheese:"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var cheesePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private lazy var toppingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Toppings:"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var toppingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameField, cheeseLabel, cheesePicker, toppingsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        toppingsTableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(stackView)
        view.addSubview(toppingsTableView)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            toppingsTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            toppingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            toppingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            toppingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        nameField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override var navigationItem: UINavigationItem {
        let navItem = super.navigationItem
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                     target: self,
                                                     action: #selector(saveTapped))
        return navItem
    }
    
    // MARK: - Private Interface
    @objc private func textInNameFieldChanged() {
        viewModel.textChangedOnNameField(to: nameField.text)
    }
    
    @objc private func saveTapped() {
        viewModel.saveTapped()
    }
    
    private let cellIdentifier = "cell"
    
    deinit {
        print("Deinit on \(AddPizzaViewController.self)")
    }
}

extension AddPizzaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfPickerItems
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.titleForCheesePicker(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.cheesePickerSelected(index: row)
    }
}

extension AddPizzaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInTopping
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        let vm = viewModel.cellForToppingItem(at: indexPath.row)
        cell?.textLabel?.text = vm.title
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedToppingCell(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.deselectedToppingCell(at: indexPath.row)
    }
}

extension AddPizzaViewController {
    private class Cell: UITableViewCell {
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            self.accessoryType = selected ? .checkmark : .none
        }
        
    }
}
