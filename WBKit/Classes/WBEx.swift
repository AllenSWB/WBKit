//
//  WBEx.swift
//  WBKit
//
//  Created by wb on 2020/5/6.
//

import Foundation

// 系统类的扩展

// MARK: 安全存取方法

public extension Array {
    mutating func obj_wb(_ at: Int) -> Element? {
        if count > at {
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
        return frame.size
    }

    func origin_wb() -> CGPoint {
        return frame.origin
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
        return UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1)
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
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view: UIView in subviews[0].subviews {
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

 

// MARK: Date 日期
public extension Date {
    func toString_wb(f: String = "yyyy-MM-dd") -> String {
        /*
         G: 公元时代，例如AD公元
         aa: 上下午，AM/PM
         S：毫秒
         
         [dateStringFormatter setDateFormat:@"y"]; // 2017
         [dateStringFormatter setDateFormat:@"yy"]; // 17
         [dateStringFormatter setDateFormat:@"yyy"]; // 2017
         [dateStringFormatter setDateFormat:@"yyyy"]; // 2017

         [dateStringFormatter setDateFormat:@"M"]; // 8
         [dateStringFormatter setDateFormat:@"MM"]; // 08
         [dateStringFormatter setDateFormat:@"MMM"]; // 8月
         [dateStringFormatter setDateFormat:@"MMMM"]; // 八月

         [dateStringFormatter setDateFormat:@"d"]; // 3
         [dateStringFormatter setDateFormat:@"dd"]; // 03
         [dateStringFormatter setDateFormat:@"D"]; // 215,一年中的第几天

         [dateStringFormatter setDateFormat:@"h"]; // 4
         [dateStringFormatter setDateFormat:@"hh"]; // 04
         [dateStringFormatter setDateFormat:@"H"]; // 16 24小时制，0-23
         [dateStringFormatter setDateFormat:@"HH"]; // 16
         [dateStringFormatter setDateFormat:@"K"]; // K：时，12小时制，0-11

         [dateStringFormatter setDateFormat:@"m"]; // 28
         [dateStringFormatter setDateFormat:@"mm"]; // 28
         [dateStringFormatter setDateFormat:@"s"]; // 57
         [dateStringFormatter setDateFormat:@"ss"]; // 04

         [dateStringFormatter setDateFormat:@"E"]; // 周四
         [dateStringFormatter setDateFormat:@"EEEE"]; // 星期四
         [dateStringFormatter setDateFormat:@"EEEEE"]; // 四
         [dateStringFormatter setDateFormat:@"e"]; // 5 (显示的是一周的第几天（weekday），1为周日。)
         [dateStringFormatter setDateFormat:@"ee"]; // 05
         [dateStringFormatter setDateFormat:@"eee"]; // 周四
         [dateStringFormatter setDateFormat:@"eeee"]; // 星期四
         [dateStringFormatter setDateFormat:@"eeeee"]; // 四

         [dateStringFormatter setDateFormat:@"z"]; // GMT+8
         [dateStringFormatter setDateFormat:@"zzzz"]; // 中国标准时间

         [dateStringFormatter setDateFormat:@"ah"]; // 下午5
         [dateStringFormatter setDateFormat:@"aH"]; // 下午17
         [dateStringFormatter setDateFormat:@"am"]; // 下午53
         [dateStringFormatter setDateFormat:@"as"]; // 下午52
         */
        let format = DateFormatter.init()
        format.dateFormat = f
        let result = format.string(from: self)
        return result
    }
}
