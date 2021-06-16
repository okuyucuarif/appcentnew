//
//  FavoritesViewController.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View delegation
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let cellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
                            "FavoriteCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        tableView.reloadData()
    }
    
    func openDetailVC(article: Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as! NewsDetailViewController
        vc.article = article
        vc.isFavorite = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK:- Table View Delegate
extension FavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailVC(article: FavoritesModel.shared.articles[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 223
    }
    
}
//MARK:- Table View Data Source
extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesModel.shared.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FavoriteCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier) as! NewsTableViewCell
        
        let article = FavoritesModel.shared.articles[indexPath.row]
        cell.configureCell(with: article)
        
        return cell
    }
}
