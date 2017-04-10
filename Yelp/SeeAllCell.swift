//
//  SeeAllCell.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class SeeAllCell: UITableViewCell {
    
        
    @IBOutlet weak var seeAllLabelView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        seeAllLabelView.layer.borderColor = UIColor.init(red: CGFloat(204)/255, green: CGFloat(204)/255, blue: CGFloat(204)/255, alpha: 1).cgColor
        seeAllLabelView.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
