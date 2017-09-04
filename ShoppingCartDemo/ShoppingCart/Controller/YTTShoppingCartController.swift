//
//  YTTShoppingCartController.swift
//  YiFangTianXia
//
//  Created by Andy on 2017/7/6.
//  Copyright © 2017年 YFTX. All rights reserved.
//

import UIKit


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height


class YTTShoppingCartController: UIViewController {
    
    fileprivate var tableView: UITableView!
    
    
    var goodsList: [YTTShoppingCartShopItem]! = [YTTShoppingCartShopItem]()
    
    
    fileprivate var selBtn: UIButton!
    fileprivate var totalPriceLabel: UILabel!
    fileprivate var jsBtn: UIButton!
    fileprivate var totalGoods: Int = 0
    fileprivate var totalMoney: Float = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        self.view.backgroundColor = UIColor.gray
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 50), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.gray
        tableView.rowHeight = 80 //UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 80
        self.view.addSubview(tableView)
        
        
        
        let bottomView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 50))
        bottomView.backgroundColor = UIColor.white
        selBtn = UIButton(type: .custom)
        selBtn.setImage(#imageLiteral(resourceName: "shoppingcart_xuanze-2"), for: .normal)
        selBtn.setImage(#imageLiteral(resourceName: "shoppingcart_xuanze-1"), for: .selected)
        selBtn.addTarget(self, action: #selector(YTTselectAll(_:)), for: .touchUpInside)
        bottomView.addSubview(selBtn)
        selBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "全选"
        bottomView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(selBtn.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        
        let label1 = UILabel()
        label1.text = "总计:"
        bottomView.addSubview(label1)
        label1.font = UIFont.systemFont(ofSize: 13)
        label1.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        totalPriceLabel = UILabel()
        totalPriceLabel.font = UIFont.systemFont(ofSize: 13)
        totalPriceLabel.text = "0"
        bottomView.addSubview(totalPriceLabel)
        totalPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label1.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        
        
        self.view.addSubview(bottomView)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        for i in 1 ..< 6 {
            let shopItem = YTTShoppingCartShopItem()
            shopItem.shopName = "这是第\(i)家店铺"
            for j in 0 ... i {
                let goods = YTTShoppingCartGoodsItem()
                goods.goodsName = "this is \(j) goods"
                goods.goodsPrice = "256.00"
                goods.goodsCount = "\(j)"
                shopItem.goodsList?.append(goods)
            }
            goodsList.append(shopItem)
        }

    }
    
    
    
    
    @objc private func YTTselectAll(_ sender: UIButton) -> Void {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            for i in 0 ..< goodsList.count {
                self.YTTheaderDidSelected(section: i)
            }
        }else {
            
            for i in 0 ..< goodsList.count {
                self.YTTheaderDisDidSelected(section: i)
            }
        }
        tableView.reloadData()
    }
    
    
    
}


extension YTTShoppingCartController: YTTShoppingCartCellDelegate, YTTShoppingCartHeaderViewDelegate {
    func YTTdidAddGoods(indexPath: IndexPath!) {
        
        let goodsItem: YTTShoppingCartGoodsItem = goodsList[indexPath.section].goodsList![indexPath.row]
        goodsItem.goodsCount = "\(Int(goodsItem.goodsCount!)! + 1)"
        
        if goodsItem.isSelected {
            totalMoney = totalMoney + Float(goodsItem.goodsPrice!)!
            totalPriceLabel.text = "\(totalMoney)"
        }
        
        tableView.reloadData()
    }
    
    func YTTdidSubGoods(indexPath: IndexPath!) {
        let goodsItem: YTTShoppingCartGoodsItem = goodsList[indexPath.section].goodsList![indexPath.row]
        goodsItem.goodsCount = "\(Int(goodsItem.goodsCount!)! - 1)"
        if goodsItem.isSelected {
            totalMoney = totalMoney - Float(goodsItem.goodsPrice!)!
            totalPriceLabel.text = "\(totalMoney)"

        }
        tableView.reloadData()
    }
    
    func YTTdidSelected(indexPath: IndexPath!) {
        
        let shopItem = goodsList[indexPath.section]
        let goodsItem = shopItem.goodsList?[indexPath.row]
        goodsItem?.isSelected = true
        var flag = true
        for item in shopItem.goodsList! {
            
            if !item.isSelected {
                flag = false
                break
            }
        }
        
        if flag {
            shopItem.isSelected = flag
            var shopFlag = true
            for item in goodsList {
                if !item.isSelected {
                    shopFlag = false
                    break
                }
            }
            selBtn.isSelected = shopFlag
        }
        tableView.reloadData()
        
        
        totalMoney = totalMoney + Float((goodsItem?.goodsPrice!)!)! * Float((goodsItem?.goodsCount!)!)!
        totalPriceLabel.text = "\(totalMoney)"

        
    }
    
    func YTTdidDisSelected(indexPath: IndexPath!) {
        let shopItem = goodsList[indexPath.section]
        shopItem.isSelected = false
        selBtn.isSelected = false
        let goodsItem = shopItem.goodsList?[indexPath.row]
        goodsItem?.isSelected = false
        tableView.reloadData()
        
        totalMoney = totalMoney - Float((goodsItem?.goodsPrice!)!)! * Float((goodsItem?.goodsCount!)!)!
        totalPriceLabel.text = "\(totalMoney)"

        
    }
    
    func YTTheaderDidSelected(section: Int) {
        let shopItem = goodsList[section]
        shopItem.isSelected = true
        for item in shopItem.goodsList! {
            if !item.isSelected {
                item.isSelected = true
                totalMoney = totalMoney + Float(item.goodsPrice!)! * Float(item.goodsCount!)!
                totalPriceLabel.text = "\(totalMoney)"
            }
        }
        tableView.reloadData()
        
        var shopFlag = true
        for item in goodsList {
            if !item.isSelected {
                shopFlag = false
                break
            }
        }
        selBtn.isSelected = shopFlag
        
    }
    
    func YTTheaderDisDidSelected(section: Int) {
        let shopItem = goodsList[section]
        shopItem.isSelected = false
        selBtn.isSelected = false
        for item in shopItem.goodsList! {
            if item.isSelected {
                item.isSelected = false
                totalMoney = totalMoney - Float(item.goodsPrice!)! * Float(item.goodsCount!)!
                totalPriceLabel.text = "\(totalMoney)"
            }
        }
        tableView.reloadData()
    }
    

}

extension YTTShoppingCartController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (goodsList[section].goodsList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: YTTShoppingCartCell = tableView.YTTdequeueOrInitCell(nibName: "YTTShoppingCartCell", identifier: "YTTShoppingCartCell") as! YTTShoppingCartCell
        cell.YTTsetItem(indexPath: indexPath, goodsItem: (goodsList[indexPath.section].goodsList?[indexPath.row])!, delegate: self)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return YTTShoppingCartHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40), section: section, shopItem: goodsList[section], delegate: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let goodsItem = goodsList[indexPath.section].goodsList?[indexPath.row]
            if (goodsItem?.isSelected)! {
                totalMoney = totalMoney - Float((goodsItem?.goodsPrice!)!)! * Float((goodsItem?.goodsCount!)!)!
                totalPriceLabel.text = "\(totalMoney)"
                totalGoods = totalGoods - Int((goodsItem?.goodsCount)!)!
                jsBtn.setTitle("结算(\(totalGoods))", for: .normal)
            }
            
            
            goodsList[indexPath.section].goodsList?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if goodsList[indexPath.section].goodsList?.count == 0 {
                goodsList.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

}



extension UITableView {
    func YTTdequeueOrInitCell(nibName: String, identifier:String) -> UITableViewCell {
        // 需要在 xib 设置 Identifier
        var cell = self.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first! as? UITableViewCell
            cell?.selectionStyle = .none
        }
        return cell!
    }

}




