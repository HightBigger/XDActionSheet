//
//  XDActionSheetView.swift
//  XDActionSheet
//
//  Created by xiaoda on 2017/6/2.
//  Copyright © 2017年 xiaoda. All rights reserved.
//

import UIKit

let CELL_HEIGHT:CGFloat = 50;
let CELL_SPACE :CGFloat = 5;

protocol  XDActionSheetViewDelegate:NSObjectProtocol{
    func actionSheetDidSelsctedButtonAtIndex(actionSheet :XDActionSheetView,buttonIndex:NSInteger)
}


class XDActionSheetView: UIView {
    
    var titleArray : Array<Any>?
    var btnView : UIView?
    var show : Bool = true
    
    var delegate:XDActionSheetViewDelegate?
    
    lazy var btnBackView:UIView = {
    
        let btnBackView = UIView()
        btnBackView.backgroundColor = UIColor.gray
        return btnBackView
    }()
}
extension XDActionSheetView{
    
    func initWithTitleArrayAndShowCancel(titleArr:Array<Any>,show:Bool) {
        
        self.frame = UIScreen.main.bounds
        self.alpha = 0.8
        titleArray = titleArr;
        self.show = show
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hiddenSheet))
        self.addGestureRecognizer(tap)
        
        setUpUI()
        
    }
    
}
extension XDActionSheetView{
    
    func setUpUI() -> Void {
        
        let size = UIScreen.main.bounds.size
        var bgHeight :CGFloat = 0
        
        if show {
            bgHeight = CELL_HEIGHT * CGFloat(titleArray!.count) + CELL_HEIGHT + CELL_SPACE
        }else
        {
            bgHeight = CELL_HEIGHT*CGFloat(titleArray!.count)
        }
        
        self.btnBackView.frame = CGRect(x: 0, y: size.height, width: size.width, height: bgHeight)
        self.addSubview(self.btnBackView)
        
        let bgWidth = self.btnBackView.frame.size.width
        
        for i in 0..<Int((titleArray?.count)!) {
            let BtnX:CGFloat = 0
            var BtnY:CGFloat = 0
            
            if show {
                BtnY = (bgHeight - CELL_HEIGHT - CELL_SPACE - CELL_HEIGHT*CGFloat(i+1));
            }else
            {
                BtnY = bgHeight - CELL_HEIGHT*CGFloat(i+1);
            }
            
            let btnW = bgWidth
            let btnH = CELL_HEIGHT - 0.5;
            let btn = UIButton(type: UIButton.ButtonType.custom)
            
            btn.setTitle(titleArray?[i] as! String?, for: .normal)
            btn.backgroundColor=UIColor.white
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.frame=CGRect(x: BtnX, y: BtnY, width: btnW, height: CGFloat(btnH));
            
            btn.tag = i+1;
            btn.addTarget(self, action:#selector(buttonAtion(_:)), for: .touchUpInside)
            self.btnBackView.addSubview(btn)
        }
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(hiddenSheet), for: .touchUpInside)
        
        btn.tag = 0;
        btn.frame = CGRect(x: CGFloat(0), y: bgHeight - CGFloat(CELL_HEIGHT), width: bgWidth, height: CGFloat(CELL_HEIGHT))
        self.btnBackView.addSubview(btn)
        btn.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            var frame = self.btnBackView.frame;
            frame.origin.y =  size.height - frame.size.height;
            self.btnBackView.frame = frame;
        }

    }
    
}

extension XDActionSheetView{
    
    @objc func buttonAtion(_ sender:UIButton){
        if (delegate != nil) {
            delegate?.actionSheetDidSelsctedButtonAtIndex(actionSheet:self, buttonIndex:sender.tag )
        }
        hiddenSheet()
    }
}
extension XDActionSheetView{
    @objc func hiddenSheet() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.btnBackView.frame;
            frame.origin.y = UIScreen.main.bounds.size.height;
            self.btnBackView.frame = frame;
            
        }) { (Bool) in
            self.removeFromSuperview()
        }
        
    }
    
}
