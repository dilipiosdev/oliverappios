//
//  ChartTableViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 18/01/21.
//

import UIKit
import SwiftCharts
class ChartTableViewCell: UITableViewCell {
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        
    }
    
 
    @IBOutlet weak var chartView1: LineChart!
    var label = UILabel()
    var chartArray = Array<Any>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
  }
    
    func getChart()  {
        let dataEntries = generateRandomEntries()
        chartView1.dataEntries = dataEntries
        chartView1.isCurved = false
        chartView1.showDots = true
        chartView1.animateDots = true
      
    }
    
    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<chartArray.count {
            let value  = Int(chartArray[i] as? Int ?? 0)
            result.append(PointEntry(value: value, label: String(format: "%d", i + 1)))
        }
        return result
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print (point, super.hitTest(point, with: event))
        return super.hitTest(point, with: event)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: chartView1)
            print(position)
        }
    }
override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("hh")
    }
    
}
