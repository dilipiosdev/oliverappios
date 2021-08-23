//
//  AgrumentariosDeVentasVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 06/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class AgrumentariosDeVentasVC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var userListArray = Array<Any>()

    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var txtNumber1: UITextField!
    @IBOutlet weak var txtSludo: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtdiffer: UITextField!
    @IBOutlet weak var txtTel: UITextField!
    @IBOutlet weak var tbl: UITableView!

    var array1 = Array<Any>()
    var array2 = Array<Any>()
    var array3 = Array<Any>()
    var localArray = Array<Any>()
    
    @IBOutlet weak var txtHora: UITextField!
    
    var matchStr = ""
    @IBOutlet weak var subViewTable: UIView!
    var famouStr = String()
    
    var match1 = ""
    var match2 = ""
    var match3 = ""
    var match4 = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        array1 = ["Buenos dias","Buenas Tardes","Buenos Noches" ]
        array2 = ["Precio","Calidad","Variedad" ]
        array3 = ["L-V 8am a 6pm","L-V 8am a 8pm; 8am-1pm","L-S 8am a 8pm" ]
        subViewTable.isHidden = true

    }
   
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func button1(_ sender: Any) {
        if(match1 == "1")
        {
          match1 = "0"
          btn1.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
          famouStr = famouStr.replacingOccurrences(of: "Efectivo", with: "")
          famouStr = famouStr.replacingOccurrences(of: " Efectivo", with: "")
        } else {
            match1 = "1"
            btn1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            famouStr = famouStr + " Efectivo"
        }

    }
    @IBAction func button2(_ sender: Any) {
        if(match2 == "1")
        {
          match2 = "0"
          btn2.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
          famouStr = famouStr.replacingOccurrences(of: "Tarjetas de Debito y Credito", with: "")
          famouStr = famouStr.replacingOccurrences(of: " Tarjetas de Debito y Credito", with: "")

        } else {
            match2 = "1"
            btn2.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
            famouStr = famouStr + "Tarjetas de Debito y Credito"
        }

    }
    @IBAction func button3(_ sender: Any) {
        if(match3 == "1")
        {
          match3 = "0"
          btn3.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
          famouStr = famouStr.replacingOccurrences(of: "Yape", with: "")
          famouStr = famouStr.replacingOccurrences(of: " Yape", with: "")

        } else {
            match3 = "1"
            btn3.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            famouStr = famouStr + "Yape"
        }

    }
    @IBAction func button4(_ sender: Any) {
      
        if(match4 == "1")
        {
          match4 = "0"
          btn4.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
          famouStr = famouStr.replacingOccurrences(of: "Transderencias Bancarias", with: "")
         famouStr = famouStr.replacingOccurrences(of: " Transderencias Bancarias", with: "")

        } else {
            match4 = "1"
            btn4.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            famouStr = famouStr + "Transderencias Bancarias"
        }
    }
    
    @IBAction func buttonSubmit(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AgrumentariosViewController") as! AgrumentariosViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.saludoStr = txtSludo.text ?? ""
        nextViewController.numberStr = txtNumber.text ?? ""
        nextViewController.number1Str = txtNumber1.text ?? ""
        nextViewController.saludoStr = txtSludo.text ?? ""
        nextViewController.diferenciacionStr = txtdiffer.text ?? ""
        nextViewController.famousDePagoStr = famouStr
        nextViewController.telStr = txtTel.text ?? ""
        nextViewController.horarioStr = txtHora.text ?? ""
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonSelect1(_ sender: Any) {
        matchStr = "1"
        subViewTable.isHidden = false
        localArray = array1
        tbl.reloadData()
    }
    
    @IBAction func buttonSelect2(_ sender: Any) {
        matchStr = "2"
        subViewTable.isHidden = false
        localArray = array2

        tbl.reloadData()
    }
    @IBAction func buttonSelect3(_ sender: Any) {
        matchStr = "3"
        subViewTable.isHidden = false
        localArray = array3
        tbl.reloadData()
    }
   
  
}
//MARK:- TableView Methods
extension AgrumentariosDeVentasVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableViewCell", for: indexPath) as! RegisterTableViewCell
        cell.lblText.text = localArray[indexPath.row] as? String
        cell.selectionStyle = .none
        
        return cell
     
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if matchStr == "1" {
            txtSludo.text = localArray[indexPath.row] as? String
        }
        if matchStr == "2" {
            txtdiffer.text = localArray[indexPath.row] as? String
        }
        if matchStr == "3" {
            txtHora.text = localArray[indexPath.row] as? String
        }
        subViewTable.isHidden = true
    }

}
