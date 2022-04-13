//
//  SimpleViewController.swift
//  Inno Wildlife
//
//  Created by Ahror Jabborov on 4/13/22.
//

import UIKit
import SDWebImage

class SimpleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fullName: UILabel!
}
class SimpleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var animalsSimpleCollectionView: UICollectionView!
    let apiServices = ApiServices()
    
    var animals = [Animal]() {
        didSet {
            DispatchQueue.main.async {
                self.animalsSimpleCollectionView.reloadData()
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshPage(_:)), for: .valueChanged)
        
        animalsSimpleCollectionView.alwaysBounceVertical = true
        animalsSimpleCollectionView.addSubview(refreshControl)
        
        updateList()
        animalsSimpleCollectionView.delegate = self
        animalsSimpleCollectionView.dataSource = self
        
        let layout = animalsSimpleCollectionView.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(
                width: UIScreen.main.bounds.width - 40,
                height: 72
            )
            flowLayout.minimumLineSpacing = 10
            flowLayout.sectionInset.top = 20
            flowLayout.sectionInset.right = 20
            flowLayout.sectionInset.left = 20
            flowLayout.sectionInset.bottom = 20
            
            animalsSimpleCollectionView.collectionViewLayout = flowLayout
        }
      
    }
    
    
    @objc func refreshPage(_ sender: UIRefreshControl) {
        updateList()
        sender.endRefreshing()
    }
    
    func updateList() {
        self.apiServices.getAnimals() {(result) in
            switch result {
            case.failure(let error):
                print(error)
            case .success(let data):
                self.animals = data
            }
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = animalsSimpleCollectionView.dequeueReusableCell(withReuseIdentifier: "simpleCell", for: indexPath) as! SimpleCollectionCell
        
        let animal = animals[indexPath.row]
        cell.title.text = animal.title
        cell.fullName.text = "\(animal.firstName ?? "") \(animal.lastName ?? "")"
        cell.image.sd_setImage(with: URL(string: animal.avatar ?? ""), placeholderImage: UIImage(named: "default"), options: SDWebImageOptions(rawValue: 0))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animal = animals[indexPath.row]
        let storyboard = UIStoryboard(name: "SimpleView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SimpleDetailViewController") as! SimpleDetailViewController
        vc.animal = animal
        vc.title = animal.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    


}
