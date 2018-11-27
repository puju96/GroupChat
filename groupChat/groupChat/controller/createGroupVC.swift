//
//  createGroupVC.swift
//  groupChat
//
//  Created by Apple on 27/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase
class createGroupVC: UIViewController {

    @IBOutlet weak var descTxt: insetTextField!
    @IBOutlet weak var titleTxt: insetTextField!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMembers: UILabel!
    @IBOutlet weak var memberEmailTxt: insetTextField!
    
    var emailArray = [String]()
    var membersArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        memberEmailTxt.delegate = self
        memberEmailTxt.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldChanged (){
        if memberEmailTxt.text != "" && memberEmailTxt.text != Auth.auth().currentUser?.email {
            DataService.instance.getEmails(forSearchQuery: memberEmailTxt.text!) { (returnedEmails) in
                self.emailArray = returnedEmails
                self.tableView.reloadData()
            }
            
        }else{
            emailArray = []
            tableView.reloadData()
        }
        
        
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
    }
    
}

extension createGroupVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? userCell else {
            return UITableViewCell()
        }
        let profileimage = UIImage(named: "defaultProfileImage")
        cell.configureCell(ProfileImg: profileimage!, email: emailArray[indexPath.row], isSelected: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? userCell else { return }
        if !membersArray.contains(cell.emailLbl.text!) {
            membersArray.append(cell.emailLbl.text!)
            groupMembers.text = membersArray.joined(separator: ",")
            doneBtn.isHidden = false
        }else{
            membersArray = membersArray.filter({ $0 != cell.emailLbl.text!})
            if membersArray.count >= 1 {
                groupMembers.text = membersArray.joined(separator: ",")
            }else{
                groupMembers.text = "Add group members"
                doneBtn.isHidden = true
            }
        }
    }
    
    
}

extension createGroupVC : UITextFieldDelegate{
    
}
