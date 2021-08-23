//
//  Section1TableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit
protocol redirectToMainPageDelegate : class {
    func redirectToMainPage(indexpath: IndexPath)
}

class Section5TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, Section5CellDelegate {
    
    func didTapVerBtn(indexpath: IndexPath) {
        
        delegate?.redirectToMainPage(indexpath: indexpath)
        
    }
    

    static let identifier = "Section5TableViewCell"
    
    static func nib() -> UINib {
           return UINib(nibName: "Section5TableViewCell", bundle: nil)
       }

    @IBOutlet var collectionView : UICollectionView!
    var titleArray = Array<Any>()
    var indexPath :IndexPath = []
    var  delegate : redirectToMainPageDelegate?

  

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleArray = ["Normatividad Tributaria", "Normatividad Laboral", "Normatividad Sanitaria","Normatividad Ambiental", "Respons. Civil y Penal"]
       
        collectionView.register(Section5CollectionViewCell.nib(), forCellWithReuseIdentifier:Section5CollectionViewCell.identifier)
       
        collectionView.delegate =  self
        collectionView.dataSource =  self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //uicollectionview delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section5CollectionViewCell.identifier, for: indexPath) as! Section5CollectionViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.topLbl.text = (self.titleArray[indexPath.row] as! String)
        return cell
            
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) //.zero
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230 , height: 180)
    }
    
}
