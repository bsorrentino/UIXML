//
//  ActionCellTableViewCell.swift
//  UIXMLSamples
//
//  Created by softphone on 13/06/2018.
//  Copyright © 2018 soulsoftware. All rights reserved.
//

import UIKit

@objc class ActionCell: BaseDataEntryCell {

    @IBOutlet weak var buttonAction: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareLabel(toAppear cellData: [AnyHashable : Any]) {
        
        let data = cellData as NSDictionary
        data.getStringForKey("Label", next: { (label) in
            
            self.buttonAction?.titleLabel?.text = label
            
        }) {
            
            
        }
        
    }
    /*
    override func prepareLabelToAppear:(NSDictionary*_Nonnull)cellData
    {
    [self processLabelConfig:cellData dataView:self.textField];
    }
    */
    @IBAction func onAction() {
        print( "on action")
    }
}
