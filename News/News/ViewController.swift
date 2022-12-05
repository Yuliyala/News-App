//
//  ViewController.swift
//  News
//
//  Created by Yuliya Lapenak on 11/9/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var dataSource = [Articles]()
    var apiService = APIService()
    
//    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Everything"
    }
    
    func loadArticles(){
        guard let text = searchController.searchBar.text, text.count > 0 else { return }
        apiService.loadArticles(topic: text) { response in
            if let response = response {
                self.dataSource = response.articles
                self.tableView.reloadData()
            } else {
                print("Error")
            }
        }
    }
    
//    @IBAction func textFieldDidEndOnExit(_ sender: Any) {
//        loadArticles()
//    }
//
//    @IBAction func textFieldEditingChanged(_ sender: Any) {
//        loadArticles()
//    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
     
    func setupSearchController() {
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
//        definesPresentationContext = true
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        guard let destination = destination as? DetailsViewController else
        { return }
        let article = dataSource[indexPath.row]
        destination.article = article
        destination.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(destination, animated: true)
    }
}


extension ViewController: UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
       loadArticles()
    }

    // Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
  loadArticles()
   
}
}
