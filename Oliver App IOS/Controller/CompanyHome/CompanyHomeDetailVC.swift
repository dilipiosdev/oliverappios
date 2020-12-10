//
//  CompanyHomeDetailVC.swift
//  Oliver App IOS
//
//  Created by Meena on 05/12/20.
//

import UIKit

class CompanyHomeDetailVC: UIViewController {

    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var tblView: UITableView!{
        didSet{
            tblView.register(UINib(nibName: "CompantDatilTVC", bundle: nil), forCellReuseIdentifier: "CompantDatilTVC")
        }
    }
    @IBOutlet var collView: UICollectionView!{
        didSet{
            collView.register(UINib(nibName: "ComapnyDetailCVC", bundle: nil), forCellWithReuseIdentifier: "ComapnyDetailCVC")
            setupCVLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
    }
    
    //MARK:-
    func setupCVLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collView.collectionViewLayout = layout
    }
    
    @IBAction func tabClicked(_ sender: UIButton) {
        if sender.tag == 1{
            view1.isHidden = false
            view2.isHidden = true
            view3.isHidden = true
            
        }else if sender.tag == 2{
            view1.isHidden = true
            view2.isHidden = false
            view3.isHidden = true
            
        }else if sender.tag == 3{
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = false
            
        }
    }
}

//MARK:- CollectionView Methods
extension CompanyHomeDetailVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComapnyDetailCVC", for: indexPath) as! ComapnyDetailCVC

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK:- TableView Methods
extension CompanyHomeDetailVC : UITableViewDataSource, UITableViewDelegate{
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompantDatilTVC", for: indexPath) as! CompantDatilTVC

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
