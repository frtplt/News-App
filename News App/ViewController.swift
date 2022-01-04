//
//  ViewController.swift
//  News App
//
//  Created by Firat on 2.01.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var newsTable: UITableView!
    
    var news = [Article]()
    
    var result: Response?
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        newsTable.dataSource = self
        newsTable.delegate = self
        title = "News"
        getData(completion: {result in
            switch result{
            case.success(let response):
                break
            case.failure(let error):
                print(error)
            }
        })
    }
    
    func getData(completion: @escaping(Result<[String],Error>) -> Void){
        
        news.removeAll()
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!,
                                              completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            // Convert
            
            do {
                self.result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                self.performSegue(withIdentifier: "toEntry", sender: self)
            }
            
            guard let finalResult = self.result else {
                return
            }
            
            
            let newNews = finalResult.articles
            self.news.append(contentsOf: newNews)
            
            
            // Refresh our table
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
            
        })
        task.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: news[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = news[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    
}
struct Response: Codable {
    let articles: [Article]
    
}

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    
    
}









