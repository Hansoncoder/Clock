//
//  ClockView.swift
//  确认打卡
//
//  Created by Hanson on 22/03/2018.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit

@objc protocol ClockViewDelegate : NSObjectProtocol {
    @objc optional func clockView(_ clockView: ClockView, timeUpdate date: Date)
}

class ClockView: UIView {

    weak open var delegate: ClockViewDelegate?
    
    // MARK: - 控件属性
    let clockFace = UIImageView() // 背景图
    let hourHand = CALayer()      // 时针
    let minuteHand = CALayer()    // 分针
    let secondHand = CALayer()    // 秒针

    // MARK: - system
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        clockFace.frame = bounds
        let y = clockFace.bounds.height * 0.5
        hourHand.position = CGPoint(x: clockFace.bounds.width * 0.5, y: y)
        minuteHand.position = hourHand.position
        secondHand.position = hourHand.position
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func setup() {
        setupUI()
        setupRotation()
        setupTimer()
    }
    
    // MARK: - 初始化UI控件
    private func setupUI() {
        addClockFace()
        setupPoint()
    }
    
    
    /// 添加表盘
    private func addClockFace() {
        addSubview(clockFace)
        clockFace.image = UIImage(named: "clockFaceImg")
    }

    /// 添加化指针(设置指针大小)
    private func setupPoint() {
        addPoint(hand: hourHand, imageName: "hourHandImg")
        addPoint(hand: minuteHand, imageName: "minuteHandImg")
        addPoint(hand: secondHand, imageName: "secondHandImg")
        
        hourHand.bounds = CGRect(x: 0, y: 0, width: 6, height: 45)
        minuteHand.bounds = CGRect(x: 0, y: 0, width: 6, height: 60)
        secondHand.bounds = CGRect(x: 0, y: 0, width: 10, height: 70)
    }
    
    
    /// 设置指针的锚点和图片
    ///
    /// - Parameters:
    ///   - hand: 指针
    ///   - imageName: 指针图片名称
    private func addPoint(hand: CALayer,imageName: String) {
        guard let image = UIImage(named: imageName) else {
            return
        }
        hand.contents = image.cgImage
        hand.anchorPoint = CGPoint(x: 0.5, y: 0.93) //移动锚点
        clockFace.layer.addSublayer(hand)
    }
    
    
    // MARK: - Timer
    private func setupTimer() {
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(setupRotation),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc private func setupRotation() {
        let currentDate = Date()
        delegate?.clockView?(self, timeUpdate: currentDate)
        
        let secondRotation = ClockTool.getRotation(.second, from: currentDate)
        secondHand.transform = CATransform3DMakeRotation(CGFloat(secondRotation), 0, 0, 1)
        
        let minuteRotation = ClockTool.getRotation(.minute, from: currentDate)
        minuteHand.transform = CATransform3DMakeRotation(CGFloat(minuteRotation), 0, 0, 1)
        
        let hourRotaion = ClockTool.getRotation(.hour, from: currentDate)
        hourHand.transform = CATransform3DMakeRotation(CGFloat(hourRotaion), 0, 0, 1)
    }
}
