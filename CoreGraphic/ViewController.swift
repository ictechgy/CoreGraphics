//
//  ViewController.swift
//  CoreGraphic
//
//  Created by JINHONG AN on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: CustomButton!
    private var isRotated = false

    @IBAction func didTap() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.isAdditive = false
        if isRotated {
            animation.fromValue = Double.pi/4
            animation.toValue = 0
            //animation.byValue = -Double.pi/4
        } else {
            animation.fromValue = 0
            animation.toValue = Double.pi/4
            //animation.byValue = Double.pi/4
        }
        animation.duration = 0.1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        button.layer.add(animation, forKey: "rotate")
        //let originAffine = button.layer.affineTransform()
        if isRotated {
            //button.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
            //button.layer.setAffineTransform(CGAffineTransform(rotationAngle: 0)) //이것보다는 transform을 되돌리는 것으로 하자
            //button.layer.setAffineTransform(originAffine) 이것도 안됨
            button.layer.setAffineTransform(CGAffineTransform.identity) //어느 방향으로 돌아서 원래 형태가 되는가?
            isRotated = false
        } else {
            //button.layer.transform = CATransform3DMakeRotation(Double.pi/4, 0, 0, 1)
            button.layer.setAffineTransform(CGAffineTransform(rotationAngle: Double.pi/4))
            isRotated = true
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var circleStrokeColor = UIColor.systemOrange.cgColor
    @IBInspectable var circleStrokeWidth: CGFloat = 5
    @IBInspectable var plusStrokeColor = UIColor.systemRed.cgColor
    @IBInspectable var plusStrokeWidth: CGFloat = 5
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //circle -> arc를 가지고 그릴 수도 있다. 다만 뷰의 bound가 바뀌었을 때 그림이 변화하는 것은 다르다. arc는 원이 그대로 남아있어서 clipping됨
        context.beginPath()
        let circleBounds = CGRect(x: bounds.width * 0.25, y: bounds.height * 0.25, width: bounds.width * 0.5, height: bounds.height * 0.5)
        context.setStrokeColor(circleStrokeColor)
        context.setLineWidth(circleStrokeWidth)
        
        context.addEllipse(in: circleBounds)
        context.drawPath(using: .stroke)
        context.closePath()
        
        //plus
        context.beginPath()
        let plusLeftPoint = CGPoint(x: bounds.width * 0.3, y: bounds.height * 0.5)
        let plusRightPoint = CGPoint(x: bounds.width * 0.7, y: bounds.height * 0.5)
        let plusTopPoint = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.3)
        let plusBottomPoint = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.7)
        context.setStrokeColor(plusStrokeColor)
        context.setLineWidth(plusStrokeWidth)
        
        context.addLines(between: [plusLeftPoint, plusRightPoint])
        context.addLines(between: [plusTopPoint, plusBottomPoint])
        context.drawPath(using: .stroke)
        context.closePath()
    }
}
