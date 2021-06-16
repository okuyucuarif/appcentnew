//
//  NewsViewController.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import UIKit
import MBProgressHUD
import Alamofire


class NewsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var model: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View delegation
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Search Bar Delegation
        self.searchBar.delegate = self
        
        //model
        model = NewsViewModel(delegate: self)
        
        
        
        let cellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
                            "NewsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getRequestAPICall(with searchText: String)  {
        showLoadingHUD()
        model.getRequestAPICall(searchCriteria: searchText, page: 1)
    }
    
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func openDetailVC(article: Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as! NewsDetailViewController
        vc.article = article
        vc.isFavorite = isFavoriteCheck(article: article)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isFavoriteCheck(article: Article) -> Bool{
        return FavoritesModel.shared.articles.contains(article)
    }

}
//MARK:- Search View Delegate
extension NewsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{ return }
        
        getRequestAPICall(with: text)
    }
    
    
}
// MARK:- Table View Delegate
extension NewsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailVC(article: model.newsFeed!.articles![indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 223
    }
    
}
//MARK:- Table View Data Source
extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.newsFeed?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewsCell"
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier) as! NewsTableViewCell
        let article = model.newsFeed!.articles![indexPath.row]
        
        
        cell.configureCell(with: article)
        
        return cell
    }
    
    
}

extension NewsViewController: NewsServiceResponse{
    func serviceResponseSucces() {
        tableView.reloadData()
        hideLoadingHUD()
    }
    
    func serviceResponseFailure() {
        hideLoadingHUD()
        let alert = UIAlertController(
            title: "HATA",
            message: "İşleminizi şuanda gerçekleştiremiyoruz.Lütfen daha sonra tekrar deneyiniz",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
