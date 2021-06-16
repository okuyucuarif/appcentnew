//
//  NewsDetailViewController.swift
//  AppCentNew
//
//  Created by ArifOk on 15.06.2021.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsDetailTextView: UITextView!
    @IBOutlet weak var newsDataSource: UIButton!
    
    var article: Article!
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        
        configureNavigationBarItem()
        
        borderDataSourceButton()
        if let imageUrl = article.urlToImage {
            imageView.downloadImage(with: imageUrl)
        }
        titleLabel.text = article.title
        authorNameLabel.text = article.author ?? "Unkown"
        dateLabel.text = String(article.publishedAt?.split(separator: "T")[0] ?? "") 
        newsDetailTextView.text = article.content ?? "There is no description for this news.You can click News Source then redirect to the News Source"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureNavigationBarItem(){
        let shareImage    = UIImage(systemName: "square.and.arrow.up")!
        
        var imageName = "heart"
        if isFavorite {
            imageName = "heart.fill"
        }
        let favImage  = UIImage(systemName: imageName)!
        
        let shareButton   = UIBarButtonItem(image: shareImage,  style: .plain, target: self, action: #selector(didTapShareButton(sender:)))
        let favButton = UIBarButtonItem(image: favImage,  style: .plain, target: self, action: #selector(didTapFavButton(sender:)))
        
        navigationItem.rightBarButtonItems = [favButton, shareButton]
    }
    
    @objc func didTapShareButton(sender: AnyObject){
        guard let url = URL(string: article.url ?? "")  else {
            dataSourceUrlError()
            return
        }
        let sharedObjects:[AnyObject] = [url as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = []
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func didTapFavButton(sender: AnyObject){
        let favButton = sender as! UIBarButtonItem
        if isFavorite {
            favButton.image = UIImage(systemName: "heart")
            FavoritesModel.shared.articles.remove(at: FavoritesModel.shared.articles.firstIndex(of: article)!)
        }else{
            favButton.image = UIImage(systemName: "heart.fill")
            FavoritesModel.shared.articles.append(article)
        }
    }
    
    func borderDataSourceButton() {
        newsDataSource.backgroundColor = .clear
        newsDataSource.layer.cornerRadius = 5
        newsDataSource.layer.borderWidth = 1
        newsDataSource.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func openDataSource(_ sender: Any) {
        
        guard let url = URL(string: article.url ?? "")  else {
            dataSourceUrlError()
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dataSourceVC") as! DataSourceViewController
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dataSourceUrlError() {
        let alert = UIAlertController(
            title: "Haber Kaynağı Bulunamadı!",
            message: "İlgili haberin kaynağına şuanda ulaşılamıyor lütfen daha sonra deneyiniz.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
