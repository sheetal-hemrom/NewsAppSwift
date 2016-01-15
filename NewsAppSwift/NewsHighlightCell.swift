//
//  NewsHighlightCell.swift
//  NewsAppSwift
//
//  Created by Hemrom, Sheetal on 11/17/15.
//  Copyright (c) 2015 Hemrom, Sheetal. All rights reserved.
//

import UIKit

class NewsHighlightCell: UITableViewCell {

    @IBOutlet weak var newsImage:UIImageView!;
    @IBOutlet weak var descriptionView:UILabel!;
    @IBOutlet weak var titleLabel:UILabel!;
    @IBOutlet weak var dateLabel:UILabel!;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
