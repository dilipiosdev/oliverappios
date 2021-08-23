//
//  NegociosRegisterViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit
import Firebase
import AlamofireImage
import FirebaseStorage
import JGProgressHUD
import Alamofire
import Photos

class NegociosRegisterViewController: UIViewController, UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var subViewMainTitle: UIView!
    @IBOutlet var subView: UIView!
    var scrollViewPaging = UIScrollView()
    
    
    @IBOutlet var subViewImageMain: UIView!
    @IBOutlet var subViewMain2: UIView!
    @IBOutlet var subViewImageMain3: UIView!
    @IBOutlet var subViewMain4: UIView!
    @IBOutlet var subViewMain5: UIView!
    
    @IBOutlet var subViewTable: UIView!
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    var currentYear = Int()

    var terms1 = Bool()
    var terms2 = Bool()

    @IBOutlet var subViewImageConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight: NSLayoutConstraint!
    
    @IBOutlet var subViewImageConstWidth2: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight2: NSLayoutConstraint!
    
    @IBOutlet var subViewImageConstWidth3: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight3: NSLayoutConstraint!
    
    @IBOutlet var subViewImageConstWidth4: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight4: NSLayoutConstraint!
    
    @IBOutlet var subViewImageConstWidth5: NSLayoutConstraint!
    @IBOutlet var subViewImageConstantHeight5: NSLayoutConstraint!
    
    @IBOutlet var subViewMainTableConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewMainTableConstantHeight: NSLayoutConstraint!
    var matchImageView = String()
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    
    var register1 = Bool()
    var register2 = Bool()
    var register3 = Bool()
    var register4 = Bool()
    var register5 = Bool()
    
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var localArray = Array<Any>()
    var countryArray = Array<Any>()
    var provincesArray = Array<Any>()
    var districsArray = Array<Any>()
    var activatedArray = Array<Any>()

    
    @IBOutlet var selectTablbl1: UILabel!
    @IBOutlet var selectTablbl2: UILabel!
    @IBOutlet var selectTablbl3: UILabel!
    @IBOutlet var selectTablbl4: UILabel!
    @IBOutlet var selectTablbl5: UILabel!
    /*****************************Main Sub View 1 **********************/
    @IBOutlet var subViewTop: UIView!
    @IBOutlet var subViewImage: UIView!
    @IBOutlet var subViewBottom: UIView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imgUpload1: UIImageView!
    @IBOutlet var lblUpload1: UILabel!
    @IBOutlet var btnCamera1: UIButton!
    @IBOutlet var btnGallery1: UIButton!
    
    /*****************************Main Sub View 2 **********************/
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    var selectCountry = Dictionary<String,Any>()
    var selectProvinces = Dictionary<String,Any>()
    var selectDistrics = Dictionary<String,Any>()
    @IBOutlet var txtDepartmento: UITextField!
    @IBOutlet var txtProv: UITextField!
    @IBOutlet var subViewAddressTop: UIView!
    @IBOutlet var subViewAddressBottom: UIView!
    @IBOutlet var txtDist: UITextField!
    
    @IBOutlet var txtCommericalName: UITextField!
    @IBOutlet var txtCompantydocumentNumber: UITextField!
    @IBOutlet var txtActivated: UITextField!
    
    
    
    /*****************************Main Sub View 3 **********************/
    @IBOutlet var subViewTop3: UIView!
    @IBOutlet var subViewImage3: UIView!
    @IBOutlet var subViewBottom3: UIView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imgUpload3: UIImageView!
    @IBOutlet var lblUpload3: UILabel!
    @IBOutlet var btnCamera3: UIButton!
    @IBOutlet var btnGallery3: UIButton!

    /*****************************Main Sub View 4 **********************/
   
    @IBOutlet var btnProduct: UIButton!
    @IBOutlet var btnService: UIButton!
    @IBOutlet var btnPrecio: UIButton!
    @IBOutlet var btnCalidad: UIButton!
    @IBOutlet var btnServicePost: UIButton!
    @IBOutlet var subViewTop4: UIView!
    @IBOutlet var btnTerm1: UIButton!
    
    @IBOutlet var btnTerm2: UIButton!
    /*****************************Main Sub View 5 **********************/
    @IBOutlet var subViewRegister60: UIView!
    @IBOutlet var subViewRegister61: UIView!
    @IBOutlet var subViewRegister62: UIView!
    @IBOutlet var subViewRegister63: UIView!
    @IBOutlet var subViewRegister64: UIView!
    
    @IBOutlet var lblRegister1: UILabel!
    @IBOutlet var lblRegister2: UILabel!
    @IBOutlet var lblRegister3: UILabel!
    @IBOutlet var lblRegister4: UILabel!


    @IBOutlet var imgComplet1: UIImageView!
    @IBOutlet var imgComplet2: UIImageView!
    @IBOutlet var imgComplet3: UIImageView!
    @IBOutlet var imgComplet4: UIImageView!
    var image1URl = String()
    var image2URl = String()
    var companyOutPUT = String()
    var companyService = String()
    let userGetRef = Database.database().reference().child("Users/\(appDelegate.userID)").child("Company Registration")
    
    var timeStampString = String()
    var timeStr = String()
    override func viewDidLoad() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateStr = formatter.string(from: date)
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        timeStr = String(format: "%d:%d:%d", components.hour!,components.minute!,components.second!)
        let timeStrSave = String(format: "%d%d%d%%d%d%d%", components.year!,components.month!,components.day!,components.hour!,components.minute!,components.second!)
        let timestamp = NSDate().timeIntervalSince1970
        timeStampString = String(format: "%.f", timestamp)
        /******************** Register Table Cell ****************************/
        manageSubView()
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        super.viewDidLoad()
        subViewTable.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGrayGroundColor())

        selectTablbl1.isHidden = false
        selectTablbl2.isHidden = true
        selectTablbl3.isHidden = true
        selectTablbl4.isHidden = true
        selectTablbl5.isHidden = true
        
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
        getImagefromFireBase()
        getImagefromFireBaseFichars()
        getDataFromFireBase()
        
         terms1 = false
         terms2 = false
    }
    
    /*****************************GET Data from fire base **************************/
    func getImagefromFireBase() -> Void
    {
        /***************Register 1 Get Data ********************/
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       // lblRegister1.text = "A la espera de tu footo de perfil."
       // lblRegister2.textColor = .gray
       
        userGetRef.observe(.value) {  (snapshot) in
        if let dict = snapshot.value as? [String: Any],
        let userImage = dict["company_profileimage"] as? String
        {
          self.image1URl = userImage
          self.lblUpload1.text = "A la espera de la foto del negocio"
          self.lblUpload1.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          if(userImage.count > 0)
          {
            self.lblUpload1.text = "Foto subida con exito."
            self.lblUpload1.textColor = #colorLiteral(red: 0.001631148917, green: 1, blue: 0.4867287994, alpha: 1)
            self.imgUpload1.image = UIImage(named: "checkBlue")

            let image:UIImage = UIImage(named: "back")!
            let url = NSURL(string: userImage)
            self.imageView1.af.setImage(withURL: url! as URL, placeholderImage: image)
            self.register1 = true
            self.lblRegister1.text = "Foto subida con exito."
            self.lblRegister1.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.imgComplet1.image = UIImage(named: "checkBlue")
            
            hud.dismiss()
          }
        }
        else
        {
            self.lblUpload1.text = "A la espera de la foto del negocio"
            self.lblUpload1.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            hud.dismiss()
        }
       }
    }
    func getImagefromFireBaseFichars() -> Void
    {
        /***************Register 3 Get Data ********************/
        self.lblUpload3.text = "A la espera de tu Ficha RUC."
        self.lblUpload3.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        self.lblUpload3.text = "A la espera de tu Ficha RUC."
        self.lblUpload3.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
      
        userGetRef.observe(.value) {  (snapshot) in
        if let dict = snapshot.value as? [String: Any],
        let userImage = dict["ruc_file"] as? String
        {
          if(userImage.count > 0)
          {
            self.image2URl = userImage

            self.lblUpload3.text = "Archivo cargado con exito."
            self.lblUpload3.textColor = #colorLiteral(red: 0.001631148917, green: 1, blue: 0.4867287994, alpha: 1)
            self.imgUpload3.image = UIImage(named: "checkBlue")

            let image:UIImage = UIImage(named: "back")!
            let url = NSURL(string: userImage)
            self.imageView3.af.setImage(withURL: url! as URL, placeholderImage: image)
            self.register3 = true
            self.lblRegister3.text = "Archivo cargado con exito."
            self.lblRegister3.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.imgComplet3.image = UIImage(named: "checkBlue")
             hud.dismiss()
          }
        }
        else
        {
            self.lblUpload3.text = "A la espera de tu Ficha RUC."
            self.lblUpload3.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            hud.dismiss()
        }
       }
    }
    func getDataFromFireBase() -> Void {
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        userGetRef.observe(.value) {  (snapshot) in
        if let dict1 = snapshot.value as? [String: Any]
         {
            /***************Register 2 Get Data ********************/
            hud.dismiss()
            self.txtCommericalName.text = dict1["commercial_name"] as? String
            self.txtCompantydocumentNumber.text = dict1["company_document_number"] as? String
            self.lblDate.text = dict1["company_bth_day"] as? String
            self.lblMonth.text = dict1["company_bth_month"] as? String
            self.lblYear.text = dict1["company_bth_year"] as? String
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
            self.txtDepartmento.text = dict1["department"] as? String
            self.txtProv.text = dict1["province"] as? String
            self.txtDist.text = dict1["district"] as? String
            self.txtActivated.text = dict1["economic_activity"] as? String

            let strCompanyOutput = dict1["comapny_output"] as? String
            if(strCompanyOutput == "Productos")
            {
                self.btnProduct.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                self.btnService.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            }
            else if(strCompanyOutput == "Servicios")
            {
                self.btnProduct.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                self.btnService.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            let strCompanyValue = dict1["company_value"] as? String
            if(strCompanyValue == "Productos")
            {
                self.btnPrecio.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                self.btnCalidad.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.btnServicePost.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else if(strCompanyValue == "Servicios")
            {
                self.btnPrecio.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.btnCalidad.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                self.btnServicePost.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else if(strCompanyValue == "Servicio Post Venta")
            {
                self.btnPrecio.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.btnCalidad.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.btnServicePost.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
            
          
    /********************Register 3 Get Data*****************************/
            
        if(strCompanyOutput?.isEmpty == true || strCompanyValue?.isEmpty == true)
        {
            self.register4 = false
            self.lblRegister4.text = "Falta completar datos."
            self.lblRegister4.textColor = .red
            self.imgComplet4.image = UIImage(named: "time")
        }
        else
        {
            self.register4 = true
            self.lblRegister4.text = "Datos adicionales completado."
            self.lblRegister4.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.imgComplet4.image = UIImage(named: "checkBlue")
        }
            
           
       /* self.txtCorreo.text = dict1["email"] as? String
            self.txtDepartmento.text = dict1["department"] as? String
         
            
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
            */
         }
        else
        {
            hud.dismiss()
        }
       }
    }
    override func viewDidLayoutSubviews() {
        subViewTop.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewImage.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewBottom.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        subViewTop3.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewImage3.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewBottom3.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewAddressTop.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewAddressBottom.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewTop4.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        subViewRegister60.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister61.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister62.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister63.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        subViewRegister64.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
  
    }
    
    func manageSubView() -> Void {
        let obj = UpdateCornerRadious()
        obj.lableCornerRadious5(labelArray: [])
        obj.lableCornerRadious14(labelArray: [lbl1,lbl2,lbl3,lbl4])
        obj.buttonCornerRadious5(buttonArray: [btnCamera1,btnCamera3,btnGallery1,btnGallery3])
        obj.buttonCornerRadious13WithColor(buttonArray: [btnProduct,btnService,btnPrecio,btnCalidad,btnServicePost])
        obj.buttonCornerRadious15WithColor(buttonArray: [btnTerm1,btnTerm2])
        obj.subViewCornerRadious5(subViewArray: [subViewImage,subViewImage3,subViewRegister60,subViewRegister61,subViewRegister62,subViewRegister63,subViewRegister64])
        obj.subViewCornerRadious10(subViewArray: [subViewTop,subViewImage,subViewBottom,subViewAddressTop,subViewAddressBottom,subViewTop3,subViewImage3,subViewBottom3,subViewTop4])



        scrollViewPaging = UIScrollView(frame: CGRect(x: 0 , y: subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)))
        scrollViewPaging.isPagingEnabled = true
        scrollViewPaging.backgroundColor = .white
        scrollViewPaging.showsVerticalScrollIndicator = false
        scrollViewPaging.showsHorizontalScrollIndicator = false
        scrollViewPaging.delegate = self
        view.addSubview(scrollViewPaging)
        
        let numberOfPages :Int = 4
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
              
                subViewMain2.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
                subViewImageConstWidth2.constant = UIScreen.main.bounds.size.width
                subViewImageConstantHeight2.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewMain2.clipsToBounds = true
                view.addSubview(subViewMain2)

            }
            if(i == 2)
            {
                subViewImageMain3.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
                subViewImageConstWidth3.constant = UIScreen.main.bounds.size.width
                subViewImageConstantHeight3.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
                subViewImageMain3.clipsToBounds = true
                view.addSubview(subViewImageMain3)

            }
           if(i == 3)
           {
             subViewMain4.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
             subViewImageConstWidth4.constant = UIScreen.main.bounds.size.width
             subViewImageConstantHeight4.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
            subViewMain4.clipsToBounds = true
             view.addSubview(subViewMain4)
           }
           if(i == 4)
           {
             subViewMain5.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
             subViewImageConstWidth5.constant = UIScreen.main.bounds.size.width
             subViewImageConstantHeight5.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
            subViewMain5.clipsToBounds = true
            view.addSubview(subViewMain5)
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
    
    
    @IBAction func button1(_ sender: Any) {
        self.scrollToPage(page: 0, animated: true)
        


    }
   
    @IBAction func button2(_ sender: Any) {
        self.scrollToPage(page: 1, animated: true)
       

    }
    @IBAction func button3(_ sender: Any) {
        self.scrollToPage(page: 2, animated: true)
    


    }
    
    @IBAction func button4(_ sender: Any) {
        self.scrollToPage(page: 3, animated: true)

    }
    @IBAction func button5(_ sender: Any) {
        self.scrollToPage(page: 4, animated: true)
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
 
    func hideBottomLbl(index:Int) -> Void {
        self.selectTablbl1.isHidden = true
        self.selectTablbl2.isHidden = true
        self.selectTablbl3.isHidden = true
        self.selectTablbl4.isHidden = true
        self.selectTablbl5.isHidden = true
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
    }
    @IBAction func buttonCamera1(_ sender: Any) {
        matchImageView = "image1"
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
    }
    @IBAction func buttonImage1(_ sender: Any) {
        matchImageView = "image1"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func buttonCamera3(_ sender: Any) {
        matchImageView = "image3"
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
       
    }
    @IBAction func buttonImage3(_ sender: Any) {
        matchImageView = "image3"
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
    }
    
    
    /************************* Image Picker Delegate ****************************/
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
      {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if(matchImageView == "image1")
        {
            imageView1.image = chosenImage
            uploadImageCompany(image: imageView1.image!, Key: "company_profileimage", StorageKey: "Company Profile Images/",match: "image1")

        }
        if(matchImageView == "image3")
        {
          imageView3.image = chosenImage
            uploadImageCompany(image: imageView3.image!, Key: "ruc_file", StorageKey: "Fichas RUC/", match: "image3")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadImageCompany(image: UIImage,Key:String, StorageKey: String, match: String) -> Void {
        
        
        let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
        let dateStr = formatter.string(from: date)
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStrSave = String(format: "%d%d%d%%d%d%d%", components.year!,components.month!,components.day!,components.hour!,components.minute!,components.second!)
        
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        var data = NSData()
        data = image.jpegData(compressionQuality: 0.8)! as NSData
        if(data.count > 0)
        {
            let storge = Storage.storage().reference().child(Key).child(appDelegate.userID + timeStampString)
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
                Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("Company Registration").updateChildValues([Key: urlText])
                        print("Successfull")
                if(match == "image1")
                {
                 self.scrollToPage(page: 1, animated: true)
                 self.subViewTable.isHidden = true
                 self.selectTablbl1.isHidden = false
                 self.selectTablbl2.isHidden = true
                 self.selectTablbl3.isHidden = true
                 self.selectTablbl4.isHidden = true
                 self.selectTablbl5.isHidden = true
                }
                else
                {
                    self.scrollToPage(page: 3, animated: true)
                    self.subViewTable.isHidden = true
                    self.selectTablbl1.isHidden = true
                    self.selectTablbl2.isHidden = true
                    self.selectTablbl3.isHidden = false
                    self.selectTablbl4.isHidden = true
                    self.selectTablbl5.isHidden = true
                }
               }
             })
          }
        }
      }
      else
      {
         hud.dismiss()
         let alertView: UIAlertController = UIAlertController(title: title, message: "Por favor seleccione imagen.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertView.dismiss(animated: true, completion: nil)
         }
         alertView.addAction(alertAction)
         self.present(alertView, animated: true, completion: nil)
      }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated:  true, completion: nil)
    }
    
    
    
    @IBAction func buttonDate(_ sender: Any) {
        txtSearch.text = ""
        localArray = daysArray
        matchTable = "Date"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonMonth(_ sender: Any) {
      //  txtSearch.text = ""
        localArray = monthArray
        matchTable = "Month"
        subViewTable.isHidden = false
        tbl.reloadData()


    }
    @IBAction func buttonYear(_ sender: Any) {
       // txtSearch.text = ""
        localArray = yearArray
        matchTable = "Year"
        subViewTable.isHidden = false
        tbl.reloadData()


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
        else if (matchTable == "Activated")
        {
            return activatedArray.count

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
        else if (matchTable == "Activated")
        {
          cell.lblText.text = String(format: "%@",   activatedArray[indexPath.row] as! String)
        }
      
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(matchTable == "Date")
        {
            subViewTable.isHidden = true
            lblDate.text = daysArray[indexPath.row] as? String
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                 "company_bth_day": lblDate.text!,
            ])
            return
        }
        if(matchTable == "Month")
        {
            subViewTable.isHidden = true
            lblMonth.text = monthArray[indexPath.row] as? String
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                 "company_bth_month": lblMonth.text!,
            ])
            return
        }
        if(matchTable == "Year")
        {
            
            subViewTable.isHidden = true
            lblYear.text = String(format: "%@",  yearArray[indexPath.row] as! String)
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                 "company_bth_year": lblYear.text!,
            ])
            return
        }
        if(matchTable == "Country")
        {
         subViewTable.isHidden = true
         selectCountry = countryArray[indexPath.row] as! Dictionary<String,Any>
         txtDepartmento.text = String(format: "%@", selectCountry["nombre_ubigeo"] as! String)
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
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
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
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
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                 "district": txtDist.text!,
            ])
            return
        }
       if(matchTable == "Activated")
       {
         subViewTable.isHidden = true
         txtActivated.text = String(format: "%@",   activatedArray[indexPath.row] as! String)
         Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
             "economic_activity": txtActivated.text!,
         ])
         return
    }
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
    
    @IBAction func buttonActivated(_ sender: Any) {
        txtActivated.text = ""
        activatedArray.removeAll()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Economic Activities/")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as! Dictionary<String,Any>)
            if let activated = snapshot.value as? Dictionary<String,Any>
            {
                self.activatedArray.removeAll()
                for (key, value) in activated {
                    let dict = activated[key] as! Dictionary<String,Any>
                    self.activatedArray.append(dict["name"] as! String)
                }
                hud.dismiss()
                print(activated)
                self.matchTable = "Activated"
               // self.activatedArray = activated
                self.subViewTable.isHidden = false
                self.localArray = self.activatedArray
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
        
     
        tbl.reloadData()
   }
 
    
    
    @IBAction func updateValueDB(_ textField: UITextField) {
        
        var key =  String()
        var value = String()
        if(textField == txtCommericalName)
        {
            key = "commercial_name"
            value = txtCommericalName.text ?? "-"
        }
        if(textField == txtCompantydocumentNumber)
        {
            key = "company_document_number"
            value = txtCompantydocumentNumber.text ?? "-"
        }
   
        Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
            key: value
        ])
        

    }
    
    /********************SUB VIEW MAIN 4 ******/
    @IBAction func btnCompanyOutPut(_ sender: UIButton) {
        if(sender.tag == 1)
        {
            self.btnProduct.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            self.btnService.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            companyOutPUT = "Productos"
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                "comapny_output": "Productos"
                
            ])
        }
        if(sender.tag == 2)
        {
            self.btnProduct.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnService.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            companyOutPUT = "Precio"

            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                "comapny_output": "Precio"
            ])
        }
    }
    @IBAction func btnCompanyValue(_ sender: UIButton) {
        if(sender.tag == 1)
        {
            self.btnPrecio.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            self.btnCalidad.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnServicePost.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            companyService = "Calidad"
            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                "company_value": "Calidad"
            ])
        }
        if(sender.tag == 2)
        {
            self.btnPrecio.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnCalidad.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnServicePost.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            companyService = "Servicios"

            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                "company_value": "Servicios"
            ])
        }
        if(sender.tag == 3)
        {
            self.btnPrecio.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.btnCalidad.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            self.btnServicePost.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            companyService = "Servicio Post Venta"

            Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").updateChildValues([
                "company_value": "Servicio Post Venta"
            ])
        }
    }
    
    
    @IBAction func btnTerm1(_ sender: Any) {
        terms1 = true
        btnTerm1.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    }
    
    @IBAction func btnTerm2(_ sender: Any) {
        terms2 = true
        btnTerm2.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    }
    
    
    
    
    @IBAction func buttonContinue1(_ sender: Any) {
        self.scrollToPage(page: 1, animated: true)
    }
    @IBAction func buttonContinue2(_ sender: Any) {
        self.scrollToPage(page: 2, animated: true)
    }
    @IBAction func buttonContinue3(_ sender: Any) {
        self.scrollToPage(page: 3, animated: true)
    }
    @IBAction func buttonContinue4(_ sender: Any) {
        self.scrollToPage(page: 4, animated: true)
    }
    @IBAction func buttonContinue5(_ sender: Any) {
        
        register6Main()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
          let UrlStr = "https://api.sunat.clould/ruc/company_document_number/" + txtCompantydocumentNumber.text!
          AF.request(UrlStr, method:.get, parameters: nil).validate().responseJSON { (response) in
            hud.dismiss()
          if (response.response != nil)
          {
             let dict =  response.value as? Dictionary<String,Any>
             if (dict?.isEmpty == false)
             {
                 let dateStrLocal = String(format: "%@-%@%@-%@", self.lblYear.text!,self.lblYear.text!,self.lblMonth.text!.uppercased(),self.lblDate.text!)
                
                
                 let dateStr = String(format: "%@ %@ %@", dict?["fecha_inscripcion"] as? String ?? "-")
                
                let razonSocailLocal = self.txtCommericalName.text!
                let razonSocailStr = String(format: "%@ %@ %@", dict?["razon_social"] as? String ?? "none")
                
              if((dateStr.uppercased() ==  dateStrLocal) && (razonSocailLocal.uppercased() ==  razonSocailStr))
              {
                self.register2 = true
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
    
    func register6Main() -> Void {
        
        if(terms1 == false || terms2 == false)
        {
            let alertView: UIAlertController = UIAlertController(title: "", message: "Acepte los términos y condiciones.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        //&& register2 == true
        if(register1 == true  && register3 == true && register4 == true )
         {
             let date = Date()
                   let formatter = DateFormatter()
                   formatter.dateFormat = "dd-MM-yyyy"
             let dateStr = formatter.string(from: date)
             let calender = Calendar.current
             let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            
             let timeStrSave = String(format: "%d%d%d%%d%d%d%", components.year!,components.month!,components.day!,components.hour!,components.minute!,components.second!)
            
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
                      
                        Database.database().reference().child("My Companies").child("\(appDelegate.userID)\(self.timeStampString)").updateChildValues(["qr_code_image": urlText])
                           self.addInCompamyList()
                        }
                     })
                  }
                }
             }
            
             
         }
         else
         {
             let alertView: UIAlertController = UIAlertController(title: title, message: "Debes completar tu informacion.", preferredStyle: .alert)
                 let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                 alertView.dismiss(animated: true, completion: nil)
             }
             alertView.addAction(alertAction)
             self.present(alertView, animated: true, completion: nil)
             return
         }
    }


    func addInCompamyList() -> Void {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateStr = formatter.string(from: date)
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStr = String(format: "%d:%d:%d", components.hour!,components.minute!,components.second!)
   
        
        Database.database().reference().child("My Companies").child("\(appDelegate.userID)\(timeStampString)").updateChildValues([
             "company_image" : image1URl,
             "ruc_file" : image2URl,
             "company_name" : txtCommericalName.text ?? "none",
             "company_ruc" : txtCompantydocumentNumber.text ?? "none",
             "company_bth_day": lblDate.text!,
             "company_bth_month": lblMonth.text!,
             "company_bth_year": lblYear.text!,
             "department": txtDepartmento.text!,
             "province": txtProv.text!,
             "district": txtDist.text!,
             "comapny_output": companyOutPUT,
             "companyService" : companyService,
             "date": dateStr,
             "time": timeStr,
             "company_verification": "progress",
             "current_account_pen": "0.00",
             "current_account_usd": "0.00",
             "pen_account_enabled": "true",
             "usd_account_enabled": "true",
             "company_condition": "Empresa Formal",
             "credit_line_pen": "false",
             "credit_line_pen_available": "0.00",
            "credit_line_pen_tcea":  "800.00",
             "credit_line_pen_total": "0.00",
             "credit_line_pen_used": "0.00",
             "credit_line_usd": "false",
             "credit_line_usd_available": "0.00",
             "credit_line_usd_tcea": "800.00",
             "credit_line_usd_total": "0.00",
             "credit_line_usd_used": "0.00",
             "credit_risk_param": "0.00",
             "credit_score": "5",
             "credit_line_pen_request_state": "false",
             "credit_line_usd_request_state": "false",
             "pen_accoount_is_enabled": "true",
             "usd_accoount_is_enabled": "true",
             "is_financcial_institution": "false",
             "customer_rating": "0.00",
             "abvo_store_state": "none",
             "uid" : appDelegate.userID
            ])
        let ref =  Database.database().reference().child("Users").child(appDelegate.userID).child("Company Registration").removeValue()

        self.navigationController?.popViewController(animated: true)
    }
}
