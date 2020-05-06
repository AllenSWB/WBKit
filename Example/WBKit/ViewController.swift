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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

