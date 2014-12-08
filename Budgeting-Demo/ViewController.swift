//
//  ViewController.swift
//  Budgeting-Demo
//
//  Created by Matthew Chess on 12/7/14.
//  Copyright (c) 2014 matthewchess. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func addTransaction(sender: AnyObject) {
        var alert = UIAlertController(title: "New name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        
        alert.addTextFieldWithConfigurationHandler { (textField0) in
            textField0.placeholder = "Location"
        }
        
//        alert.addTextFieldWithConfigurationHandler { (textField1) in
//            textField1.placeholder = "Cost"
//        }
        
        
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField0 = alert.textFields![0] as UITextField
      //          let textField1 = alert.textFields![1] as UITextField
                self.saveLocation(textField0.text)
  //              self.saveCost(textField1.text)
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

    
    var transactions = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Transaction")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            transactions = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        let transaction = transactions[indexPath.row]
        
        cell.textLabel!.text = transaction.valueForKey("location") as String?
        
        return cell
    }
    
    func saveLocation(location: String){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entry = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: managedContext)
        
        let transaction = NSManagedObject(entity: entry!, insertIntoManagedObjectContext: managedContext)
        
        transaction.setValue(location, forKey: "location")
        
        var error: NSError?
        if !managedContext.save(&error){
            println("Could not save")
        }
        
        transactions.append(transaction)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

