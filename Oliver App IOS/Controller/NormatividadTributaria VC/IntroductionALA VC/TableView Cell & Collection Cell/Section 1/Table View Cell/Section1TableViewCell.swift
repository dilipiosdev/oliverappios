//
//  Section1TableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Section1TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    static let identifier = "Section1TableViewCell"
    
    static func nib() -> UINib {
           return UINib(nibName: "Section1TableViewCell", bundle: nil)
       }

    @IBOutlet var collectionView : UICollectionView!
    var titleArray = Array<Any>()
     var especificationArray = Array<Any>()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleArray = ["Microempresa","Pequeña Empresa"]

          self.especificationArray = [" cuenta con más de un trabajador pero como máximo 10 trabajadores. Y proyecta unas ventas anuales hasta un máximo de 150 UIT (150 x 4400 = 660,000 soles anuales)"," cuenta con más de un trabajadora pero como máximo 100 trabajadores. Y proyecta unas ventas anuales hasta un máximo de 1700 UIT (1700 x 4400= 7´480,000 soles)"]
        collectionView.register(Section1CollectionViewCell.nib(), forCellWithReuseIdentifier:Section1CollectionViewCell.identifier)
        collectionView.delegate =  self
        collectionView.dataSource =  self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //uicollectionview delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
 
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section1CollectionViewCell.identifier, for: indexPath) as! Section1CollectionViewCell
        cell.titleLbl.text = (self.titleArray[indexPath.row] as! String)
        cell.specificationLbl.text = (self.especificationArray[indexPath.row] as! String)

           
        return cell
        
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) //.zero
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height: 400)
    }
    
}
