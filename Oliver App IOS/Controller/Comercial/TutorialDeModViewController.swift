//
//  TutorialDeModViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 20/12/20.
//

import UIKit

class TutorialDeModViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var subViewMain: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var subViewMainTop: UIView!
    var scrollViewPaging = UIScrollView()
    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        manageView()
        manageScroll()
        collView.register(UINib(nibName: "HerramientasCVC", bundle: nil), forCellWithReuseIdentifier: "HerramientasCVC")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func manageView()  {
        self.subViewMain.layer.addSublayer(GlobleClass.backGrayGroundColor())

    }
    
    func manageScroll()  {
        scrollViewPaging = UIScrollView(frame: CGRect(x: 0 , y: subViewMainTop.frame.size.height + subViewMainTop.frame.origin.y + 20,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (subViewMainTop.frame.size.height + subViewMainTop.frame.origin.y + 20)))
          
        scrollViewPaging.isPagingEnabled = true
        scrollViewPaging.backgroundColor = .white
        scrollViewPaging.showsVerticalScrollIndicator = false
        scrollViewPaging.showsHorizontalScrollIndicator = false
        scrollViewPaging.delegate = self
        scrollViewPaging.backgroundColor = .clear
         view.addSubview(scrollViewPaging)
         let numberOfPages :Int = 10
         let padding : CGFloat = 0
         let viewWidth = scrollViewPaging.frame.size.width - 2 * padding
         let viewHeight = scrollViewPaging.frame.size.height - 2 * padding

         var x : CGFloat = 0
       
          for i in 0...numberOfPages
          {
             let view: UIView = UIView(frame: CGRect(x: x + padding, y: padding, width: viewWidth, height: viewHeight))
             if(i < 2)
             {
              view.backgroundColor = UIColor.white
             }
             else
             {
                view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
             }
           
            let table = UITableView(frame: CGRect(x: 0, y: 0, width: scrollViewPaging.frame.size.width, height: scrollViewPaging.frame.size.height))
            table.tag = i + 100
            table.separatorStyle = .none
            let tbl = table.viewWithTag(i + 100) as! UITableView
            self.registerCellsTable(tableView: tbl)
            tbl.delegate = self
            tbl.dataSource = self
            tbl.backgroundColor = .clear
            view.addSubview(table)
            view.clipsToBounds = true
            scrollViewPaging.addSubview(view)
            x = view.frame.origin.x + viewWidth + padding

        }
       
        scrollViewPaging.contentSize = CGSize(width:x+padding, height:scrollViewPaging.frame.size.height)
    }
    func registerCellsTable(tableView: UITableView) -> Void {
        tableView.register(UINib(nibName: "HerramientasVideoTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasVideoTVC")
        tableView.register(UINib(nibName: "HerramientasTextDetailsTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextDetailsTVC")
        tableView.register(UINib(nibName: "HerramientasTextPdfTVC", bundle: nil), forCellReuseIdentifier:  "HerramientasTextPdfTVC")
        tableView.register(UINib(nibName: "HerramientesBottomLabelTVC", bundle: nil), forCellReuseIdentifier:  "HerramientesBottomLabelTVC")
        tableView.register(UINib(nibName: "VideoPlayTableViewCell", bundle: nil), forCellReuseIdentifier:  "VideoPlayTableViewCell")
        tableView.register(UINib(nibName: "TutorialDelModuloTVC", bundle: nil), forCellReuseIdentifier:  "TutorialDelModuloTVC")
        
     
    }

    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
//MARK:- CollectionView Methods
extension TutorialDeModViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerramientasCVC", for: indexPath) as! HerramientasCVC
//        if(bottomlblNoHidden == indexPath.row)
//        {
//            cell.lblBottom.isHidden = false
//        }
//        else
//        {
//         cell.lblBottom.isHidden = true
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
      /*  bottomlblNoHidden = indexPath.row
        collView.reloadData()
        self.collView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        scrollViewIndexView(index: indexPath.row)
       */
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
//            bottomlblNoHidden = Int(current)
//
//            self.collView.reloadData()
//            self.collView.scrollToItem(at: IndexPath(item: bottomlblNoHidden, section: 0), at: .centeredHorizontally, animated: true)
            scrollViewIndexView(index: Int(current))
        }
    }
}
extension TutorialDeModViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag < 102)
        {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView.tag < 102)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TutorialDelModuloTVC", for: indexPath) as! TutorialDelModuloTVC
            cell.selectionStyle = .none
            return cell
        }
        
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HerramientasTextPdfTVC", for: indexPath) as! HerramientasTextPdfTVC
             cell.lblText.text = "ghfgfghf" 
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

}
