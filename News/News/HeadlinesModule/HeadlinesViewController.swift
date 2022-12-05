//
//  HeadlinesViewController.swift
//  News
//
//  Created by Yuliya Lapenak on 11/14/22.
//

import UIKit

class HeadlinesViewController: UIViewController {
    var dataSource = [Articles]()
    let apiService = APIService()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Headlines"
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    func loadArticles() {
        guard let text = textField.text , text == "business" || text == "entertainment" || text == "general" || text == "health" || text == "science" || text == "sports" || text == "technology" else {return}
        apiService.loadHeadlines(category: text) { response in
            if let response = response {
                self.dataSource = response.articles
                self.tableView.reloadData()
            } else {
                print("Error")
            }
        }
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: Any) {
        loadArticles()
        
    }
}

extension HeadlinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setup(model: dataSource[indexPath.row])
        return cell
    }
}

extension HeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        guard  let destination = destination as? DetailsViewController else
        { return }
        let article = dataSource[indexPath.row]
        destination.article = article
        destination.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(destination, animated: true)
    }
}
