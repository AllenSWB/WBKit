//
//  ViewController.swift
//  WBKit
//
//  Created by allenswb on 05/06/2020.
//  Copyright (c) 2020 allenswb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = UIImage(color_wb: UIColor(hex_wb: "ff5500")!)
        
        print("重用标识符：" + TestTableViewCell.reuseIdentifier())
         
        self.view.backgroundColor = UIColor.random_wb()

        
        let green = WBUIHelper.getViewFromXib(with: TESTV())
        self.view.addSubview(green)
        green.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        
        print("是否刘海屏: \(WBUIHelper.hasNotch() ? "是" : "否")")
        print("导航栏高度:\(WBUIHelper().navH)")
        print("底部安全区域高度:\(WBUIHelper().bottomH)")
        
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

