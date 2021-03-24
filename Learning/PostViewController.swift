//
//  PostViewController.swift
//  Learning
//
//  Created by Banu on 24/03/21.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var idLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var postLable: UILabel!
}

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let postCellId = "PostCellId"
    var posts: [[String: Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts")!) { (data, response, error) in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                self.posts = jsonObject
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }            
        }.resume()
    }
    

}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: postCellId, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        if let post = posts?[indexPath.row] {
            let userId = post["userId"] as! Int
            postCell.idLable.text = String(userId)
            postCell.titleLable.text = post["title"] as? String
            postCell.postLable.text = post["body"] as? String

        } else {
            postCell.idLable.text = nil
            postCell.titleLable.text = nil
            postCell.postLable.text = nil
        }
        
        return postCell
    }
    
    
}
