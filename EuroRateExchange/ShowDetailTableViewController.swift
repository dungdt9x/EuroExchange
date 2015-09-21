//
//  ShowDetailTableViewController.swift
//  EuroRateExchange
//
//  Created by Steven Pham on 9/21/15.
//  Copyright (c) 2015 dungdtiosdeveloper. All rights reserved.
//

import UIKit

class ShowDetailTableViewController: UITableViewController {
    
    var Today: Bool!
    var myDictionresut: NSMutableArray!
    var myDictionResult90: NSArray!
    var labelTitle: String!
    
    @IBOutlet var demo: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.demo.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //set image for button
        button.setImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        //add function for button
        button.addTarget(self, action: "fbButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        button.frame = CGRectMake(0, 0, 22, 22)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem=barButton
        
        
        if (self.Today == true){
            self.callServicesToday()
            self.title="Today"
        }
        else {
            self.callServies90Days()
            self.title = "Last 90 Days"
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if (self.Today == true) {
            return 1
        } else {
            if (self.myDictionResult90 != nil) {
                return myDictionResult90.count
            } else {
                return 1;
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (self.Today == true) {
            if (self.myDictionresut != nil) {
                return self.myDictionresut.count
            } else {
                return 0;
            }
        } else {
            if (self.myDictionResult90 != nil) {
                let dic = self.myDictionResult90.objectAtIndex(section) as! NSDictionary
                let dic1 = dic.objectForKey("Rates")?.count;
                return dic1!
            } else {
                return 0;
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell! = tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell") as! CustomTableViewCell
        if (self.Today == true) {
            let dic = self.myDictionresut.objectAtIndex(indexPath.row) as! NSDictionary
            cell.lbl_ID.text = dic.objectForKey("Id") as? String
            cell.lbl_Rate.text = NSString(format: "%f", dic.objectForKey("Rate") as! Double) as String
        }
        else {
            let dic = self.myDictionResult90.objectAtIndex(indexPath.section) as! NSDictionary
            let dic1: AnyObject? = dic.objectForKey("Rates")?.objectAtIndex(indexPath.row)
            cell.lbl_ID.text = dic1!.objectForKey("Id") as? String
            cell.lbl_Rate.text = NSString(format: "%f", dic1!.objectForKey("Rate") as! Double) as String
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (self.myDictionResult90 != nil) {
            let dic = self.myDictionResult90.objectAtIndex(section) as! NSDictionary
            var dic1 : String = (dic.objectForKey("Day") as? String)!;
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateFind = dateFormatter.dateFromString(dic1)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let stringFind = dateFormatter.stringFromDate(dateFind!)
            
            return stringFind
        } else {
            
            if (self.labelTitle != nil){
                return self.labelTitle
            }
            else{
                return nil;
            }
        }
        
    }
    
    
    //MARK: - BackButton Pressed
    func fbButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //MARK: - Call Services
    
    func callServicesToday(){
        
        SVProgressHUD.show()
        MyRestAPIClient.sharedAPIClient().getRequestWithURL(URL_BASE_1 as String, param: nil) { (respone, error) -> Void in
            SVProgressHUD.dismiss()
            if error == nil {
                //self.myDictionresut  = respone as! NSMutableArray
                let dic: NSDictionary! = respone as! NSDictionary
                self.myDictionresut = dic.objectForKey("Rates") as! NSMutableArray
                self.labelTitle = dic.objectForKey("Day") as? String
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let dateFind = dateFormatter.dateFromString(self.labelTitle)
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let stringFind = dateFormatter.stringFromDate(dateFind!)
                
                self.labelTitle=stringFind
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
    
    func callServies90Days(){
        SVProgressHUD.show()
        MyRestAPIClient.sharedAPIClient().getRequestWithURL(URL_BASE_2 as String, param: nil) { (respone, error) -> Void in
            SVProgressHUD.dismiss()
            if error == nil {
                self.myDictionResult90 = respone as! NSArray
                self.tableView.reloadData()
            }
            
        }
    }
}
