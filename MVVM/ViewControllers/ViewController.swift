//
//  ViewController.swift
//  MVVM
//
//  Created by Darshan on 04/03/22.
//

import UIKit
let kIsUserLoggedIn = "isUserLogIn"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func buttonLoginSelector(sender:UIButton){
        UserDefaults.standard.set(true, forKey: kIsUserLoggedIn)
        UserDefaults.standard.synchronize()
        if let homeViewController  = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
            homeViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }

}

