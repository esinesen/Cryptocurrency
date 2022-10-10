//
//  ViewController.swift
//  coinsApp
//
//  Created by Esin Esen on 14.03.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var showMenuButton: UIButton!
    
    var coin = [Coin]()
    
    var sortMenu: UIMenu {
        return UIMenu(title: "Sort by...", image: nil, identifier: nil, options: [], children: [
            UIAction (title: "Default", image: nil, state: .on, handler: { (_) in
                self.coin.sort{
                    $0.rank ?? 0 < $1.rank ?? 0
                }
                self.tableView.reloadData()
            }),
            UIAction (title: "Price", image: nil, handler: { (_) in
                self.coin.sort{
                    Float($0.price ?? "")! < Float($1.price ?? "")!
                }
                self.tableView.reloadData()
            }),
            UIAction(title: "Market Cap", image: nil, handler: { (_) in
                self.coin.sort{
                    Float($0.marketCap ?? "")! < Float($1.marketCap ?? "")!
                }
                self.tableView.reloadData()
            }),
            UIAction(title: "24h Volume", image: nil, handler: { (_) in
                self.coin.sort{
                    Float($0.volume ?? "")! < Float($1.volume ?? "")!
                }
                self.tableView.reloadData()
            }),
            UIAction(title: "Change", image: nil, handler: { (_) in
                self.coin.sort{
                    Float($0.change ?? "")! < Float($1.change ?? "")!
                }
                self.tableView.reloadData()
            }),
            UIAction(title: "Listed At", image: nil, handler: { (_) in
                self.coin.sort{
                    $0.listedAt ?? 0 < $1.listedAt ?? 0
                }
                self.tableView.reloadData()
            })
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
        showMenuButton.menu = sortMenu
        showMenuButton.showsMenuAsPrimaryAction = true
        showMenuButton.changesSelectionAsPrimaryAction = true
        
        tableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "coinCell")
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCoins = try? decoder.decode(Datas.self, from: json) {
            coin = jsonCoins.data.coins
            tableView.reloadData()
        }
    }
}


extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath as IndexPath) as! CoinCell
        cell.configure(model: coin[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coin.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath as IndexPath) as! CoinCell
        selectedItem.configure(model: coin[indexPath.row])
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        
        DetailsVC.symbol = selectedItem.symbol
        DetailsVC.name = selectedItem.name
        DetailsVC.price = selectedItem.price
        DetailsVC.change = selectedItem.change
        DetailsVC.sparkline = selectedItem.sparkline
        
        present(detailsVC, animated: true, completion: nil)
    }
    
    
}

