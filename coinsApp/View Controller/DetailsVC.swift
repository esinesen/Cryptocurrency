//
//  DetailsVC.swift
//  coinsApp
//
//  Created by Esin Esen on 16.03.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    static var symbol = ""
    static var name = ""
    static var price = ""
    static var change = ""
    static var sparkline = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbolLabel.text = DetailsVC.symbol
        nameLabel.text = DetailsVC.name
        
        let floatPrice = Float(DetailsVC.price)
        priceLabel.text = "$" + String(format: "%.2f", floatPrice!)
        
        let floatArray = DetailsVC.sparkline.map{ Float($0)! }
        if Double(DetailsVC.change)! > 0 {
            changeLabel.text = "+\(DetailsVC.change)% (+$" + String(format: "%.2f", floatArray.max()! - floatArray.min()!) + ")"
            changeLabel.textColor = .systemGreen
        } else {
            changeLabel.text = "\(DetailsVC.change)% (-$" + String(format: "%.2f", floatArray.max()! - floatArray.min()!) + ")"
            changeLabel.textColor = .systemRed
        }

        highLabel.text = "$" + String(format: "%.2f", floatArray.max()!)
        lowLabel.text = "$" + String(format: "%.2f", floatArray.min()!)
        detailView.layer.cornerRadius = 10
    }
}
