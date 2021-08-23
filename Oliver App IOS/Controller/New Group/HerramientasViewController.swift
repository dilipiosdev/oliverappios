//
//  HerramientasViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/12/20.
//

import UIKit
import AVFoundation
import WebKit
import Firebase

class HerramientasViewController: UIViewController {
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var subView: UIView!
    var matchType = Int()
    var textDetailsArray = Array<Any>()
    var type0textArray = Array<Any>()
    var type0BottomtextArray = Array<Any>()
    
    var type1textArray = Array<Any>()
    var type1textDetailsArray = Array<Any>()
    var type1BottomtextArray = Array<Any>()
    
    var type2textArray = Array<Any>()
    var type2textDetailsArray = Array<Any>()
    var type2BottomtextArray = Array<Any>()
    
    var type3textArray = Array<Any>()
    var type3textDetailsArray = Array<Any>()
    var type3BottomtextArray = Array<Any>()
    var type3LabeltextArray = Array<Any>()
    
    @IBOutlet weak var subViewMain1: UIView!
    @IBOutlet weak var subViewMain2: UIView!
    @IBOutlet weak var subViewMain2Top: UIView!
    @IBOutlet weak var subViewMain2Middle: UIView!
    @IBOutlet weak var subviewMain2Bottom: UIView!
    @IBOutlet weak var webViewVideo: WKWebView!
    @IBOutlet weak var imgheader: UIImageView!
    @IBOutlet weak var subViewMainTop: UIView!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var subViewMain1Height: NSLayoutConstraint!
    
    @IBOutlet weak var subViewMain2HeightCnst: NSLayoutConstraint!
    @IBOutlet weak var subViewMain1Width: NSLayoutConstraint!
    @IBOutlet weak var subViewMain2WidthConst: NSLayoutConstraint!
    
