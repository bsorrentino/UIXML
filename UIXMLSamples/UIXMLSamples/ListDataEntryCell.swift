//
//  ListDataEntryCell.swift
//  UIXMLSamples
//
//  Created by softphone on 22/11/2017.
//  Copyright © 2017 soulsoftware. All rights reserved.
//

import Foundation
import UIKit


@objc class ListDataViewController : UITableViewController, UIAlertViewDelegate {
    
    private var data:Array<String> = [ "item1", "item2"]
    private weak var cell:BaseDataEntryCell?

    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        // Add Edit Button
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    }
    
    private func insertNewObject() {
        
        let alert = UIAlertController(
            title: NSLocalizedString("ListDataEntryCell.alertTitle", tableName:"add new Item", comment: ""),
            message: NSLocalizedString("ListDataEntryCell.alertMessage", tableName:"add item message", comment:""),
            preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (tf:UITextField) in
            tf.placeholder = NSLocalizedString("ListDataEntryCell.alertPlaceholder", tableName: "add item placeholder", comment:"")
            tf.backgroundColor = UIColor.white
            tf.clearButtonMode = .whileEditing;
            tf.keyboardType = .alphabet;
            tf.keyboardAppearance = .alert;
            tf.autocapitalizationType = .words;
            tf.autocorrectionType = .no;
            //tf.becomeFirstResponder()

        }
        alert.addAction( UIAlertAction(title: "OK", style: .default) { action in
            if let textField = alert.textFields?[0] as UITextField?,
                let text = textField.text
            {
                
                let indexPath = IndexPath( row:self.data.count, section:0)
                let indexs = [indexPath]
                
                self.data.append(text)
                
                //self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexs, with:.automatic)

            }
        })
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel) )
        present(alert, animated: true, completion: nil)

    }
    
    func shouldAutorotateToInterfaceOrientation(interfaceOrientation:UIInterfaceOrientation) -> Bool
    {
        // Return YES for supported orientations
        return (interfaceOrientation == .portrait);
    }
    
    func setEditing(editing:Bool, animated:Bool) {
        
        if( !editing ) {
            
            let indexPath = IndexPath( row:data.count	, section:0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.detailTextLabel?.text = "";
            
        }
        
        super.setEditing(editing, animated:animated)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "ListDataEntryCell")
        
        if (cell == nil)   {
            cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "ListDataEntryCell")
        }
        
        cell!.accessoryType = .none
            
        let value = data[indexPath.row]
        
        cell!.detailTextLabel?.text = value
            
        return cell!
    }
    
     override func tableView(_  tableView: UITableView,
                                commit editingStyle: UITableViewCellEditingStyle,
                                forRowAt indexPath: IndexPath)
     {
        switch (editingStyle) {
            case .delete:
                let indexs = [indexPath]
                data.remove(at: indexPath.row)
                tableView.deleteRows(at: indexs, with:.automatic)
            break
            case .insert:
                print( "commitEditingStyle: UITableViewCellEditingStyleInsert")
                insertNewObject()
            break;
            case .none:
            break;
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        
        if( indexPath.row == data.count  ) {
            
            let indexPath = IndexPath( row:data.count, section:0)
            
            let cell = tableView.cellForRow(at: indexPath)
            
            cell?.detailTextLabel?.text =
                NSLocalizedString("ListDataEntryCell.addItemMessage", tableName: "add new item message", comment: "")
            
            return .insert;
        }
    
        return .delete;
    
    }

}

@objc class ListDataEntryCell : PushControllerDataEntryCell {
    
    @IBOutlet var listViewController:ListDataViewController?
    
    override func viewController(_ cellData:[AnyHashable : Any]) -> UIViewController? {
        return self.listViewController;
    }

}

