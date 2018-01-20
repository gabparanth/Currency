//
//  CustomView.swift
//  Currency Today
//
//  Created by Gabriel Paranthoen on 19/01/2018.
//  Copyright © 2018 Gabriel Paranthoen. All rights reserved.
//

// import Foundation
import Cocoa

class CustomView : NSViewController {
    
    @IBOutlet var CustomLabel: NSTextField!
    
    var mainViewController: TodayViewController?
    let toto : String? = "toto"
    
    override func loadView() {
        super.loadView()
       // let f : NSRect = self.frame
        
        
        self.CustomLabel.stringValue = toto!
        print("testttttttttttt")
        print(CustomLabel.stringValue)
    
        
        
        
        
        
    }
    
    
}
