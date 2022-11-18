//
//  NewsTableViewCell.swift
//  News
//
//  Created by Yuliya Lapenak on 11/13/22.
//

import UIKit
import Alamofire

class NewsTableViewCell: UITableViewCell {
    
    static let identifier: String = "NewsCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(model: Articles) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
