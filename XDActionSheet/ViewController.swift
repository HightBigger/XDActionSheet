//
//  ViewController.swift
//  XDActionSheet
//
//  Created by chenyixing on 2017/6/2.
//  Copyright © 2017年 chenyixing. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,XDActionSheetViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let Btn = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        Btn.setTitle("显示取消按钮", for:.normal)
        Btn.backgroundColor = UIColor.blue
        Btn.tag = 1
        Btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        self.view.addSubview(Btn)
        
        let cancelBtn = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        
        cancelBtn.setTitle("不显示取消按钮", for:.normal)
        cancelBtn.backgroundColor = UIColor.blue
        cancelBtn.tag = 2
        cancelBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        self.view.addSubview(cancelBtn)

    }

    func btnClick(_ sender:UIButton){
        
        let array = ["哈哈哈","呵呵呵","嘿嘿嘿"]
        let ActionSheet = XDActionSheetView()
        
        switch sender.tag {
        case 1:
            ActionSheet.initWithTitleArrayAndShowCancel(titleArr: array, show: true)
            
            
            break
        case 2:
            ActionSheet.initWithTitleArrayAndShowCancel(titleArr: array, show: false)
            
            
            break
        default:
            break
            
        }
        
        ActionSheet.frame = self.view.bounds
        ActionSheet.backgroundColor = UIColor.gray
        ActionSheet.delegate = self
        self.view.addSubview(ActionSheet)
        
        
    }
    
    
    internal func actionSheetDidSelsctedButtonAtIndex(actionSheet: XDActionSheetView, buttonIndex: NSInteger) {
        
        print(buttonIndex)
    }


}

