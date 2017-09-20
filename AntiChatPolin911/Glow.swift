//
//  Glow.swift
//  AntiChatPolin911
//
//  Created by Polina on 19.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//
import UIKit
import Foundation
import QuartzCore

@IBDesignable
class GlowingLabel: UILabel {
    
    @IBInspectable
    var blurColor :UIColor = UIColor(red: 104.0,green: 248.0,blue: 0,alpha: 0.7){
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable
    var glowSize :CGFloat = 25.0
    
    
    override func drawText(in rect: CGRect) {
        
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setShadow(offset: CGSize(width: 0, height: 0)
                , blur: self.glowSize
                , color: self.blurColor.cgColor)
            
            ctx.setTextDrawingMode(.fillStroke)
        }
        
        super.drawText(in: rect)
    }
    
}
@IBDesignable
class CustomBorderButton: UIButton  {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

