//
//  GerenteOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 04/04/21.
//

import UIKit

class GerenteOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titleArray = Array<Any>()
    @IBOutlet weak var tbl: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
          tbl.register(UINib(nibName: "SmileyTableViewCell", bundle: nil), forCellReuseIdentifier: "SmileyTableViewCell")
        
        tbl.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")

        self.titleArray = ["","Identificacion con el negocio/comercio/empresa:", "Relaciones Humanas:", "Iniciativa y Creatividad:", "Capacidad de Comunicacion:", "Productividad:", "Comportamiento en Grupo:", "Organizacion de Trabajo:", "Responsabilidad:", "Superacion Personal:", "Calidad del Trabajo:", "Puntualidad y Asistencia:", "Liderazgo:","Motivacion:","Seguridad, Orden y Limpieza:","Capacitacion y Desarrollo:","Actitud y Colaboracion:","Solucion de Problemas:", "Ambiente de Trabajo:", "Capacidad Personal", "Promocion por Desempeno:" ]

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if indexPath.row == 0 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as! TopTableViewCell
                   cell.titleLbl.text = "Evaluacion de Desempeno 360:"
                   cell.descriptionLbl.text = "Evaluacion realizada por el Gerente o Dueno de la Empresa."
                   return cell
       } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmileyTableViewCell", for: indexPath) as! SmileyTableViewCell
        cell.stepLbl.text = (self.titleArray[indexPath.row] as! String)
        
        cell.sliderStepRating.stepImages =   [UIImage(named:"terrible")!, UIImage(named:"bad")!, UIImage(named:"okay")!, UIImage(named:"good")!,UIImage(named:"great")!, ]
            
        cell.sliderStepRating.tickTitles = ["Terrible", "Bad", "Okay", "Good", "Great"]
            cell.sliderStepRating.tickImages = [UIImage(named:"unTerrible")!, UIImage(named:"unBad")!, UIImage(named:"unOkay")!, UIImage(named:"unGood")!,UIImage(named:"unGreat")!, ]
            
            cell.sliderStepRating.minimumValue = 1
            cell.sliderStepRating.maximumValue = Float(cell.sliderStepRating.stepImages!.count) + cell.sliderStepRating.minimumValue - 1.0
            cell.sliderStepRating.stepTickColor = UIColor.clear
            cell.sliderStepRating.stepTickWidth = 40
            cell.sliderStepRating.stepTickHeight = 40
            cell.sliderStepRating.trackHeight = 2
            cell.sliderStepRating.value = 5
            cell.sliderStepRating.trackColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433258, alpha: 1)
            cell.sliderStepRating.enableTap = true
            cell.sliderStepRating.sliderStepDelegate = self
            cell.sliderStepRating.translatesAutoresizingMaskIntoConstraints = false
        
        
        return cell
        }
    
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 100
        } else {
            return 120
        }
    }

}

//MARK:- SliderStepDelegate
extension GerenteOptionViewController: SliderStepDelegate {
    func didSelectedValue(sliderStep: SliderStep, value: Float) {
        print(Int(value))
       // print(" Step - \(sliderStep) ,Value - \(value)")
    }
}
