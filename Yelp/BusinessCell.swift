//
//  BusinessCell.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var bizImage: UIImageView!
    @IBOutlet weak var bizRating: UIImageView!
    @IBOutlet weak var bizReviews: UILabel!
    @IBOutlet weak var bizCuisine: UILabel!
    @IBOutlet weak var bizAddress: UILabel!
    @IBOutlet weak var bizName: UILabel!
    
    @IBOutlet weak var bizDistance: UILabel!
    
    var business:Business!{
        didSet{
            bizName.text = business.name
            bizReviews.text="\(business.reviewCount)"
            bizImage.setImageWith(business.imageURL!)
             bizAddress.text=business.address
            bizReviews.text="\(business.reviewCount!) Reviews"
            bizRating.setImageWith(business.ratingImageURL! )
            bizDistance.text=business.distance
            bizCuisine.text=business.categories
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bizImage.layer.cornerRadius=8
        bizImage.clipsToBounds=true
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
