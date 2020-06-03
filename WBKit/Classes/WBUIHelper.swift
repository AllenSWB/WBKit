//
//  WBUIHelper.swift
//  WBKit
//
//  Created by wb on 2020/6/3.
//

import UIKit

public class WBUIHelper: NSObject {
    /// 屏幕宽
    public var wbScreenW = UIScreen.main.bounds.width
    /// 屏幕高
    public var wbScreenH = UIScreen.main.bounds.height
    /// 安全区域底部高度
    public lazy var bottomH: CGFloat = {
        var h: CGFloat = 0
        if WBUIHelper.hasNotch() {
            h += 34
        }
        return h
    }()
    /// 安全区域导航栏高度
    public lazy var navH: CGFloat = {
        var h: CGFloat = 64;
        if WBUIHelper.hasNotch() {
            h = 88.0
        }
        return h
    }()
    
    /// 获取从xib创建的视图
    public class func getViewFromXib<T:UIView>(with cls: T) -> T {
        let s = String(describing: type(of: cls))
        let v = Bundle.main.loadNibNamed(s, owner: nil, options: nil)?.last! as! T
        return v
    }
    
    /// 是否是刘海屏
    public class func hasNotch() -> Bool {
        if #available(iOS 11, *) {
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }

              if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                  print(unwrapedWindow.safeAreaInsets)
                  return true
              }
        }
        return false
    }
     
}
