//
//  ViewController.swift
//  KuruTest
//
//  Created by Kuru on 2024-04-30.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var dataTableView: UITableView!
    @IBOutlet var passButton: UIButton!
    let cellIdentifier = "CustomCollectionViewCell"
    
    var viewModel: DataViewModel?
    
    // MARK: Properties
    public class var storyboardName: String {
        return "Main"
    }
    
    static func create(viewModel: DataViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        viewController!.viewModel = viewModel
        return viewController!
    }
    
    
    @IBOutlet var customCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
       
        dataTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        fetchData()
        // Set up your custom layout
        customCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        customCollectionView.collectionViewLayout = layout
        customCollectionView.dataSource = self
        customCollectionView.delegate = self
    }
    
    func fetchData() {
//        viewModel.fetchItems { error in
//            if let error = error {
//                print("Error fetching items:", error)
//            } else {
//                DispatchQueue.main.async {
//                    self.dataTableView.reloadData()
//                }
//            }
//        }
        viewModel?.getData { status, message in
            if (status) {
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func passButtonTapped(_ sender: Any) {
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //
        //        // Instantiate view controller from storyboard
        //        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        //        viewController.modalPresentationStyle = .fullScreen
        //        // Present the view controller
        //        present(viewController, animated: true, completion: nil)
        let vc = DetailsViewController.create(viewModel: DetailsViewModel(count: self.viewModel!.newsModel.count))
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .red
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.viewModel.items.count
        return self.viewModel!.newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        cell.textLabel?.text = "Kuru"
        return cell
    }
    
    
}
