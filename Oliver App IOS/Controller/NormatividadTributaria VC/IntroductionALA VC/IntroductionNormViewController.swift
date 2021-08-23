//
//  IntroductionNormViewController.swift
//  Oliver App IOS
//
//  Created by apple on 22/02/21.
//

import UIKit
import Firebase

class IntroductionNormViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, redirectToMainPageDelegate{
    
   
    
    
    @IBOutlet weak var tbl: UITableView!
    var titleArray = Array<Any>()
    var especificationArray = Array<Any>()
    var decrtoArray = Array<Any>()
    var topLblArray = Array<Any>()
    var sectionArray = Array<Any>()
    
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
        self.sectionArray = ["","¿Cómo clasifican a tu empresa?", "¿Qué tipo de sociedad eres?","¿En qué regimen tributario te encuentras? ¿Sabes sus ventajas?","¿Sabes los pasos que debes de seguir para formalizar tu negocio?","Conoce mas de las Normatividades y Regulaciones","Resultados de Normatividad", ]
        
        self.titleArray = ["Búsqueda y reserva del nombre de la empresa en Registros Públicos", "Elaboración de la minuta", "Elevar minuta a escritura pública ", "Inscribir Escritura Pública en Registros Públicos ", "Obtención del Número de R.U.C.", "Elegir el Régimen Tributario", "Comprar y Legalizar Libors Contables", "Inscribir Trabajadores en Essalud (si van a estar en planilla)", "Solicitud de Licencia Municipal"]
        
        self.especificationArray = ["a. Necesitas un nombre para tu empresa que deseas crear, el cual debe de ser único y distinto a los ya registrados en SUNARP.   b. Acudir a la Oficina de Registros Públicos, en este caso la SUNARP, ,solicitar y llenar los formularios respectivos para luego presentar la RESERVA DE NOMBRE DE EMPRESA.", "a. La minuta es un documento en el cual los miembros de la sociedad manifiestan su voluntad de constituir la empresa, y en donde se señalan todos los acuerdos respectivos.   b. Consta del pacto social y los estatutos, además de los insertos que se puedan adjuntar a ésta.   •Los generales de ley   de cada socio (sus datos personales, nombres, edades, documentos de identificación, etc.). •El giro de la sociedad. •El tipo de empresa o sociedad (E.I.R.L, S.R.L, S.A, etc.). •El tiempo de duración de la sociedad (plazo fijo o indeterminado). •La fecha en la que se va a dar inicio a las actividades comerciales. •El lugar en donde va a funcionar la sociedad (domicilio comercial). •La denominación o razón social de la sociedad.  •El lugar en donde van a funcionar las agencias o sucursales (si es que las hubieran).  •La persona que va a administrar o representar la sociedad. •Los aportes de cada socio. Los cuales pueden ser:  1. bienes dinerarios: dinero y sus medios sustitutos tales como cheques, pagarés, letras de cambios, etc.  2. bienes no dinerarios: inmuebles o muebles tales como escritorios, mesas, sillas, etc.  •Otros acuerdos que establezcan los socios. ", "a.- Una vez redactada la minuta, debemos llevarla a una notaría para que un notario público la revise y la eleve a escritura pública.   b.- Por lo general, los documentos que debemos llevar junto con la minuta son:   b.1.- La constancia o el comprobante de depósito del capital aportado en una cuenta bancaria a nombre de la empresa.  b.2.- Un inventario detallado y valorizado de los bienes no dinerarios.  b.3.- El certificado de Búsqueda Mercantil emitido por la Oficina de Registros Públicos de la inexistencia de una razón social igual o similar.  b.4.- Una vez elevada la minuta, ésta no se puede cambiar. Al final, se genera la Escritura Pública, Testimonio de Sociedad o Constitución Social, que es el documento que da fe de que la minuta es legal, la cual debe estar firmada y sellada por el notario. ", "a. Una vez que hemos obtenido la Escritura Pública, debemos llevarla a la Oficina de Registros Públicos en donde se realizarán los trámites necesarios para inscribir la empresa en los Registros Públicos.   b. La Persona Jurídica existe a partir de su inscripción en los Registros Públicos.", "a. El Registro Único de Contribuyentes (RUC) es lo que identifica a una persona o empresa ante la Superintendencia Nacional de Administración Tributaria (SUNAT) para el pago de los impuestos.    b. Toda Persona natural o Jurídica está obligada a inscribirse en el RUC, de lo contrario será sancionada de acuerdo con el Código Tributario, igual que los inscritos en el RUC que no presenten la declaración.","En la misma SUNAT, a la vez que tramita la obtención del RUC, debe determinar a qué régimen tributario te vas a acoger para el pago de los impuestos, ya sea al Régimen Único Simplificado (RUS), al Régimen Especial de Impuesto a la Renta (RER), o al Régimen General (RG) o Ley de Zonas Altoandinas.", "En este paso compramos los libros contables necesarios dependiendo del régimen tributario al cual nos hayamos acogido y, posteriormente, los llevamos a una notaría para que sean legalizados por un notario público.", "En este paso registramos a nuestros trabajadores ante el Seguro Social de Salud (EsSalud) a través de un formulario que podemos obtener en la misma SUNAT. Este registro le permite a los trabajadores acceder a las prestaciones que otorga dicha entidad.", "En este paso acudimos a la municipalidad del distrito en donde va a estar ubicada físicamente nuestra empresa, y tramitamos la obtención de la licencia de funcionamiento.  1. Fotocopia de la ficha RUC.   2. Certificado de Zonificación (zona industrial, zona comercial, zona residencial, etc.).   3. Croquis de la ubicación de la empresa.   4. Copia del contrato de alquiler o del título de propiedad del local.   5. Copia de la Escritura Pública.   6. Recibo de pago por derecho de licencia.     7. Formulario de solicitud."]
        
