//
//  BBUserSexPickerView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/25.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

@IBDesignable
class BBUserSexPickerView: UIView {
    
    var canleBtnBlock: (() -> ())?
    var sureBtnBlock:((String) -> ())?
    
    var sexString : String = ""{
        didSet {
            setupView()
        }
        
    }
    @IBOutlet var contentView: UIView!
    @IBAction func canleClick(_ sender: Any) {
        canleBtnBlock!()
    }
    
    @IBAction func sureClick(_ sender: Any) {
        sureBtnBlock!(sexString)
    }
    @IBOutlet weak var pickerView: UIPickerView!
    private let cellInfo = ["女","男","保密"]
    
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
    
    private func setupView() {
        if sexString == "女" {
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }else if sexString == "男" {
            pickerView.selectRow(1, inComponent: 0, animated: true)
        }else {
            pickerView.selectRow(2, inComponent: 0, animated: true)
        }
        
    }
}

extension BBUserSexPickerView : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 39
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        for singleLine in pickerView.subviews {
            if singleLine.height < 1 {
                singleLine.backgroundColor = BBColor(rgbValue: 0xdddddd)
            }
        }
        
        let genderLabel = UILabel();
        genderLabel.textAlignment = .center;
        genderLabel.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
        genderLabel.text = cellInfo[row]
        genderLabel.textColor = BBColor(rgbValue: 0x333333)
        return genderLabel
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexString = cellInfo[row]
    }
}



