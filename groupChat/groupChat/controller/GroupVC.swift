//
//  SecondViewController.swift
//  groupChat
//
//  Created by Apple on 22/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet weak var grptableView: UITableView!
    
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grptableView.delegate = self
        grptableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getallGroups { (returnedGroups) in
            self.groupArray = returnedGroups
            self.grptableView.reloadData()
        }
    
    }


}

extension GroupVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"groupCell" ) as? groupCell else {return UITableViewCell()}
        
        cell.configureCell(withTitle: groupArray[indexPath.row].GrpTitle, andwithDescription: groupArray[indexPath.row].GrpDesc , memberCount: groupArray[indexPath.row].GrpMemberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let grpFeedVc = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? groupFeedVC else {return}
        grpFeedVc.initData(forGroup: groupArray[indexPath.row])
        presentDetail(grpFeedVc)
    
    }
    
    
    
}

