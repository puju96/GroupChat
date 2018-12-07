//
//  FirstViewController.swift
//  groupChat
//
//  Created by Apple on 22/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllMessages { (returnedmMessages) in
            self.messageArray = returnedmMessages.reversed()
            self.tableView.reloadData()
        }
    }


}

extension FeedVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return   messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? feedCell else{ return UITableViewCell() }
        let imagename = DataService.instance.getProfileImage()
       
        let profileImage = UIImage(named: imagename)
        DataService.instance.getUserName(forUID: messageArray[indexPath.row].senderId) { (returnedUserName) in
            cell.configurCell(profileImage: profileImage!, email: returnedUserName, content: self.messageArray[indexPath.row].content)
        }
        
        
        return cell
    }
    
    
}

