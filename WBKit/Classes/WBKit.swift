//
//  WBKit.swift
//  WBKit
//
//  Created by wb on 2020/7/31.
//

import Foundation
import UIKit

public class WBKit {
}

// MARK: 屏幕宽高

public extension WBKit {
    /// 宽度 参考6s
    class func scaleW(value: CGFloat) -> CGFloat {
        let r = WBKit.width() / 375.0 * value
        return r
    }

    /// 高度 参考6s
    class func scaleH(value: CGFloat) -> CGFloat {
        let r = WBKit.height() / 667.0 * value
        return r
    }

    /// 全屏bounds
    class func bounds() -> CGRect {
        return UIScreen.main.bounds
    }

    /// 全屏宽
    class func width() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

    /// 全屏高
    class func height() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    /// 版本号
    class func versionCheck() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let majorVersion: AnyObject? = infoDictionary?["CFBundleShortVersionString"] as AnyObject? // 主程序版本号
        let appVersion = majorVersion as! String
        return appVersion
    }

    /// 是否是刘海屏
    class func hasNotch() -> Bool {
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

    // 导航栏高度
    static var kNavigationBarHeight: CGFloat {
        return WBKit.hasNotch() ? 88 : 64
    }

    // 底部安全区域高度
    static var kBottomSafeHeight: CGFloat {
        return WBKit.hasNotch() ? 34 : 0
    }

    // 状态栏高度
    static var kTopSafeHeight: CGFloat {
        return hasNotch() ? 40.0 : 20.0
    }

    // 内容区域高度 - 二级页面，刨除导航栏和底部安全区域
    static var kSafeContentHeight: CGFloat {
        return WBKit.height() - kBottomSafeHeight - kNavigationBarHeight
    }

    // 内容区域高度 - 去除状态栏高度
    static var kHeightWithoutStatusBar: CGFloat {
        return WBKit.height() - kTopSafeHeight
    }
}

// MARK: 故事版 & xib

public extension WBKit {
    /// 获取从xib创建的视图
    class func getViewFromXib<T: UIView>(with cls: T) -> T {
        let s = String(describing: type(of: cls))
        let v = Bundle.main.loadNibNamed(s, owner: nil, options: nil)?.last! as! T
        return v
    }

    /// 从storyboard获取控制器
    class func getVCFromStoryboard(storyboard: String, vcIdentifier: String) -> UIViewController {
        let vc = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: vcIdentifier)
        return vc
    }
}

// MARK: 沙盒路径

extension WBKit {
    enum WBSandboxFolder {
        case home
        case documents
        case library
        case cache
        case tmp
    }

    func wb_sandboxMethod() -> ((WBSandboxFolder) -> (String)) {
        return wb_sandbox(_:)
    }

    func wb_sandbox(_ folder: WBSandboxFolder = .documents) -> String {
        let path: String?
        switch folder {
        case .home:
            path = NSHomeDirectory()
        case .documents:
            path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        case .library:
            path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        case .cache:
            path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        case .tmp:
            path = NSTemporaryDirectory()
        }
        if let p = path {
            return p
        } else {
            return NSHomeDirectory()
        }
    }
}
