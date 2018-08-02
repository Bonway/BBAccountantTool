//
//  BBUserAddressView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserAddressView: UIView {

    
    var canleBtnBlock: (() -> ())?
    var sureBtnBlock:((String,String) -> ())?
    
    var province : String = "" {
        didSet {
            let count = model?.data.count ?? 0
            for i in 0..<count {
                
                if model?.data[i].name == self.province {
                    leftRow = i
                    pickerView.selectRow(leftRow, inComponent: 0, animated: true)
                }
            }
            
        }
    }
    var city : String = "" {
        didSet {
            let count = model?.data[leftRow].second.count ?? 0
            for i in 0..<count {
                if model?.data[leftRow].second[i].name == self.city {
                    pickerView.selectRow(i, inComponent: 1, animated: true)
                }
            }
            
        }
    }
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var leftRow: Int = 0
    
    var model: BBUserPersonAddressModel? {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        contentView = loadViewFromNib()  //从xib中加载视图
        contentView.frame = bounds
        addSubview(contentView)
//        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        contentView.frame = bounds
        addSubview(contentView)
//        setup()
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

    
    @IBAction func canleClick(_ sender: Any) {
        canleBtnBlock!()
    }
    
    @IBAction func sureClick(_ sender: Any) {
        sureBtnBlock!(province,city)
    }
    
    
}


extension BBUserAddressView: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return model?.data.count ?? 0
            
        }
        
        if component == 1 {
            return model?.data[leftRow].second.count ?? 0
        }
        
        return 0
        
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
        genderLabel.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        genderLabel.textColor = BBColor(rgbValue: 0x333333)
        if component == 0 {
            genderLabel.text = model?.data[row].name
        }else{
            genderLabel.text = model?.data[leftRow].second[row].name
        }
        return genderLabel
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0){
            
            leftRow = pickerView.selectedRow(inComponent: 0)
            pickerView.reloadComponent(1)
        }
        province = model?.data[leftRow].name ?? ""
        city = model?.data[leftRow].second[pickerView.selectedRow(inComponent: 1)].name ?? ""
    }
    
}
//
//extension BBUserAddressView: {
//
//}