        self.decrtoArray = ["PASO 1", "PASO 2", "PASO 3", "PASO 4", "PASO 5", "PASO 6", "PASO 7", "PASO 8", "PASO 9"]
        
        tbl.register(UINib(nibName: "MidTableViewCell", bundle: nil), forCellReuseIdentifier: "MidTableViewCell")
        tbl.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")
        tbl.register(UINib(nibName: "Section1TableViewCell", bundle: nil), forCellReuseIdentifier: "Section1TableViewCell")
        tbl.register(UINib(nibName: "Section2TableViewCell", bundle: nil), forCellReuseIdentifier: "Section2TableViewCell")
        tbl.register(UINib(nibName: "Section3TableViewCell", bundle: nil), forCellReuseIdentifier: "Section3TableViewCell")
        tbl.register(UINib(nibName: "Section4TableViewCell", bundle: nil), forCellReuseIdentifier: "Section4TableViewCell")
        tbl.register(UINib(nibName: "Section5TableViewCell", bundle: nil), forCellReuseIdentifier: "Section5TableViewCell")
        tbl.register(UINib(nibName: "Section6TableViewCell", bundle: nil), forCellReuseIdentifier: "Section6TableViewCell")
        
        
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        } else if section == 1 {
            return 1
            
        } else if section == 2 {
            return 1
            
        } else if section == 3 {
            return 1
            
        } else if section == 4 {
            return 9
            
        } else if section == 5 {
            return 1
            
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as! TopTableViewCell
            cell.titleLbl.text = "Introduccion a la Normatividad"
            cell.descriptionLbl.text = "Con estas heramientas podras saber si tu comercio/negocio/empresa esta cumpliendo con Ias normas peruanas en sus actividades"
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section1TableViewCell", for: indexPath) as! Section1TableViewCell
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section2TableViewCell", for: indexPath) as! Section2TableViewCell
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section3TableViewCell", for: indexPath) as! Section3TableViewCell
            return cell
        }
        if indexPath.section == 4  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section4TableViewCell", for: indexPath) as! Section4TableViewCell
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.specificationLbl.text  = (self.especificationArray[indexPath.row] as! String)
            cell.pasoLbl.text  = (self.decrtoArray[indexPath.row] as! String)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section5TableViewCell", for: indexPath) as! Section5TableViewCell
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Section6TableViewCell", for: indexPath) as! Section6TableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 130
        } else if indexPath.section == 1 {
            return 500
            
        } else if indexPath.section == 2 {
            return 500
            
        }  else if indexPath.section == 3 {
            return 500
            
        } else if indexPath.section == 4 {
            return 350
            
        } else if indexPath.section == 5 {
            return 180
            
        } else {
            return 65
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "\(section) \(self.sectionArray[section] as! String)"
        }
        //"Section \(section)"
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        
        return vw
    }
    
    //MARK:- Button Tap delegate from section 5
    
    func redirectToMainPage(indexpath: IndexPath) {
           if indexpath.row == 0 {
               let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadTributariaViewController") as! NormatividadTributariaViewController
               nextViewController.companyDetailDict = companyDetailDict
               self.navigationController?.pushViewController(nextViewController, animated: true)
           }
           if indexpath.row == 1 {
               let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadLaboralViewController") as! NormatividadLaboralViewController
               nextViewController.companyDetailDict = companyDetailDict
               self.navigationController?.pushViewController(nextViewController, animated: true)
           }
           if indexpath.row == 2 {
               let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadSanitariaViewController") as! NormatividadSanitariaViewController
               nextViewController.companyDetailDict = companyDetailDict
               self.navigationController?.pushViewController(nextViewController, animated: true)
           }
           if indexpath.row == 3 {
               let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NormatividadAmbientalViewController") as! NormatividadAmbientalViewController
               nextViewController.companyDetailDict = companyDetailDict
               self.navigationController?.pushViewController(nextViewController, animated: true)
           }
           if indexpath.row == 4 {
               let storyBoard : UIStoryboard = UIStoryboard(name: "NormatividadSocial", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResponsabilidadViewController") as! ResponsabilidadViewController
               nextViewController.companyDetailDict = companyDetailDict
               self.navigationController?.pushViewController(nextViewController, animated: true)
           }
       }
}
