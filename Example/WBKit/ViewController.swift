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
        
        print("重用标识符：" + TestTableViewCell.wb_identifier())
         
        self.view.backgroundColor = UIColor.random_wb()

        
        let green = WBKit.getViewFromXib(with: TESTV())
        self.view.addSubview(green)
        green.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
      
        
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

