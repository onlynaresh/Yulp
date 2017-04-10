//
//  Distance.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceDelegate {
    @objc optional func distanceSwitchCell(distanceSwitchCell: Distance, didChangeValue:Bool)
}

class Distance: UITableViewCell {
    

    @IBOutlet weak var distanceLabel: UILabel!
     weak var distanceDelegate:DistanceDelegate?
    @IBOutlet weak var distanceLabelSwitchView: UIView!
    @IBOutlet weak var distanceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        distanceLabelSwitchView.layer.borderColor = UIColor.init(red: CGFloat(204)/255, green: CGFloat(204)/255, blue: CGFloat(204)/255, alpha: 1).cgColor
        distanceLabelSwitchView.layer.borderWidth = 0.8
        
        let notDoneImage = UIImage(named: "oval")
        distanceButton.setImage(notDoneImage, for: UIControlState.normal)
        distanceButton.addTarget(self, action: #selector(Distance.distanceValueChanged), for: UIControlEvents.touchUpInside)
        
     
    }
    
    func distanceValueChanged() {
        let doneImage = UIImage(named: "done")
        let notDoneImage = UIImage(named: "oval")
        var isSelected = false
        if(distanceButton.currentImage == notDoneImage){
            distanceButton.setImage(doneImage, for: UIControlState.normal)
            distanceButton.tintColor = UIColor.init(red: CGFloat(0)/255, green: CGFloat(151)/255, blue: (236)/255, alpha: 1)//blue
            isSelected = true
        }
        else {
            distanceButton.setImage(notDoneImage, for: UIControlState.normal)
            distanceButton.tintColor = UIColor.init(red: CGFloat(102)/255, green: CGFloat(102)/255, blue: (102)/255, alpha: 1)//gray
            isSelected = false
        }
       
        distanceDelegate?.distanceSwitchCell?(distanceSwitchCell: self, didChangeValue: isSelected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