    var scrollViewPaging = UIScrollView()
    var bottomlblNoHidden = Int()
    var companyDetailDict = DataSnapshot()
    @IBOutlet weak var lblTitle: UILabel!
    var colletcionTitleArray = Array<Any>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomlblNoHidden = 0
        subViewMain1.isHidden = false
        subViewMain2.isHidden = true
        /******************** Register Table Cell ****************************/
        tbl.register(UINib(nibName: "HerramientasVideoTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasVideoTVC")
        tbl.register(UINib(nibName: "HerramientasTextDetailsTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextDetailsTVC")
        tbl.register(UINib(nibName: "HerramientasTextPdfTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextPdfTVC")
        tbl.register(UINib(nibName: "HerramientesBottomLabelTVC", bundle: nil), forCellReuseIdentifier:  "HerramientesBottomLabelTVC")
        collView.register(UINib(nibName: "HerramientasCVC", bundle: nil), forCellWithReuseIdentifier: "HerramientasCVC")
        manageView()
        manageScrollType1()
        
    }
    
    func registerCellsTable(tableView: UITableView) -> Void {
        tableView.register(UINib(nibName: "HerramientasVideoTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasVideoTVC")
        tableView.register(UINib(nibName: "HerramientasTextDetailsTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextDetailsTVC")
        tableView.register(UINib(nibName: "HerramientasTextPdfTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextPdfTVC")
        tableView.register(UINib(nibName: "HerramientesBottomLabelTVC", bundle: nil), forCellReuseIdentifier:  "HerramientesBottomLabelTVC")
        tableView.register(UINib(nibName: "VideoPlayTableViewCell", bundle: nil), forCellReuseIdentifier:  "VideoPlayTableViewCell")
        
        collView.register(UINib(nibName: "HerramientasCVC", bundle: nil), forCellWithReuseIdentifier: "HerramientasCVC")
    }
    
    func manageView() {
        
        lblTitle.text =  colletcionTitleArray[matchType] as? String
        let imageHeaderArray = ["icono_introduccion_white","icono_propuesta_valor_white","icono_oportunidades_white","icono_introduccion_white","icono_propuesta_valor_white","icono_oportunidades_white","icono_propuesta_valor_white","icono_oportunidades_white","icono_oportunidades_white","icono_oportunidades_white" ,"icono_oportunidades_white" ,"icono_oportunidades_white","icono_oportunidades_white"]
        imgheader.image = UIImage(named: imageHeaderArray[matchType])
        
        let myURL = URL(string: "https://www.youtube.com/embed/1roy4o4tqQM?playsinline=1?autoplay=1")
        let youtubeRequest = URLRequest(url: myURL!)
        webViewVideo.load(youtubeRequest)
        
        if(matchType == 0)
        {
            textDetailsArray = ["En este modulo introductorio aprenderas a utilizar el aplicativo movil como herramienta de gestion para tu negocio."]
            type0textArray = ["Lo que usualmente pasa", "Reflexion 1: Causasv y Efectos","Como podria mejorarse","Reflexion 2: Causasv y Efectos","Herramienta para implementar el modelo de gestion","Motivacion para utilizar la Herramienta"]
            type0BottomtextArray = ["Presentaciones y Lecturas complementarias"]
        }
        if(matchType == 1)
        {
            type1textArray = ["Infomacion Genral del Negocio","Informacion socio-economica del Propietario del negocio","Autorizacion de acceso y uso de la informacion del usuario","Evaluaciones de inficadores de la Linea de Base"]
            type1textDetailsArray = ["NOMBER COMERCIAL: OLIVER HOLDING\n\nROZON Social: OLIVER HOLDING S.A.C\n\nR.U.C: 20606197781\n\nUBICACION: JR.LA LIBRTAD NRO. 646 URB.\nORBEA LIMA-LIMA - MAGDALENA DEL MAR\n\nTIPO DE EMPRESA: SOCIEDAD ANONIMA CERRADA\n\nACTIVIDAD ECONOMICA: INDUSTARIAS BASICAS DE HIERRRO Y ACERO\n\nFECHA DE INSCRIPCION (SUNAT): 16/07/2020\n\nESTADO DE LA EMPRESA:ACTIVO","NOMBER COMPLETO: OSWALDO OLIVER PAREDES FASCE\n\nD.N.I72504232\n\nUBICACION: CAJAMARCA, JAEN, SALLIQUE,SDFASDASD\n\nFECHA DE MACIMIENTO:9/9/2013\n\nSEXO:HOMBRE\n\nOCUPACION: Administrador\n\nGRADO ACADEMICO:Educacion Superior tecnica","ESTADO: AUTORIZADO","-INDEX1\n\n-INDEX2\n\n-INDEX3\n\n-INDEX4\n\n-INDEX5\n\n-INDEX6\n\n-INDEX7"]
            
            type1BottomtextArray = ["Evaluacion de Entrada"]
        }
        if(matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            type2textArray = ["Evaluacion de Entrada","Capacitacion:\("Como identificar Oportunidades de negocios")"]
            type2textDetailsArray = ["Lo que usualmente pasa","Relexion 1: Causas y Efectos","Como podria mejorarse","Relexion 2: Causas y Efectos","Herramientas para mejorar","Motivacion para utilizar la Herramienta"]
            type2BottomtextArray = ["Preaentaciones y Lecturas complementarias","Herraminta para mejorar 63215.1","Herraminta para mejorar 63215.2","Herraminta para mejorar 63215.3","Herraminta para mejorar 63215.4","Herraminta para mejorar 63215.5","Herraminta para mejorar 63215.6","Evaluacion de Salida"]
        }
        
        if(matchType == 6 || matchType == 7 || matchType == 8 || matchType == 9 || matchType == 10 || matchType == 11 || matchType == 12)
        {
            type3textArray = ["Evaluacion de Entrada","Capacitacion:\("Como comercializar Productos y Servicios por Multicanal y Omnicanal")"]
            type3textDetailsArray = ["Lo que usualmente pasa","Relexion 1: Causas y Efectos","Como podria mejorarse","Relexion 2: Causas y Efectos","Herramientas para mejorar","Motivacion para utilizar la Herramienta"]
            type3BottomtextArray = ["Preaentaciones y Lecturas complementarias","Herraminta para mejorar 63215.1","Herraminta para mejorar 63215.2","Herraminta para mejorar 63215.3","Herraminta para mejorar 63215.4","Herraminta para mejorar 63215.5","Herraminta para mejorar 63215.6","Evaluacion de Salida"]
            if(matchType == 6)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO","REGISTRO DE VENTAS","MATRIZ PRODUCTOS-MERCADO","CREDITOS Y COBRANZAS","SOPORTE A CLIENTES Y FIDELIZACION"]
            }
            else if(matchType == 7)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO","MIS VENDEDORES","ARGUMENTARIOS DE VENTAS","EMBUDOS DE VENTAS","AGENDA DE CITAS","PROYECCION DE VENTAS"]
            }
            else if(matchType == 8)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO","PLANEAMIENTO DE LA DEMANDA","PLANEAMIENTO DEL ABASTECIMIENTO","ADQUISICION DE BIENES Y SERVICIOS","BUSQUEDA Y EVALUACION DE PROVEEDORES","TERCERIZACION DE LA PRODUCCION / OPERACIONES","ALMACENAMIENTO","CONTROL DE INVENTARIOS","PROCESAMIENTO DE PEDIDOS","DESPACHO Y ENTREGA"]
            }
                
            else if(matchType == 9)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO","FICHAS TECNICAS DE PRODUCTOS Y SERVICIOS","COSTEO DE PRODUCTOS Y SERVICIOS","CAPACIDADO DE PRODUCCION","ORDENES DE PRODUCCION","STOCK DE MATERIALES E INSUMOS CRITICOS","CONTROL DE CALIDAD Y TRAZABILIDAD","MANTENIMIENTO DE HERRAMIENTAS,MAQUINARIA Y EQUIPOS","LEAN MANUFACTURING"]
            }
                
            else if(matchType == 10)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO", "PERFILES DE PUESTOS", "FILES DE PERSONAL", "PLANILLAS", "ROSTER Y PERFORMANCE", "EVALUACION 360"]
            }
                
            else if(matchType == 11)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO","INTRODUCCION A LA NORMATIVIDAD","NORMATIVIDAD TRIBUTARIA","NORMATIVIDAD LABORAL","NORMATIVIDAD SANITARIA","NORMATIVIDAD AMBIENTAL","RESPONSABILIDAD CIVIL Y PENAL","RESULTADOS DE NORMATIVIDAD"]
            }
                
            else if(matchType == 12)
            {
                type3LabeltextArray = ["TUTORIAL DEL MODULO", "CAJA Y BANCOS", "CUENTAS POR COBRAR", "CUENTAS POR PAGAR", "FLUJO DE CAJA", "EJECUCION PRESUPUESTAL", "ACTIVO FIJO", "ESTADOS FINANCIEROS", "GESTION DEL RIESGO"]
            }
        }
        let obj = UpdateCornerRadious()
        obj.subViewCornerRadious5(subViewArray: [subViewMain2Top,subViewMain2Middle,subviewMain2Bottom])
        
