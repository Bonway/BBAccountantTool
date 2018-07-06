//
//  THUD.swift
//  HttpRequest
//
//  Created by jin on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//
import MBProgressHUD
import Foundation
//import MBProgressHUD+Extension

class TAlert: NSObject {
    enum AlertType {
        case success
        case info
        case error
        case warning
    }
    
    class func show(type: AlertType, text: String) {
        if let window = UIApplication.shared.delegate?.window {
            var image: UIImage
            switch type {
            case .success:
                image = UIImage(named: "home_index_done")!
            case .info:
                image = UIImage(named: "network")!
            case .error:
                image = UIImage(named: "network")!
            case .warning:
                image = UIImage(named: "network")!
            }
            let hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            hud.mode = .customView
            hud.customView = UIImageView(image:image)
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 2.0)
            hud.bezelView.alpha = 0.9
            hud.bezelView.color = UIColor.black
            hud.label.font = UIFont.systemFont(ofSize: 14)
            hud.label.textColor = UIColor.white

        }
    }
}

class TProgressHUD {
    class func show() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.showProgress(window)
        }
    }
    
    class func hide() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.hide(for: window!, animated: true)
        }
    }
}
