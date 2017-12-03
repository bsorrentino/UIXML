//
//  RowSpanCell.swift
//  UIXMLSamples
//
//  Created by softphone on 23/11/2017.
//  Copyright © 2017 soulsoftware. All rights reserved.
//

import Foundation
import UIKit

@objc class RowSpanViewController : UIXMLFormViewControllerEx {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        load(fromFile: "RowSpanForm.plist")
    
        tableView.backgroundColor = UIColor.clear
    
    }
}


class RowSpanDataEntryCell : BaseDataEntryCell {

    @IBOutlet var form:RowSpanViewController?;

}