        tbl.reloadData()
        self.subView.layer.addSublayer(GlobleClass.backGrayGroundColor())
    }
    
    func manageScrollType1()  {
        
        let scrollHeight = UIScreen.main.bounds.size.height - (subViewMainTop.frame.size.height + subViewMainTop.frame.origin.y + 20)
        let scrollwidth = UIScreen.main.bounds.size.width
        
        scrollViewPaging = UIScrollView(frame: CGRect(x: 0 , y:  subViewMainTop.frame.size.height + subViewMainTop.frame.origin.y + 20,  width: scrollwidth, height: scrollHeight))
        
        scrollViewPaging.isPagingEnabled = true
        scrollViewPaging.backgroundColor = .white
        scrollViewPaging.showsVerticalScrollIndicator = false
        scrollViewPaging.showsHorizontalScrollIndicator = false
        scrollViewPaging.delegate = self
        scrollViewPaging.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        view.addSubview(scrollViewPaging)
        var numberOfPages = Int()
        if matchType == 0
        {
            numberOfPages = type0textArray.count + 1
        }
        else if matchType == 1
        {
            numberOfPages = 8
        }
        else
        {
            numberOfPages = 15
        }
        
        let padding : CGFloat = 0
        let viewWidth = scrollViewPaging.frame.size.width - 2 * padding
        let viewHeight = scrollViewPaging.frame.size.height - 2 * padding
        
        var x : CGFloat = 0
        
        for i in 0...numberOfPages
        {
            let view: UIView = UIView(frame: CGRect(x: x + padding, y: padding, width: viewWidth, height: viewHeight))
            if(i == 0)
            {
                view.backgroundColor = UIColor.gray
                subViewMain1.isHidden = false
                subViewMain1Height.constant = scrollHeight
                subViewMain1Width.constant = scrollwidth
                view.addSubview(subViewMain1)
            }
            else
            {
                let table = UITableView(frame: CGRect(x: 0, y: 0, width: scrollViewPaging.frame.size.width, height: scrollViewPaging.frame.size.height))
                table.tag = i + 100
                table.separatorStyle = .none
                let tbl = table.viewWithTag(i + 100) as! UITableView
                self.registerCellsTable(tableView: tbl)
                tbl.delegate = self
                tbl.dataSource = self
                tbl.backgroundColor = .clear
                view.addSubview(table)
            }
            view.clipsToBounds = true
            scrollViewPaging.addSubview(view)
            x = view.frame.origin.x + viewWidth + padding
        }
        scrollViewPaging.contentSize = CGSize(width:x+padding, height:scrollViewPaging.frame.size.height)
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



extension HerramientasViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if(tableView.tag > 100)
        {
            return 1
        }
        
        if(matchType == 0)
        {
            return 3
        }
        if(matchType == 1)
        {
            return 2
        }
        if(matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            return 3
        }
        if matchType == 6 || matchType == 7 || matchType == 8 || matchType == 9 || matchType == 10 || matchType == 11 || matchType == 12 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView.tag > 100 && matchType == 0)
        {
            if(tableView.tag == 107 && matchType == 0)
            {
                return 1
            }
            return 3
        }
        if(tableView.tag > 100 && matchType == 1)
        {
            return 1
        }
        if(tableView.tag > 100 && matchType > 1)
        {
            if(tableView.tag > 102 && matchType > 1 && tableView.tag < 109 && matchType > 1)
            {
                return 3
            }
            return 1
        }
        
        if(matchType == 0)
        {
            if(section == 0)
            {
                return 1
            }
            else if(section == 1)
            {
                return type0textArray.count
            }
            else
            {
                return type0BottomtextArray.count
            }
        }
        if(matchType == 1)
        {
            if(section == 0)
            {
                return type1textArray.count
            }
            if(section == 1)
            {
                return 7
            }
        }
        if(matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            if(section == 0)
            {
                return type2textArray.count
            }
            if(section == 1)
            {
                return type2textDetailsArray.count
            }
            if section == 2
            {
                return type2BottomtextArray.count
            }
        }
        if matchType == 6 || matchType == 7 || matchType == 8 || matchType == 9 || matchType == 10 || matchType == 11 || matchType == 12 {
            if(section == 0)
            {
                return type3textArray.count
            }
            if(section == 1)
            {
                return type3textDetailsArray.count
            }
            if section == 2
            {
                return type3BottomtextArray.count
            }
            if section == 3 {
                return type3LabeltextArray.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView.tag > 100 && matchType == 0)
        {
            if(indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                if(type0textArray.count >= tableView.tag%100)
                {
                    cell.lblText.text = type0textArray[(tableView.tag%100) - 1] as? String
                }
                else
                {
                    cell.lblText.text = type0BottomtextArray[0] as? String
                }
                cell.selectionStyle = .none
                cell.subViewButton.isHidden = true
                cell.subViewBuuton1.isHidden = true
                return cell
            }
            if(indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayTableViewCell", for: indexPath) as! VideoPlayTableViewCell
                let myURL = URL(string: "https://www.youtube.com/embed/1roy4o4tqQM?playsinline=1?autoplay=1")
                let youtubeRequest = URLRequest(url: myURL!)
                cell.webView.load(youtubeRequest)
                return cell
            }
            if(indexPath.row == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextDetailsTVC", for: indexPath) as! HerramientasTextDetailsTVC
                cell.lbl2.text = "jhghjhg jhgj hjg hgjgj hjghj hjgh hg jhghjhg jhgj hjg hgjgj hjghj hjgh hg jhghjhg jhgj hjg hgjgj hjghj hjgh hg jhghjhg jhgj hjg hgjgj hjghj hjgh hg jhghjhg jhgj hjg hgjgj hjghj hjgh hg jhghjhg jhgj hjg hgjgj hjghj hjgh hg"
                cell.selectionStyle = .none
                return cell
            }
            
        }
        if(tableView.tag > 100 && matchType == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
            var textStr = type1BottomtextArray[0] as? String
            if(tableView.tag%100 > 0 && tableView.tag%100 < 8)
            {
                textStr = textStr! + String(format: " %d", (tableView.tag%100) - 1)
                cell.lblText.text = textStr ?? ""
            }
            else
            {
                cell.lblText.text = type1BottomtextArray[0] as? String
            }
            cell.imgViewLeft.image = UIImage(named: "icono_evaluacion")
            cell.imgView.image = UIImage(named: "icono_evaluacion")
            cell.selectionStyle = .none
            return cell
        }
        if(tableView.tag > 100 && matchType > 1)
        {
            
            if(tableView.tag%100 > 0 && tableView.tag%100 < 3)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                if(matchType != 6 && matchType != 7 && matchType != 8 && matchType != 9   && matchType != 10 && matchType != 11 && matchType != 12)
                {
                    cell.lblText.text = type2textArray[(tableView.tag%100) - 1] as? String
                }
                else
                {
                    cell.lblText.text = type3textArray[(tableView.tag%100) - 1] as? String
                    
                }
                cell.selectionStyle = .none
                return cell
            }
            else if (tableView.tag%100) > 2 && (tableView.tag%100) < 9
            {
                if(indexPath.row == 0)
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                    if(matchType != 6 && matchType != 7  && matchType != 8 && matchType != 9  && matchType != 10 && matchType != 11 && matchType != 12)
                    {
                        cell.lblText.text = type2textDetailsArray[(tableView.tag%100) - 3] as? String
                    }
                    else
                    {
                        cell.lblText.text = type3textDetailsArray[(tableView.tag%100) - 3] as? String
                    }
                    cell.selectionStyle = .none
                    return cell
                }
                else if(indexPath.row == 1)
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayTableViewCell", for: indexPath) as! VideoPlayTableViewCell
                    let myURL = URL(string: "https://www.youtube.com/embed/1roy4o4tqQM?playsinline=1?autoplay=1")
                    let youtubeRequest = URLRequest(url: myURL!)
                    cell.webView.load(youtubeRequest)
                    return cell
                }
                else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                    cell.lblText.text = "gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h gbggh ghg fghf gfggfg h "
                    cell.selectionStyle = .none
                    return cell
                }
            }
            else
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                if(matchType != 6 && matchType != 7 && matchType != 8 && matchType != 9  && matchType != 10 && matchType != 11 && matchType != 12)
                {
                    cell.lblText.text = type2BottomtextArray[(tableView.tag%100) - 8] as? String
                }
                else
                {
                    cell.lblText.text = type3BottomtextArray[(tableView.tag%100) - 8] as? String
                }
                cell.selectionStyle = .none
                return cell
            }
            
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasVideoTVC", for: indexPath) as! HerramientasVideoTVC
        cell.selectionStyle = .none
        if(matchType == 0)
        {
            if(indexPath.row == 0 && indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextDetailsTVC", for: indexPath) as! HerramientasTextDetailsTVC
                cell.lbl2.text = textDetailsArray[indexPath.row] as? String
                cell.selectionStyle = .none
                
                return cell
            }
            else if indexPath.section == 1
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasVideoTVC", for: indexPath) as! HerramientasVideoTVC
                cell.lblText.text = type0textArray[indexPath.row] as? String
                cell.selectionStyle = .none
                
                return cell
                
            }
            else if indexPath.section == 2
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                cell.lblText.text = type0BottomtextArray[indexPath.row] as? String
                cell.selectionStyle = .none
                
                return cell
                
            }
        }
        if(matchType == 1)
        {
            if(indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextDetailsTVC", for: indexPath) as! HerramientasTextDetailsTVC
                cell.lbl1.text = type1textArray[indexPath.row] as? String
                cell.lbl2.text = type1textDetailsArray[indexPath.row] as? String
                cell.selectionStyle = .none
                return cell
            }
            if(indexPath.section == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                var textStr = type1BottomtextArray[0]
                if(indexPath.row > 0)
                {
                    textStr = textStr as! String + String(format: "%d", indexPath.row)
                }
                cell.lblText.text = textStr as? String
                cell.imgViewLeft.image = UIImage(named: "icono_evaluacion")
                cell.imgView.image = UIImage(named: "icono_evaluacion")
                cell.selectionStyle = .none
                return cell
                
            }
        }
        if(matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            if(indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                cell.lblText.text = type2textArray[indexPath.row] as? String
                cell.selectionStyle = .none
                if(indexPath.row == 0)
                {
                    cell.imgViewLeft.image = UIImage(named: "icono_evaluacion")
                    cell.imgView.image = UIImage(named: "icono_evaluacion")
                }
                if indexPath.row == 1 {
                    cell.imgViewLeft.image = UIImage(named: "icono_capacitacion")
                    cell.imgView.image = UIImage(named: "icono_capacitacion")
                }
                
                return cell
            }
            else if(indexPath.section == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasVideoTVC", for: indexPath) as! HerramientasVideoTVC
                cell.lblText.text = type2textDetailsArray[indexPath.row] as? String
                cell.selectionStyle = .none
                return cell
                
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                cell.imgView.image = UIImage(named: "icono_dashboard")
                cell.imgViewLeft.image = UIImage(named: "icono_dashboard_blue")
                
                if(indexPath.row == 0)
                {
                    cell.imgView.image = UIImage(named: "icono_carpeta")
                    cell.imgViewLeft.image = UIImage(named: "icono_carpeta")
                    
                }
                cell.lblText.text = type2BottomtextArray[indexPath.row] as? String
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if matchType == 6 || matchType == 7 || matchType == 8 || matchType == 9 || matchType == 10 || matchType == 11 || matchType == 12
        {
            if(indexPath.section == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                cell.lblText.text = type3textArray[indexPath.row] as? String
                cell.selectionStyle = .none
                if(indexPath.row == 0)
                {
                    cell.imgView.image = UIImage(named: "icono_carpeta")
                    cell.imgViewLeft.image = UIImage(named: "icono_carpeta")
                    
                }
                if(indexPath.row == 1)
                {
                    cell.imgView.image = UIImage(named: "icono_capacitacion")
                    cell.imgViewLeft.image = UIImage(named: "icono_capacitacion")
                    
                }
                
                return cell
            }
            else if(indexPath.section == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasVideoTVC", for: indexPath) as! HerramientasVideoTVC
                cell.lblText.text = type3textDetailsArray[indexPath.row] as? String
                cell.selectionStyle = .none
                
                return cell
                
            }
            else if(indexPath.section == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
                cell.lblText.text = type3BottomtextArray[indexPath.row] as? String
                cell.selectionStyle = .none
                if indexPath.row == 0 {
                    cell.imgView.image = UIImage(named: "icono_capacitacion")
                    cell.imgViewLeft.image = UIImage(named: "icono_capacitacion")
                }
                else
                {
                    cell.imgView.image = UIImage(named: "icono_herramientas")
                    cell.imgViewLeft.image = UIImage(named: "icono_herramientas")
                }
                
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientesBottomLabelTVC", for: indexPath) as! HerramientesBottomLabelTVC
                cell.lblTxt.text = type3LabeltextArray[indexPath.row] as? String
                cell.selectionStyle = .none
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 20, y: 5, width: UIScreen.main.bounds.width - 60, height: 50))
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        view.addSubview(label)
        
        if(matchType == 0)
        {
            if(section == 1)
            {
                label.text = "Enlace instantaneo a cancel de CARE en Youtubevpara ver y escuchar:"
            }
            if(section == 2)
            {
                label.text = "Presenttaciones y Lecturas complementarias:"
            }
        }
        if(matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            if(section == 1)
            {
                label.text = "Enlace instantaneo a cancel de CARE en Youtubevpara ver y escuchar:"
            }
            if(section == 2)
            {
                label.text = "Presenttaciones y Lecturas complementarias:"
            }
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(matchType == 0 || matchType == 2 || matchType == 3 || matchType == 4 || matchType == 5)
        {
            if(section == 1 || section == 2)
            {
                return 50
            }
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.numberOfRows(inSection: 0)
        if matchType == 0
        {
            if(indexPath.section == 1)
            {
                bottomlblNoHidden = indexPath.row + 1
                collView.reloadData()
                self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
                scrollViewIndexView(index: bottomlblNoHidden)
            }
            if(indexPath.section == 2)
            {
                bottomlblNoHidden = indexPath.row + index + 1
                collView.reloadData()
                self.collView.scrollToItem(at: IndexPath(item: indexPath.row + index, section: 0), at: .centeredHorizontally, animated: true)
                scrollViewIndexView(index: bottomlblNoHidden)
            }
        }
        else if matchType == 1
        {
            bottomlblNoHidden = indexPath.row + 1
            collView.reloadData()
            self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
            scrollViewIndexView(index: bottomlblNoHidden)
        }
        else if matchType == 7 {
            if(indexPath.section == 3)
            {
                if indexPath.row == 1 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MisVendedoresViewController") as! MisVendedoresViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else  if indexPath.row == 2 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AgrumentariosDeVentasVC") as! AgrumentariosDeVentasVC
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else  if indexPath.row == 3 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmbudosdeVentasViewController") as! EmbudosdeVentasViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else  if indexPath.row == 4 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AgendaDeCitasViewController") as! AgendaDeCitasViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                } else  if indexPath.row == 5 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProyeccionViewController") as! ProyeccionViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }
            
        else if matchType == 8 {
            if(indexPath.section == 3)
            {
                if indexPath.row == 0 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 1 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlaneanientoViewController") as! PlaneanientoViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 2 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AbastecimientoViewController") as! AbastecimientoViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 3 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AdquisicionViewController") as! AdquisicionViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 4 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BusquedaViewController") as! BusquedaViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 5 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TercerizacionViewController") as! TercerizacionViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 6 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AlmacenamientoViewController") as! AlmacenamientoViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 7 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ControldeInventViewController") as! ControldeInventViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 8 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProcesamientoViewController") as! ProcesamientoViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 9 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DespachoViewController") as! DespachoViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
            }
        }
        else if matchType == 10 {
            if(indexPath.section == 3)
            {
                if indexPath.row == 0 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 1 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PerfilesViewController") as! PerfilesViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 2 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FilesDePersonalViewController") as! FilesDePersonalViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 3 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlanillasViewController") as! PlanillasViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 4 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadSanitariaViewController") as! NormatividadSanitariaViewController
                    
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 5 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Evaluation360ViewController") as! Evaluation360ViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }
            
            
        else if matchType == 11 {
            if(indexPath.section == 3)
            {
                if indexPath.row == 0 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 1 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IntroductionNormViewController") as! IntroductionNormViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 2 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadTributariaViewController") as! NormatividadTributariaViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 3 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadLaboralViewController") as! NormatividadLaboralViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 4 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadSanitariaViewController") as! NormatividadSanitariaViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 5 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadAmbientalViewController") as! NormatividadAmbientalViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 6 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResponsabilidadViewController") as! ResponsabilidadViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 7 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResultadosViewController") as! ResultadosViewController
                    nextViewController.companyDetailDict = companyDetailDict

                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
            }
        }
            
        else if matchType == 12 {
            if(indexPath.section == 3)
            {
                if indexPath.row == 0 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 1 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IntroductionNormViewController") as! IntroductionNormViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 2 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadTributariaViewController") as! NormatividadTributariaViewController
                    nextViewController.companyDetailDict = companyDetailDict
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 3 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadLaboralViewController") as! NormatividadLaboralViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 4 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadSanitariaViewController") as! NormatividadSanitariaViewController
                    
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 5 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadAmbientalViewController") as! NormatividadAmbientalViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                if indexPath.row == 6 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResponsabilidadViewController") as! ResponsabilidadViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                if indexPath.row == 7 {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResultadosViewController") as! ResultadosViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
            }
        }
            
            
        else
        {
            var index = tableView.numberOfRows(inSection: 0)
            if(indexPath.section == 0)
            {
                bottomlblNoHidden = indexPath.row + 1
                collView.reloadData()
                self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
                scrollViewIndexView(index: bottomlblNoHidden)
            }
            if(indexPath.section == 1)
            {
                bottomlblNoHidden = indexPath.row + index + 1
                collView.reloadData()
                self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
                scrollViewIndexView(index: bottomlblNoHidden)
            }
            if(indexPath.section == 2)
            {
                index = index + tableView.numberOfRows(inSection: 1)
                bottomlblNoHidden = indexPath.row + index + 1
                collView.reloadData()
                self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
                scrollViewIndexView(index: bottomlblNoHidden)
            }
            if(indexPath.section == 3)
            {
                
                if matchType == 9 {
                    
                    if indexPath.row == 0 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 1 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FichasViewController") as! FichasViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                    if indexPath.row == 2 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CosteoViewController") as! CosteoViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                    if indexPath.row == 3 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CapacidadoViewController") as! CapacidadoViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 4 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OrdenesViewController") as! OrdenesViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                    if indexPath.row == 5 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StockDeMaterialViewController") as! StockDeMaterialViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 6 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ControlDeCalidadYViewController") as! ControlDeCalidadYViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                    if indexPath.row == 7 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MantenimientoDeHerrViewController") as! MantenimientoDeHerrViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 8 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LearnManufaturingViewController") as! LearnManufaturingViewController
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                }
                    
                else {
                    
                    if indexPath.row == 0 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialDeModViewController") as! TutorialDeModViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 1 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegistroDelVentasVC") as! RegistroDelVentasVC
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 2 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MatrizProductVC") as! MatrizProductVC
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                    if indexPath.row == 3 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreditosYViewController") as! CreditosYViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    if indexPath.row == 4 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SporteAClientViewController") as! SporteAClientViewController
                        nextViewController.companyDetailDict = companyDetailDict
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                }
                
            }
        }
    }
}


