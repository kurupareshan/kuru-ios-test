//
//  DetailsViewController.swift
//  KuruTest
//
//  Created by Kuru on 2024-04-30.
//

import UIKit

class DetailsViewController: UIViewController {

    var dataCount = Int()
    
    var viewModel: DetailsViewModel?
    
    // MARK: Properties
    public class var storyboardName: String {
        return "Main"
    }
    
    static func create(viewModel: DetailsViewModel) -> DetailsViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as? DetailsViewController
        viewController!.viewModel = viewModel
        return viewController!
    }
    @IBOutlet var customCollectionView: UICollectionView!
    let cellIdentifier = "CustomCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
       // customCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // Set up your custom layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        customCollectionView.collectionViewLayout = layout
        customCollectionView.dataSource = self
        customCollectionView.delegate = self
        
        

    }

}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.viewModel!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = customCollectionView.frame.width / 2
        let height = customCollectionView.frame.height / 2
        return CGSize(width: width - 20, height: height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}


