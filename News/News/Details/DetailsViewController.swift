//
//  DetailsViewController.swift
//  News
//
//  Created by Yuliya Lapenak on 11/29/22.
//

import UIKit
import SafariServices
import Kingfisher


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var linkButton: UIButton!
    
    var article: Articles!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setup()

    }

    
    func setup() {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.fullAuthor
        dateLabel.text =  article.publishedAt.toDate()?.toString()
        
        let url = URL(string: article.urlToImage ?? "")
        imageView.kf.setImage(with: url)
    }

    func setupViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        authorLabel.textAlignment = .right
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        dateLabel.textAlignment = .left
        
        imageView.contentMode = .scaleAspectFit
        
        linkButton.setTitle("See more", for: .normal)
        
    }
    
    @IBAction func linkButtonPress(_ sender: Any) {
        openURL()
    }
    
    func openURL() {
        if let url = URL(string: article.url) {
//            UIApplication.shared.open(url)
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true)
        }
    }
  
}