//MARK:- CollectionView Methods
extension HerramientasViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfPages = Int()
        if matchType == 0
        {
            numberOfPages = type0textArray.count + 1
        }
        else if matchType == 1
        {
            numberOfPages = 8
        }
        else
        {
            numberOfPages = 17
        }
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerramientasCVC", for: indexPath) as! HerramientasCVC
        if(bottomlblNoHidden == indexPath.row)
        {
            cell.lblBottom.isHidden = false
        }
        else
        {
            cell.lblBottom.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            subViewMain1.isHidden = false
            subViewMain2.isHidden = true
        }
        else
        {
            subViewMain1.isHidden = true
            subViewMain2.isHidden = false
        }
        
        bottomlblNoHidden = indexPath.row
        collView.reloadData()
        self.collView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        scrollViewIndexView(index: indexPath.row)
    }
    
    func scrollViewIndexView(index: Int) {
        let tbl1 = self.scrollViewPaging.viewWithTag(index + 100) as? UITableView
        tbl1?.reloadData()
        self.scrollToPage(page: index, animated: true)
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollViewPaging.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollViewPaging.scrollRectToVisible(frame, animated: animated)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == scrollViewPaging {
            let pageWidth: CGFloat = scrollView.frame.width
            let current: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            bottomlblNoHidden = Int(current)
            
            self.collView.reloadData()
            self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
            scrollViewIndexView(index: Int(current))
        }
    }
}
