//
//  Form.swift
//  UIXMLSamples
//
//  Created by softphone on 21/11/2017.
//  Copyright © 2017 soulsoftware. All rights reserved.
//

import Foundation

class FormData : NSObject, NSCoding {
    
    var model:Dictionary<String, Any>;
    
    override init() {
        model = Dictionary()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(model, forKey: "model")
    }
    
    required init?(coder aDecoder: NSCoder) {
        model = aDecoder.decodeObject(forKey: "model") as! Dictionary<String, Any>
    }
    

}


class FormViewController : UIXMLFormViewController {
    
    var data:FormData = FormData();
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.load(fromFile:"form-structure.plist")
    
        self.title = "FORM"

        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
    
    
        let birthDay = fmt.date( from:"1997-10-03" )
    
        data.model["birthDay"] = birthDay
        data.model["gender"] = "M"
        data.model["enabled"] =  false
        data.model["firstName"] =  "Simone"
        data.model["lastName"] = "Sorrentino"
        data.model["list"] = "list"
        data.model["url"] = "about:blank"
    
    }

    // MARK: - UIXMLFormViewControllerDelegate
    
    func cellControlDidEndEditing( cell:BaseDataEntryCell ) {
        
        print( "FormViewController value \(cell.getControlValue()) for key \(cell.dataKey)")
    
    }
    
    func cellControlDidInit(cell:BaseDataEntryCell, cellData:Dictionary<String,Any>) {
    
        if let value = data.model[cell.dataKey as String] {
            print("FormViewController Init cell for key \(cell.dataKey) value \(value)");

            cell.setControlValue(value)
        }
    }

    
    
}

