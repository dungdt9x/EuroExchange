//
//  ViewController.swift
//  EuroRateExchange
//
//  Created by Do Trung Dung on 9/21/15.
//  Copyright (c) 2015 dungdtiosdeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:
    @IBOutlet weak var btnShowTodayEx: UIButton!
    @IBOutlet weak var btnShow90DaysEx: UIButton!
    var testArray: NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareForView()
               
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action Show
    @IBAction func showTodayExchange(sender: AnyObject) {
        let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("ShowDetail") as! ShowDetailTableViewController
        view2.Today=true
        self.navigationController?.pushViewController(view2, animated: true)

    }
    
    @IBAction func showLast90DaysExchange(sender: AnyObject) {
        let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("ShowDetail") as! ShowDetailTableViewController
        view2.Today=false
        self.navigationController?.pushViewController(view2, animated: true)
    }
    //MARK: - prepareForView
    func prepareForView(){
        self.view.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.btnShowTodayEx.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.btnShow90DaysEx.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.btnShowTodayEx.layer.cornerRadius=10
        self.btnShow90DaysEx.layer.cornerRadius=10
    }
    
    
}

