//
//  BBUserSetVersionView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

@IBDesignable
class BBUserSetVersionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var canleBtnBlock: (() -> ())?
    var sureBtnBlock:(() -> ())?
    
    
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        contentView = loadViewFromNib()  //从xib中加载视图
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    

}


extension BBUserSetVersionView {
    
    @IBAction func updateClick(_ sender: Any) {
        sureBtnBlock!()
    }
    
    @IBAction func canleClick(_ sender: Any) {
        canleBtnBlock!()
    }
}
