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
    var apiServise = APIService()
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Everything"
    }
    
    func loadArticles(){
        guard let text = searchTextField.text, text.count > 0 else { return }
        apiServise.loadArticles(topic: text) { response in
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
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
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
    
}
