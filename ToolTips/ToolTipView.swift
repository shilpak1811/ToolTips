//
//  ToolTipView.swift
//  ToolTips
//
//  Created by Shilpa Kumari on 29/01/21.
//  Copyright © 2021 Shilpa Kumari. All rights reserved.
//

import UIKit

class ToolTipView: UIView {

    var roundRect: CGRect!
    var toolTipWidth: CGFloat = 20.0
    var toolTipHeight: CGFloat = 20.0
    var cornerRadius: CGFloat = 5.0
    
    convenience init(frame: CGRect, cornerRadius: CGFloat, text: String) {
        self.init(frame: frame)
        self.cornerRadius = cornerRadius
        createLabel(text)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawToolTip(rect)
    }
    
    private func getTipPath() -> UIBezierPath {
       
        let toolTipRect = CGRect(x: roundRect.midX-10, y: roundRect.maxY, width: toolTipWidth, height: toolTipHeight)
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: toolTipRect.minX, y: toolTipRect.minY))
        trianglePath.addLine(to: CGPoint(x: toolTipRect.maxX, y: toolTipRect.minY))
        trianglePath.addLine(to: CGPoint(x: toolTipRect.midX, y: toolTipRect.maxY))
        trianglePath.addLine(to: CGPoint(x: toolTipRect.minX, y: toolTipRect.minY))
        trianglePath.close()
        return trianglePath
    }
    
    private func drawToolTip(_ rect: CGRect) {
        roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height-toolTipHeight)
        let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: cornerRadius)
        let triangle = getTipPath()
        roundRectBez.append(triangle)
        let shape = getShapeLayer(roundRectBez.cgPath)
        self.layer.insertSublayer(shape, at: 0)
    }
    
    private func getShapeLayer(_ path: CGPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.black.cgColor
        
        shape.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        shape.shadowOffset = CGSize(width: 0, height: 2)
        shape.shadowRadius = cornerRadius
        shape.shadowOpacity = 0.8
        return shape
    }
    
    private func createLabel(_ text : String){
        let label = UILabel(frame: CGRect(x: 8, y: 5, width: frame.width-16, height: frame.height-toolTipHeight-10))
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        addSubview(label)
    }
}
