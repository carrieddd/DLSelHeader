//
//  ViewController.swift
//  DLSelHead
//
//  Created by iOS110 on 2018/5/23.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let qunima = DLSelecterView.init(titles: ["aa","bb","cc"],frame: CGRect.init(x: 0, y: 64, width: dScreenW, height: 44))
        self.view.addSubview(qunima)
        qunima.type = .average
        qunima.index = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

