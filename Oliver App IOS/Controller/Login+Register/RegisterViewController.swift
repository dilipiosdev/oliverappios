//
//  RegisterViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 06/11/20.
//

import UIKit
import Firebase
import AlamofireImage
import FirebaseStorage
import Photos
import SDWebImage
import JGProgressHUD
import AVFoundation
import Alamofire
import AVKit
import Vision

class RegisterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var lbl5: UILabel!
    
    @IBOutlet var selectTablbl1: UILabel!
    @IBOutlet var selectTablbl2: UILabel!
    @IBOutlet var selectTablbl3: UILabel!
    @IBOutlet var selectTablbl4: UILabel!
    @IBOutlet var selectTablbl5: UILabel!
    @IBOutlet var selectTablbl6: UILabel!

    @IBOutlet var subViewMainTitle: UIView!
    @IBOutlet var subViewTitleBg: UIView!
        @IBOutlet var subViewMAinBg: UIView!
    
    @IBOutlet var subViewImageMain: UIView!
    @IBOutlet var subviewMain2: UIView!
    @IBOutlet var subViewMain3: UIView!
    @IBOutlet var subViewMain4: UIView!
    @IBOutlet var subViewMain5: UIView!
    @IBOutlet var subViewTable: UIView!
    @IBOutlet var subViewMain6: UIView!
    
    @IBOutlet var searchSubview: UIView!
    @IBOutlet var txtSearch: UITextField!
    var register1 = Bool()
    var register2 = Bool()
    var register3 = Bool()
    var register4 = Bool()
    var register5 = Bool()

    @IBOutlet var subViewImageConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight: NSLayoutConstraint!
    @IBOutlet var subViewMain2ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMain2ConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewMain3ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMain3ConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewMain4ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMain4ConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewMain5ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMain5ConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewMain6ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMain6ConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewMainTableConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMainTableConstantHeight: NSLayoutConstraint!
    var scrollViewPaging = UIScrollView()
    var sequenceHandler             = VNSequenceRequestHandler()
    var captureImage = Bool()


    
    
    /****************Subview Main 1 ***************/
    @IBOutlet var subViewTop: UIView!
    @IBOutlet var subViewImage: UIView!
    @IBOutlet var imagePhoto: UIImageView!
    var userID = String()
    @IBOutlet var subViewBottom: UIView!
  
    @IBOutlet var buttonCamera: UIButton!
    
    @IBOutlet var buttonGallery: UIButton!
    @IBOutlet var lblImage: UILabel!
    
    /****************Subview Main 2 ***************/
  
    @IBOutlet var subViewRegister2: UIView!
    @IBOutlet var txtNom: UITextField!
    @IBOutlet var txtApel: UITextField!
    @IBOutlet var txtDoc: UITextField!
    @IBOutlet var txtNumDoc: UITextField!
    @IBOutlet var lblMale: UILabel!
    @IBOutlet var lblFemail: UILabel!
    @IBOutlet var imgMaleSelect: UIImageView!
    @IBOutlet var imgFemaleSelect: UIImageView!
    @IBOutlet var buttonMale: UIButton!
    @IBOutlet var tbl: UITableView!
    @IBOutlet var buttonFemale: UIButton!
    var matchTable = String()
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var imgCountry: UIImageView!
    var countryCode = String()
    var countryName = String()
    var gender = String()

    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()

    var currentYear = Int()
    
    
    /****************Subview Main 3 ***************/
    
    @IBOutlet var txtCorreo: UITextField!
    @IBOutlet var txtDepartmento: UITextField!
    @IBOutlet var txtProv: UITextField!
    @IBOutlet var txtDist: UITextField!
    @IBOutlet var txtDirec: UITextField!
    var countryArray = Array<Any>()
    var provincesArray = Array<Any>()
    var districsArray = Array<Any>()
    
    var ocupationArray = Array<Any>()
    var gradoArray = Array<Any>()


    var selectCountry = Dictionary<String,Any>()
    var selectProvinces = Dictionary<String,Any>()
    var selectDistrics = Dictionary<String,Any>()
    var localArray = Array<Any>()
    var documentTypeArray = Array<Any>()

    
    @IBOutlet var subViewEmail: UIView!
    @IBOutlet var subViewAddress: UIView!
    
    
    /****************Subview Main 4 ***************/
    
    @IBOutlet var txtOcupaction: UITextField!
    @IBOutlet var txtGrado: UITextField!
    @IBOutlet var subViewOccupation: UIView!
    
    
    
    
    /****************Subview Main 5 ***************/
    
    @IBOutlet var txtnombers: UITextField!
    @IBOutlet var txtPin: UITextField!
    @IBOutlet var txtPinConfirm: UITextField!
    @IBOutlet var subViewRegister5: UIView!
    @IBOutlet var subViewNobers: UIView!
    @IBOutlet var subViewPinTitle: UIView!
    @IBOutlet var subViewPin: UIView!
    
    
    
    /****************Subview Main 6 ***************/

    @IBOutlet var lblRegister1: UILabel!
    @IBOutlet var lblRegister2: UILabel!
    @IBOutlet var lblRegister3: UILabel!
    @IBOutlet var lblRegister4: UILabel!
    @IBOutlet var lblRegister5: UILabel!

    @IBOutlet var subViewRegister60: UIView!
    @IBOutlet var subViewRegister61: UIView!
    @IBOutlet var subViewRegister62: UIView!
    @IBOutlet var subViewRegister63: UIView!
    @IBOutlet var subViewRegister64: UIView!
    @IBOutlet var subViewRegister65: UIView!
    @IBOutlet var buttonTermS: UIButton!
    
    @IBOutlet var imgComplet1: UIImageView!
    @IBOutlet var imgComplet2: UIImageView!
    @IBOutlet var imgComplet3: UIImageView!
    @IBOutlet var imgComplet4: UIImageView!
    @IBOutlet var imgComplet5: UIImageView!
    
    
    
    
    var matchTerms = String()
    override func viewDidLoad() {
        
        cameraSubView?.isHidden = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        gradientLayer.frame.size.height = UIScreen.main.bounds.height
        gradientLayer.colors = [UIColor(displayP3Red: 0.0/255.0, green: 151.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.subViewTitleBg.layer.addSublayer(gradientLayer)
        self.subViewMAinBg.layer.addSublayer(gradientLayer)
        matchTerms = "false"
        appDelegate.matchView = "Register"
        selectTablbl1.isHidden = false
        selectTablbl2.isHidden = true
        selectTablbl3.isHidden = true
        selectTablbl4.isHidden = true
        selectTablbl5.isHidden = true
        selectTablbl6.isHidden = true
        
        self.imgMaleSelect.image = UIImage(named: "checkBlue")
        self.imgFemaleSelect.image = nil
        super.viewDidLoad()
        manageView()
        
        
        txtSearch.delegate = self
        subViewTable.isHidden = true
        /******************** Register Table Cell ****************************/
            tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        countryCode = "+91"
        countryName = "India"
        
        if(userID.count == 0)
        {
            userID = "HqddlD46EPZwoLvSyvL6WcBPlR43"
        }
        self.navigationController?.navigationBar.isHidden = true
        gender = "Hombre"
        
        getImagefromFireBase()
        getDataFromFireBase()
        
        
         scrollViewPaging = UIScrollView(frame: CGRect(x: 0 , y: subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)))
        
         scrollViewPaging.isPagingEnabled = true
         scrollViewPaging.backgroundColor = .white
         scrollViewPaging.showsVerticalScrollIndicator = false
         scrollViewPaging.showsHorizontalScrollIndicator = false
         scrollViewPaging.delegate = self
         view.addSubview(scrollViewPaging)
        
        
        
          let numberOfPages :Int = 5
          let padding : CGFloat = 0
          let viewWidth = scrollViewPaging.frame.size.width - 2 * padding
          let viewHeight = scrollViewPaging.frame.size.height - 2 * padding

          var x : CGFloat = 0
        
           for i in 0...numberOfPages
           {
              let view: UIView = UIView(frame: CGRect(x: x + padding, y: padding, width: viewWidth, height: viewHeight))
              view.backgroundColor = UIColor.white
            
              if(i == 0)
              {
                subViewImageMain.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
                subViewImageConstWidth.constant = UIScreen.main.bounds.size.width
            
                subViewImageConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewImageMain.clipsToBounds = true
                view.addSubview(subViewImageMain)

              }
              if(i == 1)
              {
                subviewMain2.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
                subViewMain2ConstWidth.constant = UIScreen.main.bounds.size.width
          
                subViewMain2ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subviewMain2.clipsToBounds = true
                view.addSubview(subviewMain2)

              }
              if(i == 2)
              {
                subViewMain3.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
                subViewMain3ConstWidth.constant = UIScreen.main.bounds.size.width
        
                subViewMain3ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewMain3.clipsToBounds = true
                view.addSubview(subViewMain3)

              }
             if(i == 3)
             {
               subViewMain4.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
               subViewMain4ConstWidth.constant = UIScreen.main.bounds.size.width
      
               subViewMain4ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
               subViewMain4.clipsToBounds = true
               view.addSubview(subViewMain4)

            }
            if(i == 4)
            {
              subViewMain5.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
              subViewMain5ConstWidth.constant = UIScreen.main.bounds.size.width
              subViewMain5ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewMain5.clipsToBounds = true
              view.addSubview(subViewMain5)

            }
            if(i == 5)
            {
              subViewMain6.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
              subViewMain6ConstWidth.constant = UIScreen.main.bounds.size.width
              subViewMain6ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewMain6.clipsToBounds = true
              view.addSubview(subViewMain6)

            }
            
               
                view.clipsToBounds = true
                scrollViewPaging.addSubview(view)
                x = view.frame.origin.x + viewWidth + padding
           }


          scrollViewPaging.contentSize = CGSize(width:x+padding, height:scrollViewPaging.frame.size.height)
        
        self.view.addSubview(subViewTable)
        subViewMainTableConstWidth.constant = UIScreen.main.bounds.size.width
        subViewMainTableConstantHeight.constant = UIScreen.main.bounds.size.height
        
}
    
    override func viewWillAppear(_ animated: Bool) {


    }
    
    
    func manageView() -> Void {
         register1 = false
         register2 = false
         register3 = false
         register4 = false
         register5 = false
        
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        
        ocupationArray = ["Abogado","Actor","Accionista","Artista","Director de Espectáculos","Administrador","Agente de Aduanas","Aeromozo","Agente de Bolsa","Agente de Turismo","Agricultor","Agrónomo","Analista de Sistemas","Antropólogo","Arqueólogo","Archivero","Armador de Barco","Arquitecto","Artesano","Asistente Social","Autor Literario","Avicultor","Bacteriólogo","Biólogo","Basurero","Cajero","Camarero","Cambista de Divisas","Campesino","Capataz","Cargador","Carpintero","Cartero","Cerrajero","Chef","Científico","Cobrador","Comerciante","Conductor","Conserje","Constructor","Contador","Contratista","Corredor Inmobiliario","Corredor de Seguros","Corte y Confección de Ropas","Cosmetólogo","Decorador","Dibujante","Dentista","Deportista","Distribuidor","Docente","Doctor - Medicina","Economista","Electricista","Empresario","Exportador","Importador","Inversionista","Enfermero","Ensamblador","Escultor","Estudiante","Fotógrafo","Gerente","Ingeniero","Jubilado","Maquinista","Mayorista","Mecánico","Médico","Miembro de las Fuerzas Armadas","Nutricionista","Obstetriz","Obrero de Construcción","Organizador de Eventos","Panadero","Pastelero","Paramédico","Periodista","Perito","Pescador","Piloto","Pintor","Policía","Productor de Cine","Programador","Psicólogo","Relojero","Rentista","Repartidor","Secretaría","Seguridad","Sociólogo","Tasador","rabajador Independiente","Trabajador Dependiente","Transportista","Veterinario","Visitador Medico","Zapatero"]

       
        
           gradoArray = ["Educación Inicial","Educación Primaria","Educación Secundaria","Educación Superior Técnica","Educación Superior Universitaria","Maestría","Doctorado"]

       
           documentTypeArray = ["D.N.I"]
        
        
        
        
        
        
        
        
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
        
        lbl1.layer.cornerRadius = 14
        lbl2.layer.cornerRadius = 14
        lbl3.layer.cornerRadius = 14
        lbl4.layer.cornerRadius = 14
        lbl5.layer.cornerRadius = 14
        
        subViewTop.layer.cornerRadius = 5
        buttonCamera.layer.cornerRadius = 5
        buttonGallery.layer.cornerRadius = 5
 
        
        searchSubview.layer.cornerRadius = 10
        searchSubview.clipsToBounds = true
        
        subViewImage.layer.cornerRadius = 10
        subViewImage.clipsToBounds = true
        
        subViewBottom.layer.cornerRadius = 5
        subViewBottom.clipsToBounds = true
        
        imagePhoto.layer.cornerRadius = 10
        imagePhoto.clipsToBounds = true
        
        subViewRegister2.layer.cornerRadius = 10
        subViewRegister2.clipsToBounds = true
        
        subViewEmail.layer.cornerRadius = 10
        subViewEmail.clipsToBounds = true
        
        subViewAddress.layer.cornerRadius = 5
        subViewAddress.clipsToBounds = true
        
        subViewOccupation.layer.cornerRadius = 5
        subViewOccupation.clipsToBounds = true
        
        subViewRegister5.layer.cornerRadius = 5
        subViewRegister5.clipsToBounds = true
        
        subViewNobers.layer.cornerRadius = 5
        subViewNobers.clipsToBounds = true
        
        subViewPinTitle.layer.cornerRadius = 5
        subViewPinTitle.clipsToBounds = true
        
        subViewPin.layer.cornerRadius = 5
        subViewPin.clipsToBounds = true
        
        buttonTermS.layer.cornerRadius = 15
        buttonTermS.clipsToBounds = true
        buttonTermS.layer.borderColor = UIColor.blue.cgColor
        buttonTermS.layer.borderWidth = 1
        
        
        subViewRegister60.layer.cornerRadius = 5
        subViewRegister60.clipsToBounds = true
        subViewRegister61.layer.cornerRadius = 5
        subViewRegister61.clipsToBounds = true
        subViewRegister62.layer.cornerRadius = 5
        subViewRegister62.clipsToBounds = true
        subViewRegister63.layer.cornerRadius = 5
        subViewRegister63.clipsToBounds = true
        subViewRegister64.layer.cornerRadius = 5
        subViewRegister64.clipsToBounds = true
        subViewRegister65.layer.cornerRadius = 5
        subViewRegister65.clipsToBounds = true
        
        imgMaleSelect.layer.cornerRadius = imgMaleSelect.frame.size.height/2
        imgMaleSelect.clipsToBounds = true
        imgMaleSelect.layer.borderWidth = 1
        imgMaleSelect.layer.borderColor = UIColor.blue.cgColor
        
        imgFemaleSelect.layer.cornerRadius = imgFemaleSelect.frame.size.height/2
        imgFemaleSelect.clipsToBounds = true
        imgFemaleSelect.layer.borderWidth = 1
        imgFemaleSelect.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    /*****************************GET Data from fire base **************************/
    func getImagefromFireBase() -> Void
    {
        /***************Register 1 Get Data ********************/
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        lblRegister1.text = "A la espera de tu footo de perfil."
        lblRegister2.textColor = .gray
        let userRef = Database.database().reference().child("Users/\(userID)")
        userRef.observe(.value) {  (snapshot) in
        if let dict = snapshot.value as? [String: Any],
        let userImage = dict["profileimage"] as? String
        {
          if(userImage.count > 0)
          {
            self.lblImage.text = "Esta foto es adecuada para tu perfil"
            self.lblImage.textColor = #colorLiteral(red: 0.001631148917, green: 1, blue: 0.4867287994, alpha: 1)
            let image:UIImage = UIImage(named: "back")!
            let url = NSURL(string: userImage)
            self.imagePhoto.af.setImage(withURL: url! as URL, placeholderImage: image)
            self.register1 = true
            self.lblRegister1.text = "Foto de perfil cargada con exito"
            self.lblRegister1.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.imgComplet1.image = UIImage(named: "checkBlue")

             hud.dismiss()
          }
          
        }
        else
        {
            hud.dismiss()
        }
       }
    }
    
    func getDataFromFireBase() -> Void {
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let userRef1 = Database.database().reference().child("Users/\(userID)")
        userRef1.observe(.value) {  (snapshot) in
        if let dict1 = snapshot.value as? [String: Any]
         {
            /***************Register 2 Get Data ********************/
            hud.dismiss()
            self.txtNom.text = dict1["name"] as? String
            self.txtApel.text = dict1["surname"] as? String
            self.txtDoc.text = dict1["document_type"] as? String
            self.txtNumDoc.text = dict1["document_number"] as? String
            if(dict1["gender"] as? String == "Hombre")
            {
                self.imgMaleSelect.image = UIImage(named: "checkBlue")
                self.imgFemaleSelect.image = nil
                self.gender = "Hombre"
                
            }
            else
            {
                self.imgFemaleSelect.image = UIImage(named: "checkBlue")
                self.imgMaleSelect.image = nil
                self.gender = "Mujer"
            }
            self.lblDate.text = dict1["bth_day"] as? String
            self.lblMonth.text = dict1["bth_month"] as? String
            self.lblYear.text = dict1["bth_year"] as? String
            
            if(self.txtNom.text?.isEmpty == true || self.txtApel.text?.isEmpty == true || self.txtDoc.text?.isEmpty == true || self.txtNumDoc.text?.isEmpty == true || self.gender.isEmpty == true || self.lblDate.text?.isEmpty == true || self.lblMonth.text?.isEmpty == true || self.lblYear.text?.isEmpty == true)
            {
                self.register2 = false
                self.lblRegister2.text = "Falta completar datos."
                self.lblRegister2.textColor = .red
                self.imgComplet2.image = UIImage(named: "time")
            }
            else
            {
                self.register2 = false
                self.lblRegister2.text = "Falta completar datos."
                self.lblRegister2.textColor = .red
                self.imgComplet2.image = UIImage(named: "time")
            }
            
            if(self.lblDate.text?.isEmpty == true)
            {
                self.lblDate.text! = "Dia"
            }
            if(self.lblMonth.text?.isEmpty == true)
            {
                self.lblMonth.text! = "Mes"
            }
            if(self.lblYear.text?.isEmpty == true)
            {
                self.lblYear.text! = "Año"
            }
            
            
            
            
            
            
            
            
            
            /******************************Register 3 Get Data***************************************/

            

            self.txtCorreo.text = dict1["email"] as? String
            self.txtDepartmento.text = dict1["department"] as? String
            self.txtProv.text = dict1["province"] as? String
            self.txtDist.text = dict1["district"] as? String
            self.txtDirec.text = dict1["address"] as? String
            
            if(self.txtCorreo.text!.count <= 0 || self.txtDepartmento.text!.count <= 0 || self.txtProv.text!.count <= 0 || self.txtDist.text!.count <= 0 || self.txtDirec.text!.count <= 0)
            {
                self.register3 = false
                self.lblRegister3.text = "Falta completar datos."
                self.lblRegister3.textColor = .red
                self.imgComplet3.image = UIImage(named: "time")

            }
            else
            {
                self.register3 = true
                self.lblRegister3.text = "Data de contacto completado."
                self.lblRegister3.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                self.imgComplet3.image = UIImage(named: "checkBlue")


            }

            /******************************Register 4 Get Data***************************************/
            
            self.txtOcupaction.text = dict1["occupation"] as? String
            self.txtGrado.text = dict1["academic_degree"] as? String
            if(self.txtOcupaction.text!.count <= 0 || self.txtGrado.text!.count <= 0)
            {
                self.register4 = false
                self.lblRegister4.text = "Falta completar datos."
                self.lblRegister4.textColor = .red
                self.imgComplet4.image = UIImage(named: "time")

            }
            else
            {
                self.register4 = true
                self.lblRegister4.text = "Data de contacto completado."
                self.lblRegister4.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                self.imgComplet4.image = UIImage(named: "checkBlue")


            }


            /******************************Register 5 Get Data***************************************/

            self.txtnombers.text = dict1["username"] as? String
            self.txtPin.text = dict1["pin"] as? String
            
            if(self.txtnombers.text!.count <= 0 || self.txtPin.text!.count <= 0)
            {
                self.register5 = false
                self.lblRegister5.text = "Falta completar datos."
                self.lblRegister5.textColor = .red
                self.imgComplet5.image = UIImage(named: "time")

            }
            else
            {
                self.register5 = true
                self.lblRegister5.text = "Data de contacto completado."
                self.lblRegister5.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                self.imgComplet5.image = UIImage(named: "checkBlue")

            }
         }
        else
        {
            hud.dismiss()
        }
       }
    }
    
    
    /******************************View Shadow ********************/
    override func viewDidLayoutSubviews() {
        subViewTop.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewImage.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewBottom.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        searchSubview.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister2.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewEmail.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewAddress.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        subViewOccupation.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        subViewRegister5.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewNobers.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewPinTitle.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewPin.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        subViewRegister60.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister61.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister62.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister63.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister64.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister65.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }

    @IBAction func buttonCamera(_ sender: Any) {
//        self.view.addSubview(cameraSubView!)
//        cameraSubView?.isHidden = false
//        Start()
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
     
    }
    
    @IBAction func buttonGallery(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    /************************* Image Picker Delegate ****************************/
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
      {
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage]
             imagePhoto.image = (chosenImage as! UIImage)
            picker.dismiss(animated: true, completion: nil)
        
        
        if(imagePhoto.image?.size.width == nil)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes cargar uno foto de perfil correctamente.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        var data = NSData()
        data = imagePhoto.image!.jpegData(compressionQuality: 0.8)! as NSData
        if(data.count > 0)
        {
          let storge = Storage.storage().reference().child("Profile Images/").child(userID)
          storge.putData(data as Data, metadata: nil){ (metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                hud.dismiss()
                return
            }else
            {
                storge.downloadURL(completion: { [self] (url, error) in
              if let urlText = url?.absoluteString
              {
                 hud.dismiss()
                 Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["profileimage": urlText])
                        print("Successfull")
                self.scrollToPage(page: 1, animated: true)
                self.subViewTable.isHidden = true
                self.selectTablbl1.isHidden = false
                self.selectTablbl2.isHidden = true
                self.selectTablbl3.isHidden = true
                self.selectTablbl4.isHidden = true
                self.selectTablbl5.isHidden = true
                }
             })
          }
        }
      }
      else
      {
         hud.dismiss()
         let alertView: UIAlertController = UIAlertController(title: title, message: "Debes cargar uno foto de perfil correctamente.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertView.dismiss(animated: true, completion: nil)
         }
         alertView.addAction(alertAction)
         self.present(alertView, animated: true, completion: nil)
      }
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated:  true, completion: nil)
    }
    
    
    
    @IBAction func button1(_ sender: Any) {
        self.scrollToPage(page: 0, animated: true)
        subViewTable.isHidden = true
        self.selectTablbl1.isHidden = false
        hideBottomLbl(index: 0)


    }
   
    @IBAction func button2(_ sender: Any) {
        self.scrollToPage(page: 1, animated: true)
        subViewTable.isHidden = true
        hideBottomLbl(index: 1)

    }
    @IBAction func button3(_ sender: Any) {
        self.scrollToPage(page: 2, animated: true)
        subViewTable.isHidden = true
        hideBottomLbl(index: 2)


    }
    
    @IBAction func button4(_ sender: Any) {
        self.scrollToPage(page: 3, animated: true)
        hideBottomLbl(index: 3)

    }
    @IBAction func button5(_ sender: Any) {
        self.scrollToPage(page: 4, animated: true)
        subViewTable.isHidden = true
        hideBottomLbl(index: 4)

   
    }
    @IBAction func button6(_ sender: Any) {
        self.scrollToPage(page: 5, animated: true)
        subViewTable.isHidden = true
        hideBottomLbl(index: 5)

    }
    
    func hideBottomLbl(index:Int) -> Void {
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
        self.selectTablbl6.isHidden = true

        if(index == 0)
        {
          self.selectTablbl1.isHidden = false
        }
        if(index == 1)
        {
          self.selectTablbl2.isHidden = false
        }
        if(index == 2)
        {
          self.selectTablbl3.isHidden = false
        }
        if(index == 3)
        {
          self.selectTablbl4.isHidden = false
        }
        if(index == 4)
        {
          self.selectTablbl5.isHidden = false
        }
        if(index == 5)
        {
          self.selectTablbl6.isHidden = false
        }
    }
    
    
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollViewPaging.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollViewPaging.scrollRectToVisible(frame, animated: animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollViewPaging {
            let pageWidth:CGFloat = scrollView.frame.width
            let current:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            hideBottomLbl(index: Int(current))
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        /********************SubViewMain 2 ************************/
        txtNom.backgroundColor = #colorLiteral(red: 0.8857035041, green: 0.9052242637, blue: 0.9087205529, alpha: 1)
        txtApel.backgroundColor = #colorLiteral(red: 0.8857035041, green: 0.9052242637, blue: 0.9087205529, alpha: 1)
        txtDoc.backgroundColor = #colorLiteral(red: 0.8857035041, green: 0.9052242637, blue: 0.9087205529, alpha: 1)
        txtNumDoc.backgroundColor = #colorLiteral(red: 0.8857035041, green: 0.9052242637, blue: 0.9087205529, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.5158197284, green: 0.6004604697, blue: 0.6610026956, alpha: 1)
    }
    @IBAction func buttonContinue1(_ sender: Any)
    {
     
        
        self.scrollToPage(page: 1, animated: true)
        self.subViewTable.isHidden = true
        self.selectTablbl1.isHidden = false
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
        self.selectTablbl6.isHidden = true

   }
    
    
    
    /****************Subview Main 2 ***************/
    
    @IBAction func buttonMail(_ sender: Any)
    {
        imgMaleSelect.image = UIImage(named: "checkBlue")
        imgFemaleSelect.image = nil
        gender = "Hombre"
        Database.database().reference().child("Users").child(userID).updateChildValues([
             "gender": gender,
        ])
    }
    @IBAction func buttonFemale(_ sender: Any) {
        imgFemaleSelect.image = UIImage(named: "checkBlue")
        imgFemaleSelect.image = nil

        gender = "Mujer"
        Database.database().reference().child("Users").child(userID).updateChildValues([
             "gender": gender,
        ])

    }
    @IBAction func buttonDocumentType(_ sender: Any) {
        txtSearch.text = ""
        localArray = documentTypeArray
        matchTable = "Document-Type"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    
    
    
    
    @IBAction func buttonDate(_ sender: Any) {
        txtSearch.text = ""
        localArray = daysArray
        matchTable = "Date"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonMonth(_ sender: Any) {
        txtSearch.text = ""
        localArray = monthArray
        matchTable = "Month"
        subViewTable.isHidden = false
        tbl.reloadData()


    }
    @IBAction func buttonYear(_ sender: Any) {
        txtSearch.text = ""
        localArray = yearArray

        matchTable = "Year"
  
        subViewTable.isHidden = false
        tbl.reloadData()


    }
    /********************************** Add andUpdate  Register 2*******************************/

    
    @IBAction func buttonContinue2(_ sender: Any) {
        if(txtNom.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu nomber.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtApel.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tus apellidos.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtDoc.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes Seleccionar tu tipo de Documento.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(txtNumDoc.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar el numero de tu Documento de identidad.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(gender.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar el numero de tu Documento de identidad.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        if((lblDate.text!.count <= 0) || (lblDate.text! == "Dia"))
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu dia de nacimiento.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if((lblMonth.text?.isEmpty == true) || (lblMonth.text! == "Mes"))
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu mes de nacimiento.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if((lblYear.text?.isEmpty == true) || (lblYear.text! == "Año"))
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu mes de nacimiento.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
    
        
        
         self.scrollToPage(page: 2, animated: true)
         subViewTable.isHidden = true
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = false
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
        self.selectTablbl6.isHidden = true

}
    
    
    // Mark:- TableView Delegate Method
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(matchTable == "Date")
        {
           return  daysArray.count
        }
        else if(matchTable == "Month")
        {
            return  monthArray.count
        }
        else if(matchTable == "Year")
        {
            return  yearArray.count
        }
        else if (matchTable == "Country")
        {
            return countryArray.count
        }
        else if (matchTable == "Provinces")
        {
            return provincesArray.count

        }
        else if (matchTable == "Districs")
        {
            return districsArray.count

        }
        else if (matchTable == "Occupation")
        {
            return ocupationArray.count

        }
        else if (matchTable == "Grado")
        {
            return gradoArray.count

        }
        else if (matchTable == "Document-Type")
        {
            return documentTypeArray.count

        }
        
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RegisterTableViewCell = self.tbl.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
        cell.selectionStyle = .none
        cell.subViewSearch.layer.cornerRadius = 5
        cell.subViewSearch.clipsToBounds = true
        if(matchTable == "Date")
        {
            cell.lblText.text = daysArray[indexPath.row] as? String

        }
        else if(matchTable == "Month")
        {
            cell.lblText.text = monthArray[indexPath.row] as? String

        }
        else if(matchTable == "Year")
        {
            cell.lblText.text = String(format: "%@", yearArray[indexPath.row] as! String)

        }
        else if (matchTable == "Country")
        {
            let dict = countryArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
        else if (matchTable == "Provinces")
        {
            let dict = provincesArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
        else if (matchTable == "Districs")
        {
            let dict = districsArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
        else if(matchTable == "Occupation")
        {
            cell.lblText.text = String(format: "%@", ocupationArray[indexPath.row] as! String)

        }
        else if(matchTable == "Grado")
        {
            cell.lblText.text = String(format: "%@", gradoArray[indexPath.row] as! String)

        }
        else if (matchTable == "Document-Type")
        {
            cell.lblText.text = String(format: "%@", documentTypeArray[indexPath.row] as! String)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(matchTable == "Date")
        {
           
            subViewTable.isHidden = true
            lblDate.text = daysArray[indexPath.row] as? String
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "bth_day": lblDate.text!,
            ])
            return
        }
        if(matchTable == "Month")
        {
            
            subViewTable.isHidden = true
            lblMonth.text = monthArray[indexPath.row] as? String
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "bth_month": lblMonth.text!,
            ])
            return
        }
        if(matchTable == "Year")
        {
            
            subViewTable.isHidden = true
            lblYear.text = String(format: "%@",  yearArray[indexPath.row] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "bth_year": lblYear.text!,
            ])
            return
        }
        if(matchTable == "Country")
        {
            subViewTable.isHidden = true
            selectCountry = countryArray[indexPath.row] as! Dictionary<String,Any>
            txtDepartmento.text = String(format: "%@", selectCountry["nombre_ubigeo"] as! String)
            
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "department": txtDepartmento.text!,
                 "province": "",
                 "district": "",

            ])
            
            
            return
        }
        if(matchTable == "Provinces")
        {
            subViewTable.isHidden = true
            selectProvinces = provincesArray[indexPath.row] as! Dictionary<String,Any>
            txtProv.text = String(format: "%@", selectProvinces["nombre_ubigeo"] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "province": txtProv.text!,
                 "district": "",
            ])
            return
        }
        if(matchTable == "Districs")
        {
           
            subViewTable.isHidden = true
            selectDistrics = districsArray[indexPath.row] as! Dictionary<String,Any>
            txtDist.text = String(format: "%@", selectDistrics["nombre_ubigeo"] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "district": txtDist.text!,
            ])
            return
        }
        if(matchTable == "Occupation")
        {
           
            subViewTable.isHidden = true
            txtOcupaction.text = String(format: "%@", ocupationArray[indexPath.row] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                 "occupation": txtOcupaction.text!,
            ])
            return
        }
        if(matchTable == "Grado")
        {
           
            subViewTable.isHidden = true
            txtGrado.text = String(format: "%@", gradoArray[indexPath.row] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                "academic_degree": txtGrado.text!
            ])
            return
        }
        if (matchTable == "Document-Type")
        {
            subViewTable.isHidden = true
            txtDoc.text = String(format: "%@", documentTypeArray[indexPath.row] as! String)
            Database.database().reference().child("Users").child(userID).updateChildValues([
                "document_type": txtDoc.text!
            ])
            return
        }
    }
    
    
    @IBAction func buttonClose(_ sender: Any) {
        if(matchTable == "Date")
        {
           
            subViewTable.isHidden = true
            return
        }
        
        subViewTable.isHidden = true
    }
    
    @IBAction func buttonContryCode(_ sender: Any) {
        let picker = ADCountryPicker(style: .grouped)
        picker.delegate = self
        picker.showCallingCodes = true
        picker.didSelectCountryClosure = { name, code in
        _ = picker.navigationController?.popToRootViewController(animated: true)
                  print(code)
        }
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    /****************Subview Main 3 ***************/
    
    @IBAction func buttonContinue3(_ sender: Any) {
        if(txtCorreo.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu correo electronnico.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtDepartmento.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes seleccionar el departamento de domicillio.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtProv.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes seleccionar la provincia de domicillio.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtDist.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes seleccionar el distrito de domicillio.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
        if(txtDirec.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu direccion exacta.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
            
        }
      
        
        self.scrollToPage(page: 3, animated: true)
        subViewTable.isHidden = true
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = false
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
        self.selectTablbl6.isHidden = true


    }
    
    @IBAction func buttonSelectCountry(_ sender: Any) {
        txtSearch.text = ""

        txtProv.text = ""
        selectProvinces.removeAll()
        provincesArray.removeAll()
        
        txtDist.text = ""
        selectDistrics.removeAll()
        districsArray.removeAll()
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let userRef = Database.database().reference().child("Peru Locations").child("Departments")
        
        userRef.observe(.value) { (snapshot) in
            if let country = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(country)
                self.matchTable = "Country"
                self.countryArray = country
                self.subViewTable.isHidden = false
                self.localArray = self.countryArray
                self.tbl.reloadData()
                
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    @IBAction func buttonProvinces(_ sender: Any) {
        
        if(selectCountry.isEmpty == true)
        {
            return
        }
        txtSearch.text = ""
        txtDist.text = ""
        selectDistrics.removeAll()
        districsArray.removeAll()
        
        let countryId = selectCountry["id_ubigeo"] as? String ?? "0"
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Provinces").child(countryId)
        userRef.observe(.value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.matchTable = "Provinces"
                self.provincesArray = districs
                self.subViewTable.isHidden = false
                self.localArray = self.provincesArray
                self.tbl.reloadData()
                
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    @IBAction func buttonDistrics(_ sender: Any) {
        
        if(selectProvinces.isEmpty == true)
        {
            return
        }
        
        txtSearch.text = ""
        let provincesId = selectProvinces["id_ubigeo"] as? String ?? "0"
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Districs").child(provincesId)
        userRef.observe(.value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.matchTable = "Districs"
                self.districsArray = districs
                self.subViewTable.isHidden = false
                self.localArray = self.districsArray
                self.tbl.reloadData()
                
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    
    
 
    @IBAction func txtSearch(_ sender: Any) {
        if(matchTable == "Date")
        {
            self.daysArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.daysArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                daysArray = localArray
            }
        }
        
        if(matchTable == "Month")
        {
            self.monthArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.monthArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                monthArray = localArray
            }
        }
        
        if(matchTable == "Year")
        {
            self.yearArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.yearArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                yearArray = localArray
            }
        }
        
        if(matchTable == "Country")
        {
            self.countryArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                countryArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                countryArray = localArray
            }
        }
        if(matchTable == "Provinces")
        {
            self.provincesArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                provincesArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                provincesArray = localArray
            }
        }
        if(matchTable == "Districs")
        {
            self.districsArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                districsArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                districsArray = localArray
            }
        }
        
        if(matchTable == "Occupation")
        {
            self.ocupationArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.ocupationArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                ocupationArray = localArray
            }
        }
        
        if(matchTable == "Grado")
        {
            self.gradoArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.gradoArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                gradoArray = localArray
            }
        }
        if(matchTable == "Document-Type")
        {
            self.documentTypeArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.documentTypeArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                documentTypeArray = localArray
            }
        }
        
        tbl.reloadData()
   }
    
    /****************Subview Main 4 ***************/
    @IBAction func buttonOccupation(_ sender: Any) {
        txtSearch.text = ""
        localArray = ocupationArray
        matchTable = "Occupation"
  
        subViewTable.isHidden = false
        tbl.reloadData()
        
    }
    @IBAction func buttonGrado(_ sender: Any) {
        
        txtSearch.text = ""
        localArray = gradoArray
        matchTable = "Grado"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    
    @IBAction func buttonContinue4(_ sender: Any) {
        
        if(txtOcupaction.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes seleccionar tu ocupacion.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(txtGrado.text!.count <= 0)

        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes seleccionar tu grado acadenico.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
      
        
        self.scrollToPage(page: 4, animated: true)
        subViewTable.isHidden = true
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = false
        self.selectTablbl6.isHidden = true

    }
    
    
    
    
    
    
    
    /****************Subview Main 5 ***************/
    
    @IBAction func buttonContinue5(_ sender: Any)
    {
        
     
    
        if(txtnombers.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar un nombre de usuario", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(txtPin.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar un PIN de seguridad", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(txtPinConfirm.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes confirmar un PIN de seguridad", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if(txtPin.text != txtPinConfirm.text)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Los PIN de seguridad no coinciden", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        
      
        self.scrollToPage(page: 5, animated: true)
        subViewTable.isHidden = true
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
        self.selectTablbl6.isHidden = false

    }
    
    
    /****************Subview Main 6 ***************/
    
 @IBAction func buttonContinue6(_ sender: Any)
 {
    
    let hud = JGProgressHUD(style: .light)
    hud.textLabel.text = "Loading"
    hud.show(in: self.view)
      let UrlStr = "https://api.reniec.cloud/dni/" + txtNumDoc.text!
      AF.request(UrlStr, method:.get, parameters: nil).validate().responseJSON { (response) in
      if (response.response != nil)
      {
         let dict =  response.value as? Dictionary<String,Any>
         if (dict?.isEmpty == false)
         {
           let nameStr = self.txtNom.text!.uppercased() + " " + self.txtApel.text!.uppercased()
            let serverName = String(format: "%@ %@ %@", dict?["nombres"] as? String ?? "",dict?["apellido_paterno"] as! String, dict?["apellido_materno"] as? String ?? "")
            
          if(serverName.uppercased() ==  nameStr)
          {
            self.register2 = true
            self.register6Main()
          }
          else
          {
            let alertView: UIAlertController = UIAlertController(title: "", message: "El nombre de su documento no coincide. Inténtalo de nuevo.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
          }
           hud.dismiss()
        }
        else
        {
            hud.dismiss()
            let alertView: UIAlertController = UIAlertController(title: "", message: "Su número de documento es incorrecto. Ingrese el número correcto.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            
        }
      }
     }
    }
    
    
    func register6Main() -> Void {
        
        if(matchTerms == "false")
        {
            let alertView: UIAlertController = UIAlertController(title: "", message: "Acepte los términos y condiciones.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        if(register1 == true && register2 == true && register3 == true && register4 == true && register5 == true)
         {
             let date = Date()
             let formatter = DateFormatter()
             formatter.dateFormat = "dd-MM-yyyy"
             let dateStr = formatter.string(from: date)
             
             let calender = Calendar.current
             let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
             let timeStr = String(format: "%d:%d:%d", components.hour!,components.minute!,components.second!)
             let timeStrSave = String(format: "%d%d%d%%d%d%d%", components.year!,components.month!,components.day!,components.hour!,components.minute!,components.second!)
             
             
             if(appDelegate.diviceToken.count == 0)
             {
                 appDelegate.diviceToken = "988bihy8767nkjhy78yhgb78"
             }
             let quimage = generateQRCode(from: appDelegate.diviceToken)
             var data = NSData()
             data = quimage!.jpegData(compressionQuality: 0.8)! as NSData
             if(data.count > 0)
             {
               let storge = Storage.storage().reference().child("Profile Images/").child(timeStrSave)
               storge.putData(data as Data, metadata: nil){ (metaData,error) in
                 if let error = error {
                     print(error.localizedDescription)
                     return
                 }else
                 {
                     storge.downloadURL(completion: { [self] (url, error) in
                   if let urlText = url?.absoluteString
                   {
                      Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["qr_code_image": urlText])
                             print("Successfull")
                    
                     }
                  })
               }
             }
           }
             
            let timestamp = NSDate().timeIntervalSince1970
             Database.database().reference().child("Users").child(userID).updateChildValues([
                 "user_verification": "progress",
                 "document_verification": "None",// Ask
                 "basic_account_pen": "0.0",
                 "basic_account_usd": "0.00",
                 "state": "offline",
                 "credit_line_pen": "false",
                 "credit_line_pen_available": "0.00",
                 "credit_line_pen_tcea": "800.00",
                 "credit_line_pen_total": "0.00",
                 "credit_line_pen_used": "0.00",
                 "credit_line_usd": "false",
                 "credit_line_usd_available": "0.00",
                 "credit_line_usd_tcea": "800.00",
                 "credit_line_usd_total": "0.00",
                 "credit_line_usd_used": "0.00",
                 "credit_risk_param": "0.00",
                 "credit_score": "5",
                 "credit_line_pen_request_state": false,
                 "credit_line_usd_request_state": false,
                 "timestamp": timestamp,
                 "my_company_number": "0",
                 "daily_claim_pen_account": false,
                 "daily_claim_usd_account": false,
                 "pen_accoount_is_enabled": true,
                 "usd_accoount_is_enabled": true,
                 "user_is_enabled": true,
                 "pin_attempts": 0,
                 "phone_number": appDelegate.phoneNumber,
                 "register_date": dateStr,
                 "register_time": timeStr,
                 "lending_notification": false,
                 "app_identifier": "olb",
                 "main_activity": "none",
                 "user_type": "customer",
                ])
            
              
             
             self.scrollToPage(page: 5, animated: true)
             subViewTable.isHidden = true
             self.selectTablbl1.isHidden = true
             self.selectTablbl2.isHidden = true
             self.selectTablbl3.isHidden = true
             self.selectTablbl4.isHidden = true
             self.selectTablbl5.isHidden = true
             self.selectTablbl6.isHidden = false
            
            UserDefaults.standard.set(txtPin.text, forKey: "Pin")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
       
         }
         else
         {
             let alertView: UIAlertController = UIAlertController(title: title, message: "Debes completar tu informacion personal.", preferredStyle: .alert)
                 let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                 alertView.dismiss(animated: true, completion: nil)
             }
             alertView.addAction(alertAction)
             self.present(alertView, animated: true, completion: nil)
             return
         }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    @IBAction func updateValueDB(_ textField: UITextField) {
        
        var key =  String()
        var value = String()
        if(textField == txtNom)
        {
            key = "name"
            value = txtNom.text!
        }
        if(textField == txtApel)
        {
            key = "surname"
            value = txtApel.text!
        }
        if(textField == txtNumDoc)
        {
            key = "document_number"
            value = txtNumDoc.text!
        }
     
        if(textField == txtCorreo)
        {
            key = "email"
            value = txtCorreo.text!
        }
        if(textField == txtDirec)
        {
            key = "address"
            value = txtDirec.text!
        }
        if(textField == txtnombers)
        {
            key = "username"
            value = txtnombers.text!
        }
        if(textField == txtPin)
        {
              key = "pin"
              value = txtPin.text!
        }
        if(textField == txtPinConfirm)
        {
              key = "pin"
              value = txtPinConfirm.text!
        }
        Database.database().reference().child("Users").child(userID).updateChildValues([
            key: value ,
            "fullname": txtNom.text! + " " + txtApel.text!,
        ])
        
        //"nacionality":lblYear.text!,

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var str = String()
        if(textField == txtPin || textField == txtPinConfirm)
        {
            if textField == txtPin
            {
                str = txtPin.text!
            }
            if textField == txtPinConfirm
            {
                str = txtPinConfirm.text!
            }
            if string == "" {
                return true
            }
            if str.count < 4 {
                return true
            }
            return false

        }
          
            return true
        }
    
    @IBAction func buttonTesrms(_ sender: Any) {
        if(matchTerms == "false")
        {
            matchTerms = "true"
            buttonTermS.setImage(UIImage(named: "checkBlue"), for: .normal)
        }
        else
        {
            matchTerms = "false"
            buttonTermS.setImage(nil, for: .normal)
        }
        
    }
    
    
    /*******************************Work on Camera ***********************************/
    @IBOutlet var cameraSubView: UIView!
    
    @IBOutlet var buttonCaputre: UIButton!
    @IBOutlet weak var previewView: UIView?
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var videoDataOutput: AVCaptureVideoDataOutput?
    var videoDataOutputQueue: DispatchQueue?
    var captureDevice: AVCaptureDevice?
    var captureDeviceResolution: CGSize = CGSize()
    var rootLayer: CALayer?
    var detectionOverlayLayer: CALayer?
    var detectedFaceRectangleShapeLayer: CAShapeLayer?
    var detectedFaceLandmarksShapeLayer: CAShapeLayer?
    private var detectionRequests: [VNDetectFaceRectanglesRequest]?
    private var trackingRequests: [VNTrackObjectRequest]?
    lazy var sequenceRequestHandler = VNSequenceRequestHandler()
    var ciimage = CIImage()
    
  /*  func Start()  {
        self.session = self.setupAVCaptureSession()
        self.prepareVisionRequest()
        self.session?.startRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ensure that the interface stays locked in Portrait.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // Ensure that the interface stays locked in Portrait.
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: AVCapture Setup
    
    /// - Tag: CreateCaptureSession
   fileprivate func setupAVCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        do {
            let inputDevice = try self.configureFrontCamera(for: captureSession)
            self.configureVideoDataOutput(for: inputDevice.device, resolution: inputDevice.resolution, captureSession: captureSession)
            self.designatePreviewLayer(for: captureSession)
            return captureSession
        } catch let executionError as NSError {
            self.presentError(executionError)
        } catch {
            self.presentErrorAlert(message: "An unexpected failure has occured")
        }
        
        self.teardownAVCapture()
        
        return nil
    }
    
    /// - Tag: ConfigureDeviceResolution
    fileprivate func highestResolution420Format(for device: AVCaptureDevice) -> (format: AVCaptureDevice.Format, resolution: CGSize)? {
        var highestResolutionFormat: AVCaptureDevice.Format? = nil
        var highestResolutionDimensions = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let deviceFormat = format as AVCaptureDevice.Format
            
            let deviceFormatDescription = deviceFormat.formatDescription
            if CMFormatDescriptionGetMediaSubType(deviceFormatDescription) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange {
                let candidateDimensions = CMVideoFormatDescriptionGetDimensions(deviceFormatDescription)
                if (highestResolutionFormat == nil) || (candidateDimensions.width > highestResolutionDimensions.width) {
                    highestResolutionFormat = deviceFormat
                    highestResolutionDimensions = candidateDimensions
                }
            }
        }
        
        if highestResolutionFormat != nil {
            let resolution = CGSize(width: CGFloat(highestResolutionDimensions.width), height: CGFloat(highestResolutionDimensions.height))
            return (highestResolutionFormat!, resolution)
        }
        
        return nil
    }
    
    fileprivate func configureFrontCamera(for captureSession: AVCaptureSession) throws -> (device: AVCaptureDevice, resolution: CGSize) {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
        
        if let device = deviceDiscoverySession.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if captureSession.canAddInput(deviceInput) {
                    captureSession.addInput(deviceInput)
                }
                
                if let highestResolution = self.highestResolution420Format(for: device) {
                    try device.lockForConfiguration()
                    device.activeFormat = highestResolution.format
                    device.unlockForConfiguration()
                    
                    return (device, highestResolution.resolution)
                }
            }
        }
        
        throw NSError(domain: "ViewController", code: 1, userInfo: nil)
    }
    
    /// - Tag: CreateSerialDispatchQueue
    fileprivate func configureVideoDataOutput(for inputDevice: AVCaptureDevice, resolution: CGSize, captureSession: AVCaptureSession) {
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        // Create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured.
        // A serial dispatch queue must be used to guarantee that video frames will be delivered in order.
        let videoDataOutputQueue = DispatchQueue(label: "com.example.apple-samplecode.VisionFaceTrack")
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
        }
        
        videoDataOutput.connection(with: .video)?.isEnabled = true
        
        if let captureConnection = videoDataOutput.connection(with: AVMediaType.video) {
            if captureConnection.isCameraIntrinsicMatrixDeliverySupported {
                captureConnection.isCameraIntrinsicMatrixDeliveryEnabled = true
            }
        }
        
        self.videoDataOutput = videoDataOutput
        self.videoDataOutputQueue = videoDataOutputQueue
        
        self.captureDevice = inputDevice
        self.captureDeviceResolution = resolution
    }
    
    /// - Tag: DesignatePreviewLayer
    fileprivate func designatePreviewLayer(for captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = videoPreviewLayer
        
        videoPreviewLayer.name = "CameraPreview"
        videoPreviewLayer.backgroundColor = UIColor.black.cgColor
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        if let previewRootLayer = self.previewView?.layer {
            self.rootLayer = previewRootLayer
            
            previewRootLayer.masksToBounds = true
            videoPreviewLayer.frame = previewRootLayer.bounds
            previewRootLayer.addSublayer(videoPreviewLayer)
        }
    }
    
    // Removes infrastructure for AVCapture as part of cleanup.
    fileprivate func teardownAVCapture() {
        self.videoDataOutput = nil
        self.videoDataOutputQueue = nil
        
        if let previewLayer = self.previewLayer {
            previewLayer.removeFromSuperlayer()
            self.previewLayer = nil
        }
    }
    
    // MARK: Helper Methods for Error Presentation
    
    fileprivate func presentErrorAlert(withTitle title: String = "Unexpected Failure", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
    }
    
    fileprivate func presentError(_ error: NSError) {
        self.presentErrorAlert(withTitle: "Failed with error \(error.code)", message: error.localizedDescription)
    }
    
    // MARK: Helper Methods for Handling Device Orientation & EXIF
    
    fileprivate func radiansForDegrees(_ degrees: CGFloat) -> CGFloat {
        return CGFloat(Double(degrees) * Double.pi / 180.0)
    }
    
    func exifOrientationForDeviceOrientation(_ deviceOrientation: UIDeviceOrientation) -> CGImagePropertyOrientation {
        
        switch deviceOrientation {
        case .portraitUpsideDown:
            return .rightMirrored
            
        case .landscapeLeft:
            return .downMirrored
            
        case .landscapeRight:
            return .upMirrored
            
        default:
            return .leftMirrored
        }
    }
    
    func exifOrientationForCurrentDeviceOrientation() -> CGImagePropertyOrientation {
        return exifOrientationForDeviceOrientation(UIDevice.current.orientation)
    }
    
    // MARK: Performing Vision Requests
    
    /// - Tag: WriteCompletionHandler
    fileprivate func prepareVisionRequest() {
        
        //self.trackingRequests = []
        var requests = [VNTrackObjectRequest]()
        
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            
            if error != nil {
                print("FaceDetection error: \(String(describing: error)).")
            }
            
            guard let faceDetectionRequest = request as? VNDetectFaceRectanglesRequest,
                let results = faceDetectionRequest.results as? [VNFaceObservation] else {
                    return
            }
            DispatchQueue.main.async {
                // Add the observations to the tracking list
                for observation in results {
                    let faceTrackingRequest = VNTrackObjectRequest(detectedObjectObservation: observation)
                    requests.append(faceTrackingRequest)
                }
                self.trackingRequests = requests
            }
        })
        
        // Start with detection.  Find face, then track it.
        self.detectionRequests = [faceDetectionRequest]
        self.sequenceRequestHandler = VNSequenceRequestHandler()
        self.setupVisionDrawingLayers()
    }
    
    // MARK: Drawing Vision Observations
    
    fileprivate func setupVisionDrawingLayers() {
        let captureDeviceResolution = self.captureDeviceResolution
        
        let captureDeviceBounds = CGRect(x: 0,
                                         y: 0,
                                         width: captureDeviceResolution.width,
                                         height: captureDeviceResolution.height)
        
        let captureDeviceBoundsCenterPoint = CGPoint(x: captureDeviceBounds.midX,
                                                     y: captureDeviceBounds.midY)
        
        let normalizedCenterPoint = CGPoint(x: 0.5, y: 0.5)
        
        guard let rootLayer = self.rootLayer else {
            self.presentErrorAlert(message: "view was not property initialized")
            return
        }
        
        let overlayLayer = CALayer()
        overlayLayer.name = "DetectionOverlay"
        overlayLayer.masksToBounds = true
        overlayLayer.anchorPoint = normalizedCenterPoint
        overlayLayer.bounds = captureDeviceBounds
        overlayLayer.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        
        let faceRectangleShapeLayer = CAShapeLayer()
        faceRectangleShapeLayer.name = "RectangleOutlineLayer"
        faceRectangleShapeLayer.bounds = captureDeviceBounds
        faceRectangleShapeLayer.anchorPoint = normalizedCenterPoint
        faceRectangleShapeLayer.position = captureDeviceBoundsCenterPoint
        faceRectangleShapeLayer.fillColor = nil
        faceRectangleShapeLayer.strokeColor = UIColor.red.withAlphaComponent(0.7).cgColor
        faceRectangleShapeLayer.lineWidth = 5
        faceRectangleShapeLayer.shadowOpacity = 0.7
        faceRectangleShapeLayer.shadowRadius = 5
        
        let faceLandmarksShapeLayer = CAShapeLayer()
        faceLandmarksShapeLayer.name = "FaceLandmarksLayer"
        faceLandmarksShapeLayer.bounds = captureDeviceBounds
        faceLandmarksShapeLayer.anchorPoint = normalizedCenterPoint
        faceLandmarksShapeLayer.position = captureDeviceBoundsCenterPoint
        faceLandmarksShapeLayer.fillColor = nil
        faceLandmarksShapeLayer.strokeColor = UIColor.yellow.withAlphaComponent(0.7).cgColor
        faceLandmarksShapeLayer.lineWidth = 3
        faceLandmarksShapeLayer.shadowOpacity = 0.7
        faceLandmarksShapeLayer.shadowRadius = 5
        
        overlayLayer.addSublayer(faceRectangleShapeLayer)
       // faceRectangleShapeLayer.addSublayer(faceLandmarksShapeLayer)
        rootLayer.addSublayer(overlayLayer)
        
        self.detectionOverlayLayer = overlayLayer
        self.detectedFaceRectangleShapeLayer = faceRectangleShapeLayer
        self.detectedFaceLandmarksShapeLayer = faceLandmarksShapeLayer
        
        self.updateLayerGeometry()
    }
    
    fileprivate func updateLayerGeometry() {
        
        guard let overlayLayer = self.detectionOverlayLayer,
            let rootLayer = self.rootLayer,
            let previewLayer = self.previewLayer
            else {
            return
        }
        CATransaction.setValue(NSNumber(value: true), forKey: kCATransactionDisableActions)
        let videoPreviewRect = previewLayer.layerRectConverted(fromMetadataOutputRect: CGRect(x: 0, y: 0, width: 1, height: 1))
        var rotation: CGFloat
        var scaleX: CGFloat
        var scaleY: CGFloat
        // Rotate the layer into screen orientation.
        switch UIDevice.current.orientation {
        case .portraitUpsideDown:
            rotation = 180
            scaleX = videoPreviewRect.width / captureDeviceResolution.width
            scaleY = videoPreviewRect.height / captureDeviceResolution.height
            
        case .landscapeLeft:
            rotation = 90
            scaleX = videoPreviewRect.height / captureDeviceResolution.width
            scaleY = scaleX
            
        case .landscapeRight:
            rotation = -90
            scaleX = videoPreviewRect.height / captureDeviceResolution.width
            scaleY = scaleX
            
        default:
            rotation = 0
            scaleX = videoPreviewRect.width / captureDeviceResolution.width
            scaleY = videoPreviewRect.height / captureDeviceResolution.height
        }
        // Scale and mirror the image to ensure upright presentation.
        let affineTransform = CGAffineTransform(rotationAngle: radiansForDegrees(rotation))
            .scaledBy(x: scaleX, y: -scaleY)
        overlayLayer.setAffineTransform(affineTransform)
        // Cover entire screen UI.
        let rootLayerBounds = rootLayer.bounds
        overlayLayer.position = CGPoint(x: rootLayerBounds.midX, y: rootLayerBounds.midY)
    }
    
    fileprivate func addPoints(in landmarkRegion: VNFaceLandmarkRegion2D, to path: CGMutablePath, applying affineTransform: CGAffineTransform, closingWhenComplete closePath: Bool) {
        let pointCount = landmarkRegion.pointCount
        if pointCount > 1 {
            let points: [CGPoint] = landmarkRegion.normalizedPoints
            path.move(to: points[0], transform: affineTransform)
            path.addLines(between: points, transform: affineTransform)
            if closePath {
                path.addLine(to: points[0], transform: affineTransform)
                path.closeSubpath()
            }
        }
    }
    
    fileprivate func addIndicators(to faceRectanglePath: CGMutablePath, faceLandmarksPath: CGMutablePath, for faceObservation: VNFaceObservation) {
        let displaySize = self.captureDeviceResolution
        
        let faceBounds = VNImageRectForNormalizedRect(faceObservation.boundingBox, Int(displaySize.width), Int(displaySize.height))
        faceRectanglePath.addRect(faceBounds)
        
        if let landmarks = faceObservation.landmarks {
            // Landmarks are relative to -- and normalized within --- face bounds
            let affineTransform = CGAffineTransform(translationX: faceBounds.origin.x, y: faceBounds.origin.y)
                .scaledBy(x: faceBounds.size.width, y: faceBounds.size.height)
            
            // Treat eyebrows and lines as open-ended regions when drawing paths.
            let openLandmarkRegions: [VNFaceLandmarkRegion2D?] = [
                landmarks.leftEyebrow,
                landmarks.rightEyebrow,
                landmarks.faceContour,
                landmarks.noseCrest,
                landmarks.medianLine
            ]
            for openLandmarkRegion in openLandmarkRegions where openLandmarkRegion != nil {
                self.addPoints(in: openLandmarkRegion!, to: faceLandmarksPath, applying: affineTransform, closingWhenComplete: false)
            }
            
            // Draw eyes, lips, and nose as closed regions.
            let closedLandmarkRegions: [VNFaceLandmarkRegion2D?] = [
                landmarks.leftEye,
                landmarks.rightEye,
                landmarks.outerLips,
                landmarks.innerLips,
                landmarks.nose
            ]
            for closedLandmarkRegion in closedLandmarkRegions where closedLandmarkRegion != nil {
                self.addPoints(in: closedLandmarkRegion!, to: faceLandmarksPath, applying: affineTransform, closingWhenComplete: true)
            }
        }
    }
    
    /// - Tag: DrawPaths
    fileprivate func drawFaceObservations(_ faceObservations: [VNFaceObservation]) {
        guard let faceRectangleShapeLayer = self.detectedFaceRectangleShapeLayer,
            let faceLandmarksShapeLayer = self.detectedFaceLandmarksShapeLayer
            else {
            return
        }
        
        CATransaction.begin()
        
        CATransaction.setValue(NSNumber(value: true), forKey: kCATransactionDisableActions)
        
        let faceRectanglePath = CGMutablePath()
        let faceLandmarksPath = CGMutablePath()
        
        for faceObservation in faceObservations {
            self.addIndicators(to: faceRectanglePath,
                               faceLandmarksPath: faceLandmarksPath,
                               for: faceObservation)
        }
        
        faceRectangleShapeLayer.path = faceRectanglePath
        faceLandmarksShapeLayer.path = faceLandmarksPath
        
        self.updateLayerGeometry()
        
        CATransaction.commit()
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    // Handle delegate method callback on receiving a sample buffer.
  
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        

        
        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
             ciimage = CIImage(cvPixelBuffer: imageBuffer)
        
        
        var requestHandlerOptions: [VNImageOption: AnyObject] = [:]
        
        let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil)
        if cameraIntrinsicData != nil {
            requestHandlerOptions[VNImageOption.cameraIntrinsics] = cameraIntrinsicData
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to obtain a CVPixelBuffer for the current output frame.")
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
     
        
        let exifOrientation = self.exifOrientationForCurrentDeviceOrientation()
        
        
        
        guard let requests = self.trackingRequests, !requests.isEmpty else {
            // No tracking object detected, so perform initial detection
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            do {
                guard let detectRequests = self.detectionRequests else {
                    return
                }
                try imageRequestHandler.perform(detectRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceRectangleRequest: %@", error)
            }
            return
        }
        
        do {
            try self.sequenceRequestHandler.perform(requests,
                                                     on: pixelBuffer,
                                                     orientation: exifOrientation)
        } catch let error as NSError {
            NSLog("Failed to perform SequenceRequest: %@", error)
        }
        
        // Setup the next round of tracking.
        var newTrackingRequests = [VNTrackObjectRequest]()
        for trackingRequest in requests {
            
            guard let results = trackingRequest.results else {
                return
            }
            
            guard let observation = results[0] as? VNDetectedObjectObservation else {
                return
            }
            
            if !trackingRequest.isLastFrame {
                if observation.confidence > 0.3 {
                    self.detectedFaceRectangleShapeLayer?.isHidden = false
                    
                    trackingRequest.inputObservation = observation
                    captureImage = true
                    DispatchQueue.main.async {
                        self.buttonCaputre.setTitleColor(.systemGreen, for: .normal)
                    }
                } else {
                    self.detectedFaceRectangleShapeLayer?.isHidden = true
                    trackingRequest.isLastFrame = false
                    captureImage = false
                    DispatchQueue.main.async {
                        self.buttonCaputre.setTitleColor(.red, for: .normal)
                    }
                }
                newTrackingRequests.append(trackingRequest)
            }
        }
        self.trackingRequests = newTrackingRequests
        
        if newTrackingRequests.isEmpty {
            // Nothing to track, so abort.
            return
        }
        
        // Perform face landmark tracking on detected faces.
        var faceLandmarkRequests = [VNDetectFaceLandmarksRequest]()
        
        // Perform landmark detection on tracked faces.
        for trackingRequest in newTrackingRequests {
            
            let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request, error) in
                
                if error != nil {
                    print("FaceLandmarks error: \(String(describing: error)).")
                }
                
                guard let landmarksRequest = request as? VNDetectFaceLandmarksRequest,
                    let results = landmarksRequest.results as? [VNFaceObservation] else {
                        return
                }
                
                // Perform all UI updates (drawing) on the main queue, not the background queue on which this handler is being called.
                DispatchQueue.main.async {
                    self.drawFaceObservations(results)
                }
            })
            
            guard let trackingResults = trackingRequest.results else {
                return
            }
            
            guard let observation = trackingResults[0] as? VNDetectedObjectObservation else {
                return
            }
            let faceObservation = VNFaceObservation(boundingBox: observation.boundingBox)
            faceLandmarksRequest.inputFaceObservations = [faceObservation]
            
            // Continue to track detected facial landmarks.
            faceLandmarkRequests.append(faceLandmarksRequest)
            
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            
            do {
                try imageRequestHandler.perform(faceLandmarkRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceLandmarkRequest: %@", error)
            }
        }
    
    }
    */
    func convert(cmage:CIImage) -> UIImage
    {
         let context:CIContext = CIContext.init(options: nil)
         let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
         let image:UIImage = UIImage.init(cgImage: cgImage)
         DispatchQueue.main.async {
           // self.imgView.image = image
         }
         return image
    }
    
    @IBAction func getImage(_ sender: Any) {
        
        if(captureImage == true)
        {
           let image : UIImage = self.convert(cmage: ciimage)
           let rotatedImage = image.rotate(radians: .pi/2)
           imagePhoto.image = rotatedImage

           cameraSubView.isHidden = true
        }

    }
    @IBAction func backFromCamera(_ sender: Any) {
        
        cameraSubView.isHidden = true
    }
}
extension UIView {

  // OUTPUT 1
    func dropShadow1(offsetX: CGFloat, offsetY: CGFloat, color: UIColor, opacity: Float, radius: CGFloat, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowRadius = radius
       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension RegisterViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        countryCode = dialCode

        let x =  picker.getFlag(countryCode: code)
        imgCountry.image = x

        if(code == "US")
        {
            imgCountry.image = UIImage(named: "US1.png")
        }
        countryName =  picker.getCountryName(countryCode: code)!
        lblCountry.text = countryName
        Database.database().reference().child("Users").child(userID).updateChildValues([
      
            "nacionality": countryName
        ])
       
        let xxx =  picker.getDialCode(countryCode: code)
    }
}



extension RegisterViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput,didOutput sampleBuffer: CMSampleBuffer,from connection: AVCaptureConnection) {

        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {

            print("Failed to get image buffer from sample buffer.")

            return

        }

        let ciImage = CIImage(cvPixelBuffer: imageBuffer)

        let context = CIContext(options: nil)

        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {

            return

        }

        DispatchQueue.main.async {
            let rotatedImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
            //self.imagePhoto.image = rotatedImage

        }

        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
        do {
            try sequenceHandler.perform(
                [detectFaceRequest],
                on: imageBuffer,
                orientation: .leftMirrored)

        } catch {
            print(error.localizedDescription)

        }

    }

}



func detectedFace(request: VNRequest, error: Error?) {

    guard let results = request.results as? [VNFaceObservation], let _ = results.first else {

        DispatchQueue.main.async {
            print("no imgage")
            //self.captureImage = false
        }
        return
    }
    print("no imgage")
    //self.captureImage = true
}


