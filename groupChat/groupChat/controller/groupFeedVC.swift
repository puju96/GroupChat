//
//  groupFeedVC.swift
//  groupChat
//
//  Created by Apple on 28/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase
class groupFeedVC: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var msgText: insetTextField!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var members: UILabel!
    @IBOutlet weak var grpTitle: UILabel!
    
    var group : Group?
    var gropuMsgArray = [Message]()
    func initData(forGroup group: Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      sendBtnView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        grpTitle.text = group?.GrpTitle
        DataService.instance.getEmailfor(group: group!) { (returnedEmails) in
            self.members.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.ref_groups.observe(.value) { (snapshot) in
            DataService.instance.getMsgOfDesiredGroup(desiredGrp: self.group!, handler: { (returnedGrpMsgs) in
                self.gropuMsgArray = returnedGrpMsgs
                self.tableView.reloadData()
                
                if self.gropuMsgArray.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.gropuMsgArray.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
       
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
       dismissDetail()
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        
        if msgText.text != "" {
            msgText.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: msgText.text!, forUID: (Auth.auth().currentUser?.uid)!, forGropuKey: group?.Grpkey) { (complete) in
                if complete {
                    self.msgText.text = ""
                    self.msgText.isEnabled = true
                    self.sendBtn.isEnabled = true
                    
                    
                }
            }
           }
        }
    

}

extension groupFeedVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gropuMsgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? groupFeedCell else {return UITableViewCell()}
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUserName(forUID: gropuMsgArray[indexPath.row].senderId) { (email) in
            cell.configureCell(profileImg: image!, email: email, message: self.gropuMsgArray[indexPath.row].content)
        }
        return cell
    }
    
    
}
