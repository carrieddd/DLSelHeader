//
//  DLBaseUIKit.swift
//  dongliangHead
//
//  Created by iOS110 on 2018/5/18.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

let dScreenH = UIScreen.main.bounds.size.height
let dScreenW = UIScreen.main.bounds.size.width

class DLBaseUIKit: UIView {
}
class DLBaseScrollView: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DLBaseButton: UIButton {
    typealias ClickHandle = (UIButton) -> Void
    var clickHandle:ClickHandle?

    init() {
        super.init(frame: .zero)
        _setup()
    }
    
    init(handle:@escaping ClickHandle) {
        super.init(frame: CGRect.zero)
        self.clickHandle = handle
        self.addTarget(self, action: #selector(_click), for: .touchUpInside)
        self._setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setup() {
        self.setTitleColor(.blue, for: .selected)
        self.setTitleColor(.gray, for: .normal)
    }
    
    @objc func _click() {
        if let clickHandle = clickHandle {
            clickHandle(self)
        }
    }
}
