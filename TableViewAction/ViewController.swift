//
//  ViewController.swift
//  TableViewAction
//
//  Created by Giuseppe Sapienza on 29/04/2019.
//  Copyright © 2019 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var array: [String] = [
        "Se ti va, iscriviti al canale 😘",
        "Aggiornare il tutorial sulle tableview su xCoding.it",
        "Rinnovare abbonamento Netflix",
        "Dare da mangiare a Cirù"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    @IBAction func addButton_clicked(_ sender: UIButton) {
        guard let text = self.inputTextField.text else { return }
        
        self.array.append(text) // insertAt
        
        let index = IndexPath.init(row: self.array.count - 1, section: 0)
        
        self.tableView.insertRows(
            at: [index],
            with: .fade)

        //self.tableView.reloadData()
    }

    @IBAction func editButton_clicked(_ sender: UIBarButtonItem) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.array[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("🤖", sourceIndexPath.row, destinationIndexPath.row)
        print(array)
        self.array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        print(array)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let action = UITableViewRowAction.init(
            style: .normal,
            title: "Delete")
        { (action, index) in
            print("🤖 Delete", index.row)
            
            self.array.remove(at: index.row)
            
            tableView.deleteRows(at: [index], with: .right)
            
        }
        
        action.backgroundColor = #colorLiteral(red: 0.9267585874, green: 0.367726624, blue: 0.3804723024, alpha: 1)
        
        let actionShare = UITableViewRowAction.init(
            style: .normal,
            title: "Share")
        { (action, index) in
            print("🤖 Share", index.row)
        }
        
        actionShare.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
        return [action, actionShare]
    }
    
}
