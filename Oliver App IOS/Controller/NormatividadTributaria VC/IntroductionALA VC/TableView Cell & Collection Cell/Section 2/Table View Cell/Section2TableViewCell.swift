//
//  Section1TableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Section2TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    static let identifier = "Section2TableViewCell"
    
    static func nib() -> UINib {
           return UINib(nibName: "Section2TableViewCell", bundle: nil)
       }

    @IBOutlet var collectionView : UICollectionView!
    var titleArray = Array<Any>()
     var denominationArray = Array<Any>()
    var numeroDeArray = Array<Any>()
    var organisationArray = Array<Any>()
    var capitalArray = Array<Any>()




    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleArray = ["","E.I.R.L.","S.R.L.", "S.A.C.","S.A.A.","S.A."]
        self.denominationArray = ["","Empresario Individual de Responsabilidad Limitada.","Sociedad Comercial de Responsabilidad Limitada.", "Sociedad Anónima Cerrada.","Sociedad Anónima Abierta.","Sociedad Anónima"]
        self.numeroDeArray = ["","Máximo 1","Mínimo 2 ; Máximo: 20", "Mínimo 2 ; Máximo: 20","Mínimo 750 ","Mínimo 2 ; Máximo: ilimitado"]
        self.organisationArray = ["","Una sóla persona figura como Gerente General y Socio","Empresas familiares pequeñas", "Junta General de Accionistas, Gerencia, Directorio (opcional)","Junta General de Accionistas, Gerencia, Directorio","Junta General de Accionistas, Gerencia, Directorio"]
        self.capitalArray = ["","Capital definido por aportes del único aportante.","Aporrtes de cada socio. Se deben inscribir en Registros Públicos.", "Aportes de cada socio. Se deben registrar las acciones en el Registro de Matrícula de Acciones.","Más del 35% del capital pertenece a 175 o más accionistas. Debe haber hecho una oferta pública primaria de acciones u obligaciones convertibles en acciones. Deben registrar las acciones en el Registro de Matrícula de Acciones.","Aportes de cada socio. Se deben registrar las acciones en el Registro de Matrícula de Acciones."]

        
        collectionView.register(Section2CollectionViewCell.nib(), forCellWithReuseIdentifier:Section2CollectionViewCell.identifier)
        collectionView.register(Index0CollectionViewCell.nib(), forCellWithReuseIdentifier:Index0CollectionViewCell.identifier)
        collectionView.delegate =  self
        collectionView.dataSource =  self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //uicollectionview delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
 
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Index0CollectionViewCell.identifier, for: indexPath) as! Index0CollectionViewCell
            return cell
            
        } else {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section2CollectionViewCell.identifier, for: indexPath) as! Section2CollectionViewCell
        cell.topLbl.text = (self.titleArray[indexPath.row] as! String)
        cell.denominacionLbl.text = (self.denominationArray[indexPath.row] as! String)
        cell.numeroLbl.text = (self.numeroDeArray[indexPath.row] as! String)
        cell.organisationLbl.text = (self.organisationArray[indexPath.row] as! String)
        cell.capitalLbl.text = (self.capitalArray[indexPath.row] as! String)
        return cell
            
        }
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) //.zero
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height: 550)
    }
    
}
