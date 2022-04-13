//
//  ViewController.swift
//  Inno Wildlife
//
//  Created by Ahror Jabborov on 4/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "tabBarViewController")
    }


}

