//
//  YTTShoppingCartCell.swift
//  YiFangTianXia
//
//  Created by Andy on 2017/7/6.
//  Copyright © 2017年 YFTX. All rights reserved.
//

import UIKit

protocol YTTShoppingCartCellDelegate: NSObjectProtocol {
    
    func YTTdidSelected(indexPath: IndexPath!) -> Void;
    
    func YTTdidDisSelected(indexPath: IndexPath!) -> Void;
    
    func YTTdidAddGoods(indexPath: IndexPath!) -> Void;
    
    func YTTdidSubGoods(indexPath: IndexPath!) -> Void;


}


class YTTShoppingCartCell: UITableViewCell {

    @IBOutlet weak var selBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var classLabel: UILabel!
    
    private  var indexPath: IndexPath?
    
    private weak var delegate: YTTShoppingCartCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func YTTsetItem(indexPath: IndexPath, goodsItem: YTTShoppingCartGoodsItem, delegate: YTTShoppingCartCellDelegate) -> Void {
        self.indexPath = indexPath
        self.delegate = delegate
        
        selBtn.isSelected = goodsItem.isSelected
        titleLabel.text = goodsItem.goodsName
        priceLabel.text = goodsItem.goodsPrice
        numberLabel.text = goodsItem.goodsCount
        
        
    }
    
    
    @IBAction func YTTselectedAction(_ sender: UIButton) {        
        if !sender.isSelected {
            delegate?.YTTdidSelected(indexPath: indexPath)
        }else {
            delegate?.YTTdidDisSelected(indexPath: indexPath)
        }
        
    }
    
    @IBAction func YTTsubGoodsAction(_ sender: Any) {
        
        if numberLabel.text == "0" {
            return
        }
        delegate?.YTTdidSubGoods(indexPath: indexPath)
    }
    
    
    @IBAction func YTTaddGoodsAction(_ sender: Any) {
        delegate?.YTTdidAddGoods(indexPath: indexPath)
    }
    

    
       
}
