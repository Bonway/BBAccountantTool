//
//  BBUserBirthdayView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/25.
//  Copyright © 2018年 Bonway. All rights reserved.
//  

import UIKit

@IBDesignable
class BBUserBirthdayView: UIView {
    
    var canleBtnBlock: (() -> ())?
    var sureBtnBlock:((String) -> ())?
    
    var birthdayString : String = ""{
        didSet {
            
            if birthdayString != "" {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                datePickerView.setDate(formatter.date(from: birthdayString)!, animated: true)
            }else{
                
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                birthdayString = formatter.string(from: Date())
                
            }
            
        }
        
    }
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBAction func canleClick(_ sender: Any) {
        canleBtnBlock!()
    }
    
    @IBAction func sureClick(_ sender: Any) {
        sureBtnBlock!(birthdayString)
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        contentView = loadViewFromNib()  //从xib中加载视图
        contentView.frame = bounds
        addSubview(contentView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        contentView.frame = bounds
        addSubview(contentView)
        setup()
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
    
    private func setup() {
        
        datePickerView.maximumDate = NSDate() as Date
        datePickerView.addTarget(self, action: #selector(chooseDate(datePicker:)), for:UIControlEvents.valueChanged)
        
    }
    
    @objc private func chooseDate(datePicker:UIDatePicker) {
        let  chooseDate = datePicker.date
        let  dateFormater = DateFormatter.init()
        dateFormater.dateFormat = "YYYY-MM-dd"
        birthdayString = dateFormater.string(from: chooseDate)
//        print(dateFormater.string(from: chooseDate))
    }
}



