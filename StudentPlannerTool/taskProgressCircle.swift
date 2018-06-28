//
//  taskProgressCircle.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 20/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import Foundation
import UIKit


class taskProgressCircle: UIView {
    
    
    var percentage: Double?
    
    
    let shapeLayer = CAShapeLayer()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "70%"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 9)
        return label
    }()
    
    
    override func draw(_ rect: CGRect) {
        
        var multiplier: CGFloat = 0.85
        var center: CGPoint {
            return CGPoint(x:bounds.midX, y:bounds.midY)
        }
        
        var halfOfViewsSize: CGFloat {
            return min(bounds.size.height, bounds.size.width) / 2 * multiplier
        }
        
        
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: halfOfViewsSize, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(red:0.24, green:0.24, blue:0.24, alpha:1.0).cgColor
        trackLayer.lineWidth = 7
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor //remove black background
        self.layer.addSublayer(trackLayer)
        
        
        
        
        //let circularPath = UIBezierPath(arcCenter: center, radius: halfOfViewsSize, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red:1.00, green:0.21, blue:0.38, alpha:1.0).cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor //remove black background
        
        shapeLayer.strokeEnd = 0
        self.layer.addSublayer(shapeLayer)
        
        self.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x:5, y:3, width:50, height: 50)
        

        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 0.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = percentage
        animateStrokeEnd.fillMode = kCAFillModeForwards
        animateStrokeEnd.isRemovedOnCompletion = false
        shapeLayer.add(animateStrokeEnd, forKey: "animate stroke end animation")
    }
    
    
    //private func
    
    
}
