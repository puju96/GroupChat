//
//  meVC.swift
//  groupChat
//
//  Created by Apple on 27/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class meVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    var msgArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.profileImg.image = UIImage(named: DataService.instance.getProfileImage())
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailLbl.text = Auth.auth().currentUser?.email
        
        DataService.instance.getAllMsgsOfCurrentUser(senderId: (Auth.auth().currentUser?.uid)!) { (returnedMsgs) in
            self.msgArray = returnedMsgs.reversed()
            self.tableView.reloadData()
        }
    }
    
    
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
       
        let logoutPopup = UIAlertController(title: "LogOut", message: "You want to logout your account?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "LogOut", style: .destructive) { (btnTapped) in
            do{
                GIDSignIn.sharedInstance()?.signOut()
                try Auth.auth().signOut()
            let authVc = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVc!, animated: true, completion: nil)

            } catch {
                print(error)
            self.dismiss(animated: true, completion: nil)
            }
            
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    
    }
}

extension meVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "meCell", for: indexPath) as? meCell else { return UITableViewCell()}
        DataService.instance.getUserName(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUsername) in
            
            cell.configureCell(message: self.msgArray[indexPath.row].content)
        }
        
        return cell
       
    }
    
    
}
