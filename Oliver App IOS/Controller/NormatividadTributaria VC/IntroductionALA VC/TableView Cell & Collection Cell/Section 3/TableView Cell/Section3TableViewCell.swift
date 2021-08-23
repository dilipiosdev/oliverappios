//
//  Section1TableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Section3TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    static let identifier = "Section3TableViewCell"
    
    static func nib() -> UINib {
           return UINib(nibName: "Section3TableViewCell", bundle: nil)
       }

    @IBOutlet var collectionView : UICollectionView!
    var titleArray = Array<Any>()
    var firstArray = Array<Any>()
     var secondArray = Array<Any>()
    var thirdArray = Array<Any>()
    var fourthArray = Array<Any>()
    var fifthArray = Array<Any>()
    var sixthArray = Array<Any>()


    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleArray = ["RUS", "RER", "Régimen General","Ley de Zonas Altoandinas"]
        self.firstArray = ["1. Categoría de acuerdo a realidad económica","1. Régimen Tributario intermedio", "1. Es el régimen propio de empresas más grandes.", "1. Exoneración de impuesto a la renta por tercera categoría durante 10 años.", "", ""]
        
         self.secondArray = ["2. Flexibilidad para el acogimiento y para el cambio de categoría","2. Permite emitir facturas", "2. Permite pagar en base a coeficientes", "2. Exoneración de IGV y aranceles para la importación de maquinarias, herramientas, edificios, ordenadores, u otro tipo de equipamiento que esté destinado a la producción de otros productos o servicios durante 10 años", "", ""]
        
        self.thirdArray = ["3. Acogimiento mensual","3, Los pagos son de acuerdo a porcentajes mensuales, que varían de 1.5% a 2.5% mensual, en base al total de ingresos y egerso mensuales.", "3. Tienen contabilidad completa", "3. Acogimiento automático si es que se cumple con los requisitos de ubicación y de actividad.", "", ""]
        
        self.fourthArray = ["4. No  hay obligación de llevar libros contables","", "4. Tienen derecho a deducir crédito fiscal por el IGV pagado en sus operaciones (18%", "", "", ""]
        
        self.fifthArray = ["5. No hay obligación de declarar o pagar el Impuesto a la Renta, ni el Impuesto Generala a las Ventas e Impuesto de Promoción Municipal, sólo debe de cumplir la cuota mensual","", "", "", "", ""]
        
        self.sixthArray = ["6. Permite el pago sin formularios = Pago fácil,  en agencias bancarias a nivel nacional.","", "", "", "", ""]
 
        collectionView.register(Section3CollectionViewCell.nib(), forCellWithReuseIdentifier:Section3CollectionViewCell.identifier)
       
        collectionView.delegate =  self
        collectionView.dataSource =  self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //uicollectionview delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Section3CollectionViewCell.identifier, for: indexPath) as! Section3CollectionViewCell
        cell.topLbl.text = (self.titleArray[indexPath.row] as! String)
        cell.firstLbl.text = (self.firstArray[indexPath.row] as! String)
        cell.secondLbl.text = (self.secondArray[indexPath.row] as! String)
        cell.thirdLbl.text = (self.thirdArray[indexPath.row] as! String)
        cell.fourthLbl.text = (self.fourthArray[indexPath.row] as! String)
        cell.fifthLbl.text = (self.fifthArray[indexPath.row] as! String)
        cell.sixthLbl.text = (self.sixthArray[indexPath.row] as! String)

        return cell
            
       }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) //.zero
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230 , height: 650)
    }
    
}
