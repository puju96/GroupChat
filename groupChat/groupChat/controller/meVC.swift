//
//  meVC.swift
//  groupChat
//
//  Created by Apple on 27/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase
class meVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
       
        let logoutPopup = UIAlertController(title: "LogOut", message: "You want to logout your account?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "LogOut", style: .destructive) { (btnTapped) in
            do{
                try Auth.auth().signOut()
            let authVc = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVc!, animated: true, completion: nil)

            }catch{
                print(error)
            self.dismiss(animated: true, completion: nil)
            }
            
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    
    }
}
