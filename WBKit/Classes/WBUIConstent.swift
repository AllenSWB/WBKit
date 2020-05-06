//
//  WBUIConstent.swift
//  WBKit
//
//  Created by wb on 2020/5/6.
//

import Foundation
 
public var wbScreenW = UIScreen.main.bounds.width
public var wbScreenH = UIScreen.main.bounds.height

/// 是否是刘海屏
public func hasNotch_wb() -> Bool {
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

/// 安全区域导航栏高度
public func navH_wb() -> CGFloat {
    return hasNotch_wb() == true ? 88.0 : 64.0
}

/// 安全区域底部高度
public func bottomH_wb() -> CGFloat {
    return hasNotch_wb() == true ? 34.0 : 0
}
