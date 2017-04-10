//
//  SwitchCell.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell:SwitchCell,
        didChangeValue value:Bool)
}

class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var SwitchCellView: UIView!
     weak var delegate:SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
      
        SwitchCellView.layer.borderColor = UIColor.init(red: CGFloat(204)/255, green: CGFloat(204)/255, blue: CGFloat(204)/255, alpha: 1).cgColor
        SwitchCellView.layer.borderWidth = 1
        
        
        
        onSwitch.addTarget( self, action:#selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     func switchValueChanged() {
        print("in the switchcell class now")
       //if delegate is not nil and implements switch cell then call the function.
            delegate?.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn  )
        
    }
}
 
