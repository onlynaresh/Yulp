//
//  Deal.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealDelegate {
    @objc optional func dealSwitchCell(dealSwitchCell: Deal, didChangeValue:Bool)
}

class Deal: UITableViewCell {
    
    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var dealLabelSwitchView: UIView!
    @IBOutlet weak var dealSwitch: UISwitch!

    
    weak var dealDelegate:DealDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        dealLabelSwitchView.layer.borderColor = UIColor.init(red: CGFloat(204)/255, green: CGFloat(204)/255, blue: CGFloat(204)/255, alpha: 1).cgColor
        dealLabelSwitchView.layer.borderWidth = 1
        
        dealSwitch.addTarget(self, action: #selector(Deal.dealValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func dealValueChanged() {
        dealDelegate?.dealSwitchCell?(dealSwitchCell: self, didChangeValue: dealSwitch.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
