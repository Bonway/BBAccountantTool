//
//  BBShareView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/29.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import pop

class BBShareView: UIView {

    @IBOutlet weak var maskShareView: UIView!
    @IBOutlet weak var bottomBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var itemView: UIView!
    
    //    @IBOutlet weak var bottomBtnHeight: NSLayoutConstraint!
    //    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        backgroundColor = UIColor.green
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    /// 按钮数据数组
    private let buttonsInfo = [["imageName": "index_share_wx", "title": "微信"],
                               ["imageName": "index_share_pyq", "title": "朋友圈"],
                               ["imageName": "index_share_bcct", "title": "保存图片"],
                               ["imageName": "index_share_fzlj", "title": "复制链接"]]
    /// 完成回调
    private var completionBlock: ((_ clsName: String?)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemViewClick))
        
        maskShareView.addGestureRecognizer(tapRecognizer)
        bottomBtnHeight.constant = bbTabBarHeight
    }
    
    
    class func shareView() -> BBShareView {
        
        let nib = UINib(nibName: "BBShareView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! BBShareView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        
        return v
    }
    
    
    /// OC 中的 block 如果当前方法，不能执行，通常使用属性记录，再需要的时候执行
    func show(completion:  @escaping (_ clsName: String?)->()) {
    
        // 0> 记录闭包
        completionBlock = completion
        // 1> 将当前视图添加到 根视图控制器的 view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        // 2> 添加视图
        vc.view.addSubview(self)
        // 3> 开始动画
        showCurrentView()
    }
    
    @IBAction func close(_ sender: UIButton) {
        hideButtons()
    }
    
    @objc private func itemViewClick() {
        hideButtons()
    }
    
    // MARK: - 监听方法
    @objc private func clickButton(selectedButton: WBComposeTypeButton) {
        
        // 1. 判断当前显示的视图
        let v = itemView.subviews[0]
        // 2. 遍历当前视图
        // - 选中的按钮放大
        // - 为选中的按钮缩小
        for (i, btn) in v.subviews.enumerated() {
            // 1> 缩放动画
            let scaleAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            // x,y 在系统中使用 CGPoint 表示，如果要转换成 id，需要使用 `NSValue` 包装
            let scale = (selectedButton == btn) ? 2 : 0.2
            scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnim.duration = 0.3
            btn.pop_add(scaleAnim, forKey: nil)
            // 2> 渐变动画 - 动画组
            let alphaAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.3
            btn.pop_add(alphaAnim, forKey: nil)
            // 3> 添加动画监听
            if i == 0 {
                alphaAnim.completionBlock = { _, _ in
                    // 需要执行回调
                    print("完成回调展现控制器")
                    // 执行完成闭包
                    self.completionBlock?(selectedButton.titleLabel.text)
                }
            }
        }
    }
}


// MARK: - 动画方法扩展
private extension BBShareView {
    
    // MARK: - 消除动画
    /// 隐藏按钮动画
    private func hideButtons() {
        
        // 1. 根据 contentOffset 判断当前显示的子视图
        let v = itemView.subviews[0]
        // 2. 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated().reversed() {
            // 1> 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            // 2> 设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i - 1) * 0.05
            // 3> 添加动画
            btn.layer.pop_add(anim, forKey: nil)
            // 4> 监听第 0 个按钮的动画，是最后一个执行的
            self.hideCurrentView()
        }
    }
    
    /// 隐藏当前视图
    private func hideCurrentView() {
        // 1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.5
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        // 3> 添加完成监听方法
        anim.completionBlock = { _, _ in
            self.removeFromSuperview()
        }
    }
    
    
    /// 动画显示当前视图
    private func showCurrentView() {
        
        // 1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        // 3> 添加按钮的动画
        showButtons()
    }
    
    /// 弹力显示所有的按钮
    private func showButtons() {
        
        // 1. 获取 scrollView 的子视图的第 0 个视图
        let v = itemView.subviews[0]
        // 2. 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated(){
            // 1> 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            // 2> 设置动画属性
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y

            // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
            anim.springBounciness = 10
            // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
            anim.springSpeed = 8
            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            // 3> 添加动画
            btn.pop_add(anim, forKey: nil)
        }
    }
}
private extension BBShareView {
    
    func setupUI() {
        // 0. 强行更新布局
        layoutIfNeeded()
        // 1. 向 ItemView 添加视图
        let rect = itemView.bounds
        let width = itemView.bounds.width
        for i in 0..<4 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            // 2. 向视图添加按钮
            addButtons(v: v, idx: i * 4)
            // 3. 将视图添加到 ItemView
            itemView.addSubview(v)
        }
        
    }
    
    /// 向 v 中添加按钮，按钮的数组索引从 idx 开始
    func addButtons(v: UIView, idx: Int) {
        
        let count = 4
        // 1. 从 idx 开始，添加 4 个按钮
        for i in idx..<(idx + count) {
            
            if i >= buttonsInfo.count {
                break
            }
            
            // 0> 从数组字典中获取图像名称和 title
            let dict = buttonsInfo[i]
            
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            // 1> 创建按钮
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            // 2> 将 btn 添加到视图
            v.addSubview(btn)
            // 3> 添加监听方法
            if let actionName = dict["actionName"] {
                // OC 中使用 NSSelectorFromString(@"clickMore")
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            }
            
            // 4> 设置要展现的类名 - 注意不需要任何的判断，有了就设置，没有就不设置
            btn.clsName = dict["clsName"]
        }
        
        // 2. 遍历视图的子视图，布局按钮
        // 准备常量
        let btnSize = CGSize(width: 70, height: 70)
        let margin = (v.bounds.width - 4 * btnSize.width) / 5
        
        for (i, btn) in v.subviews.enumerated() {
            
            let y: CGFloat = 50     //(i > 3) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 4
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}

