//
//  SimpleDetailViewController.swift
//  Inno Wildlife
//
//  Created by Ahror Jabborov on 4/13/22.
//

import UIKit
import SDWebImage

class SimpleDetailViewController: UIViewController {

    
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var animal = Animal()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        image.sd_setImage(with: URL(string: animal.avatar ?? ""), placeholderImage: UIImage(named: "default"), options: SDWebImageOptions(rawValue: 0))
        fullName.text = "\(animal.firstName ?? "") \(animal.lastName ?? "")"
        bio.text = animal.bio
    }
    


}
