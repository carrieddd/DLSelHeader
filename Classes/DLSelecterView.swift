//
//  DLSelectierView.swift
//  dongliangHead
//
//  Created by iOS110 on 2018/5/18.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLselecterDelegate {
    func selecterViewSelectItem(index:Int);
    
}
let LinePadding:CGFloat = CGFloat(4)
let ItemPadding:CGFloat = CGFloat(8)
let LineHigh:CGFloat = CGFloat(2)

public class qunima:NSObject{
    public class func log(){
        print("qunimaqunimaqunima")
    }
}

public class DLSelecterView: UIView {

    var delegate:DLselecterDelegate?
    
    
    enum selecter {
        case average
        case onebyone
    }
    private var _items:[String]?
    var items:[String]{
        get{
            return _items!
        }
        set{
            _items = newValue
            initSubview()
        }
    }
    
    private var _type:selecter = .onebyone
    var type:selecter {
        get{
            return _type
        }
        set{
            _type = newValue
            self.reframeItems()
        }
        
    }
    
    private var _index:Int = 0
    var index:Int{
        get{
            return _index
        }
        set{
            _index = newValue
            let tempFrame = item_btns[newValue].frame
            selectedLine.frame = CGRect.init(x: tempFrame.minX + LinePadding, y: tempFrame.height, width: tempFrame.width - LinePadding - LinePadding, height: LineHigh)
        }
    }
    
    let contentScroll = DLBaseScrollView()
    var selectedLine:CALayer = {
        $0.backgroundColor = UIColor.red.cgColor
        return $0
    }(CALayer())
    
    private var item_btns:[DLBaseButton] = []
    
    init(titles:[String],frame:CGRect) {
        super.init(frame: frame)
        self.items = titles
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    private func initSubview(){
        item_btns.removeAll()
        items.forEach { [weak self](itemStr) in
            let item_btn = DLBaseButton.init(handle: { (sender) in
                self?.delegate?.selecterViewSelectItem(index: sender.tag)
                var tempFrame = self?.selectedLine.frame
                tempFrame?.origin.x = sender.frame.minX + LinePadding
                self?.selectedLine.frame = tempFrame ?? .zero
                self?.index = sender.tag
            })
            item_btn.setTitle(itemStr, for: .normal)
            item_btns.append(item_btn)
        }
    
        reframeItems()
    }
    
    //configure Frame
    private func reframeItems(){
        guard items.count > 0 else {
            return
        }
        let heigh = self.frame.size.height - LineHigh
        
        contentScroll.frame = super.bounds
        self.addSubview(contentScroll)
        
        for (index,item_btn) in item_btns.enumerated() {
            item_btn.removeFromSuperview()
            item_btn.tag = index
            
            switch type {
            
            case .average:
                let width = dScreenW/CGFloat(items.count)
                item_btn.frame = CGRect.init(x: CGFloat(index) * width, y: CGFloat(0), width: width, height: heigh)
                
            case .onebyone:
                item_btn.sizeToFit()
                let width = item_btn.frame.size.width
                let lastIndex = index == 0 ? index : index - 1
                let x = index == 0 ? ItemPadding:item_btns[lastIndex].frame.maxX + ItemPadding
                item_btn.frame = CGRect.init(x:x, y: CGFloat(0), width: width, height: heigh)
                
//            default: break
            }
            contentScroll.addSubview(item_btn)
        }

        contentScroll.contentSize = CGSize.init(width: item_btns.last?.frame.maxX ?? 0, height: heigh)
        
        let tempFrame = item_btns[index].frame
        selectedLine.frame = CGRect.init(x: tempFrame.minX + LinePadding, y: tempFrame.height, width: tempFrame.width - LinePadding - LinePadding, height: LineHigh)
        contentScroll.layer.addSublayer(selectedLine)
    }
}
