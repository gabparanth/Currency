//
//  TodayViewController.swift
//  Currency Today
//
//  Created by Gabriel Paranthoen on 16/01/2018.
//  Copyright © 2018 Gabriel Paranthoen. All rights reserved.
//

import Cocoa
import NotificationCenter
import Foundation

class TodayViewController: NSViewController, NCWidgetProviding, NCWidgetListViewDelegate{


    @IBOutlet var listViewController: NCWidgetListViewController!
    

    var customView : CustomView?
    
    
    var myCoin: [Coin] = []
    let queryService = QueryService()
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }

    override func viewDidLoad() {
        
          super.viewDidLoad()
        print ("I'm in viewDidLoad")
        // Customize widget area style options
        listViewController.delegate = self
        listViewController.hasDividerLines = true
        listViewController.showsAddButtonWhenEditing = false
        
       
        listViewController.minimumVisibleRowCount = 3

    
        queryService.getSearchResults() { results, errorMessage in
            if let results = results {
                self.myCoin = results
                self.listViewController.contents = self.myCoin
          
                print ("request on load ok")
            }
            if !errorMessage.isEmpty {
                print("Search error: " + errorMessage)

            }



    }
    
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.noData)
    }
    
    let MenuItemID: String = "LISTMENU"
    let stringName : String? = " -- "

    func widgetList(_ list: NCWidgetListViewController, viewControllerForRow row: Int) -> NSViewController {
       
        
        /*
         var menuItemViewC: MenuItemViewController = MenuItemViewController()
         self.menuItemViewController = menuItemViewC
         menuItemViewC.mainViewController = self
         */
    
            print("I'm in func widgetList")
    
        
            let customV: CustomView = CustomView()
            self.customView = customV
            customV.mainViewController = self
            return customV


    }
    
    
    
    /*
     var searchResults: [Coin] = []
     let queryService = QueryService()
     queryService.getSearchResults() { results, errorMessage in
     if let results = results {
     self.searchResults = results
     //print (results)
     self.labelJson.stringValue = results[0].name
     //                 print (self.searchResults)
     //                self.tableView.reloadData()
     //                self.tableView.setContentOffset(CGPoint.zero, animated: false)
     }
     if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
     }*/
    
    

}


