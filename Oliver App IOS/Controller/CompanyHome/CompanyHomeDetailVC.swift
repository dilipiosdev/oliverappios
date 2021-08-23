//
//  CompanyHomeDetailVC.swift
//  Oliver App IOS
//
//  Created by Meena on 05/12/20.
//

import UIKit
import Firebase
class CompanyHomeDetailVC: UIViewController,UIScrollViewDelegate {
    
    var colletcionTitleArray = Array<Any>()
    var colletcionImageArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    @IBOutlet weak var imgCompany: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var scrollViewPaging = UIScrollView()
    @IBOutlet weak var subViewMainTitle: UIView!
    

    @IBOutlet weak var subView: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    
    @IBOutlet weak var lblSelect1: UILabel!
    @IBOutlet weak var lblSelect2: UILabel!
    @IBOutlet weak var lblSelect3: UILabel!
    
    @IBOutlet weak var subViewTop: UIView!
    @IBOutlet weak var subViewBottom: UIView!
    @IBOutlet weak var lblExpair: UILabel!
    

    @IBOutlet var subViewView1ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewView1ConstantHeight: NSLayoutConstraint!
    @IBOutlet var subViewView2ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewView2ConstantHeight: NSLayoutConstraint!
    @IBOutlet var subViewView3ConstWidth: NSLayoutConstraint!
    @IBOutlet var subViewView3ConstantHeight: NSLayoutConstraint!
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
    
        manageView()
    }
    func manageView() -> Void {
        
        let obj = UpdateCornerRadious()
        obj.subViewCornerRadious5(subViewArray: [subViewTop,subViewBottom])

        lblSelect1.isHidden = false
        lblSelect2.isHidden = true
        lblSelect3.isHidden = true
        scrollViewPaging = UIScrollView(frame: CGRect(x: 0 , y: subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)))
          
        scrollViewPaging.isPagingEnabled = true
        scrollViewPaging.backgroundColor = .white
        scrollViewPaging.showsVerticalScrollIndicator = false
        scrollViewPaging.showsHorizontalScrollIndicator = false
        scrollViewPaging.delegate = self
         view.addSubview(scrollViewPaging)
         let numberOfPages :Int = 2
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
               view1.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
               subViewView1ConstWidth.constant = UIScreen.main.bounds.size.width
           
               subViewView1ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
               view1.clipsToBounds = true
               view.addSubview(view1)

             }
             if(i == 1)
             {
               view2.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
               subViewView2ConstWidth.constant = UIScreen.main.bounds.size.width
                subViewView2ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
               view2.clipsToBounds = true
               view.addSubview(view2)
               view.backgroundColor = .red

             }
             if(i == 2)
             {
               view3.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height - 20)
               subViewView3ConstWidth.constant = UIScreen.main.bounds.size.width
               subViewView3ConstantHeight.constant = UIScreen.main.bounds.size.height - (subViewMainTitle.frame.size.height + subViewMainTitle.frame.origin.y + 20)
               view3.clipsToBounds = true
               view.addSubview(view3)
            }
            view.clipsToBounds = true
            scrollViewPaging.addSubview(view)
            x = view.frame.origin.x + viewWidth + padding
        }
        scrollViewPaging.contentSize = CGSize(width:x+padding, height:scrollViewPaging.frame.size.height)
        
        
        
        if let billListArray = companyDetailDict.childSnapshot(forPath: "Achievements").children.allObjects as? Array<Any>
        {
            var score = String()
            score = "0"
            var total = Int()

            for i in 0 ..< billListArray.count {
                let obj = billListArray[i] as! DataSnapshot
                
                score  = obj.childSnapshot(forPath: "score").value as? String ?? "0"
               
                total = total + Int(score)!
                lblExpair.text = String(format: "EXP: %d", total)
            }
        }
        
        
        
        let companyImage = companyDetailDict.childSnapshot(forPath: "company_image").value as? String ?? ""
        let image:UIImage = UIImage(named: "back")!
        let url = NSURL(string: companyImage)
        imgCompany.af.setImage(withURL: url! as URL, placeholderImage: image)
        imgCompany.layer.cornerRadius = 42
        lblCompanyName.text = companyDetailDict.childSnapshot(forPath: "company_name").value as? String ?? ""
        
         let dateStr = companyDetailDict.childSnapshot(forPath: "date").value as? String ?? ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM yyyy"

        let date: NSDate? = dateFormatterGet.date(from: dateStr) as NSDate?
        lblDate.text = dateFormatterPrint.string(from: date! as Date)
       

        self.navigationController?.navigationBar.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGrayGroundColor())
        
        colletcionTitleArray = ["Que es un moddelo de gestion y para que sirve","Informacion del Usuario","Identificacion de Oportunidades de Negocios","Propuestas de Valor","Modelos de Negocio","Nuevos Productos o Servicios", "Comercializacion","Ventas","Logistica/ Abastecimiento","Produccion/Operaciones","Gestion de Personas","Normatividad y Responsabilidad Social", "Gestion Financiera"]
        colletcionImageArray = ["home11","home22","home33","home44","home55","home66","home77","home88","home99","home100","home101","home102", "home103"]
        collView.reloadData()
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
    /******************************View Shadow ********************/
     override func viewDidLayoutSubviews() {
         subViewTop.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
         subViewBottom.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
    @IBAction func tabClicked(_ sender: UIButton) {
        if sender.tag == 1{
           hideBottomLbl(index: 0)
           scrollToPage(page: 0, animated: true)
        }else if sender.tag == 2{
            hideBottomLbl(index: 1)
            scrollToPage(page: 1, animated: true)
        }else if sender.tag == 3{
           hideBottomLbl(index: 2)
           scrollToPage(page: 2, animated: true)
        }
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func hideBottomLbl(index:Int) -> Void {
     self.lblSelect1.isHidden = true
     self.lblSelect2.isHidden = true
     self.lblSelect3.isHidden = true
     if(index == 0)
     {
      self.lblSelect1.isHidden = false
     }
     if(index == 1)
     {
      self.lblSelect2.isHidden = false
     }
     if(index == 2)
     {
      self.lblSelect3.isHidden = false
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
}

//MARK:- CollectionView Methods
extension CompanyHomeDetailVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colletcionTitleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComapnyDetailCVC", for: indexPath) as! ComapnyDetailCVC
        cell.lblTitle.text = colletcionTitleArray[indexPath.row] as? String
        cell.imgfView.image = UIImage(named: colletcionImageArray[indexPath.row] as! String)
        let obj = UpdateCornerRadious()
        obj.subViewCornerRadious10(subViewArray: [cell.subView])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Herramientas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HerramientasViewController") as! HerramientasViewController
        nextViewController.matchType = indexPath.row
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.colletcionTitleArray = colletcionTitleArray
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
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
