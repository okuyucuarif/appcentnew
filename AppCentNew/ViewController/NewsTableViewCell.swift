//
//  NewsTableViewCell.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with article: Article){
        titleLabel.text = article.title
        descriptionTextView.text = article.description!
        if let imageUrl = article.urlToImage {
            newsImageView.downloadImage(with: imageUrl)
        }
    }
    
}
