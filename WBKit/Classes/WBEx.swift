//
//  WBEx.swift
//  WBKit
//
//  Created by wb on 2020/5/6.
//

import Foundation

// MARK: 安全存取方法

public extension Array {
    mutating func obj_wb(_ at: Int) -> Element? {
        if self.count > at {
            return self[at]
        }
        return nil
    }
}

public extension Dictionary {
    
}

// MARK: 获取 UIView 的宽高xy

public extension UIView {
    
    func size_wb() -> CGSize {
        return self.frame.size
    }
    
    func origin_wb() -> CGPoint {
        return self.frame.origin;
    }
    
    func w_wb() -> CGFloat {
        return size_wb().width
    }
    
    func h_wb() -> CGFloat {
        return size_wb().height
    }
    
    func x_wb() -> CGFloat {
        return origin_wb().x
    }
    
    func y_wb() -> CGFloat {
        return origin_wb().y
    }
    
}

// MARK: 颜色

public extension UIColor {
    /// hex 颜色
    convenience init?(hex_wb: String) {
        var hexSanitized = hex_wb.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    /// 随机颜色
    class func random_wb() -> UIColor {
        return UIColor.init(red: (CGFloat(arc4random()%255) / 255.0), green: (CGFloat(arc4random()%255) / 255.0), blue: (CGFloat(arc4random()%255) / 255.0), alpha: 1)
    }
    
}

// MARK: 创建有颜色的占位图
public extension UIImage {
    convenience init?(color_wb: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color_wb.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

// MARK: 获取 SearchBar 的输入框
public extension UISearchBar {

    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view: UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}

// MARK: 价格展示 123000 -> 123 000
public extension Numeric {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? String(describing: self)
    }
}

// MARK: 重用标识符 UITableViewCell
// 使用方法: tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
public protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}
public extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
