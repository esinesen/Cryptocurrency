//
//  CoinCell.swift
//  coinsApp
//
//  Created by Esin Esen on 14.03.2022.
//

import UIKit

class CoinCell: UITableViewCell {
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var coinView: UIView!
    
    var image = ""
    var symbol = ""
    var name = ""
    var price = ""
    var change = ""
    var sparkline = [String]()
    var marketCap = ""
    var listedAt = Int()
    var rank = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coinView.layer.cornerRadius = 10
    }
    

    func configure(model: Coin) {
        image = model.iconUrl ?? ""
        symbol = model.symbol ?? ""
        name = model.name ?? ""
        price = model.price ?? ""
        change = model.change ?? ""
        sparkline = model.sparkline ?? []
        marketCap = model.marketCap ?? ""
        listedAt = model.listedAt ?? 0
        rank = model.rank ?? 0
        
        symbolLabel.text = symbol
        nameLabel.text = name
        
        let floatPrice = Float(price)
        priceLabel.text = "$" + String(format: "%.2f", floatPrice!)
        
        let floatArray = sparkline.map{ Float($0)! }
        if Double(change)! > 0 {
            changeLabel.text = "+\(change)% (+$" + String(format: "%.2f", floatArray.max()! - floatArray.min()!) + ")"
            changeLabel.textColor = .systemGreen
        } else {
            changeLabel.text = "\(change)% (-$" + String(format: "%.2f", floatArray.max()! - floatArray.min()!) + ")"
            changeLabel.textColor = .systemRed
        }
        
        let newUrl = image.replacingOccurrences(of: "svg", with: "png")
        let gameImageUrl = newUrl
        if let imageUrl = URL(string: gameImageUrl) {
            if let data = try? Data(contentsOf: imageUrl) {
                coinImage.image = UIImage(data: data)
            }
        }
    }
}
