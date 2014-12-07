//
//  ViewController.swift
//  Budgeting-Demo
//
//  Created by Matthew Chess on 12/7/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func addTransaction(sender: AnyObject) {
        var alert = UIAlertController(title: "New name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        
        alert.addTextFieldWithConfigurationHandler { (textField0) in
            textField0.placeholder = "Location"
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField1) in
            textField1.placeholder = "Cost"
        }
        
        
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField0 = alert.textFields![0] as UITextField
                self.transactions.append(textField0.text)
                self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }

    
    var transactions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        cell.textLabel!.text = transactions[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

