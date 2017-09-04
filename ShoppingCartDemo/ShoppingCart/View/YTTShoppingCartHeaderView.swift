//
//  YTTShoppingCartHeaderView.swift
//  YiFangTianXia
//
//  Created by Andy on 2017/7/7.
//  Copyright © 2017年 YFTX. All rights reserved.
//

import UIKit
import SnapKit

protocol YTTShoppingCartHeaderViewDelegate {
    func YTTheaderDidSelected(section: Int) -> Void ;
    func YTTheaderDisDidSelected(section: Int) -> Void ;

}

class YTTShoppingCartHeaderView: UIView {
    
    
    private var section: Int?
    private var delegate: YTTShoppingCartHeaderViewDelegate?
    
    
    init(frame: CGRect, section: Int, shopItem: YTTShoppingCartShopItem, delegate: YTTShoppingCartHeaderViewDelegate) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.section = section
        self.delegate = delegate
        
        let selBtn = UIButton(type: .custom)
        selBtn.isSelected = shopItem.isSelected
        self.addSubview(selBtn)
        
        selBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        
        
        
        
        
        selBtn.setImage(#imageLiteral(resourceName: "shoppingcart_xuanze-2"), for: .normal)
        selBtn.setImage(#imageLiteral(resourceName: "shoppingcart_xuanze-1"), for: .selected)
        selBtn.addTarget(self, action: #selector(YTTselBtnClick(_:)), for: .touchUpInside)
        
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 13)
        headerLabel.text = shopItem.shopName
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(selBtn.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        let imgView = UIImageView(image: #imageLiteral(resourceName: "shoppingcart_qianjin"))
        self.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(headerLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func YTTselBtnClick(_ sender: UIButton) -> Void {
        
        if sender.isSelected {
            delegate?.YTTheaderDisDidSelected(section: section!)
        }else {
            delegate?.YTTheaderDidSelected(section: section!)
        }
        
        
    }
    
}
