//
//  ClockTool.swift
//  Clock
//
//  Created by Hanson on 23/03/2018.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit


class ClockTool: NSObject {

    public enum ClockComponent {
        case year
        
        case month
        
        case day
        
        case hour
        
        case minute
        
        case second
        
        case weekday
    }
    
    // MARK: - 常量
    static let perRotation = CGFloat.pi / 180 // 角度转弧度
    static let perSecondS: CGFloat = 6    // 每秒钟[秒针]转6度
    static let perSecondM: CGFloat = 0.1  // 每秒钟[分针]转0.1度
    static let perSecondH: CGFloat = 0.5  // 每分钟[时针]转0.5度
    
    
    // MARK: 封装方法
    
    static func getCurrentDate(_ component: ClockComponent) -> Int {
        return getDate(component, from: Date())
    }
    
    static func getCurrentRoutation(_ component: ClockComponent) -> CGFloat {
        return getRotation(component, from: Date())
    }
    
    
    
    static func getCurrentWeakDay() -> String {
        return getWeakDay(from: Date())
    }
    
    
    
    /// 获取指定日期的值
    ///
    /// - Parameters:
    ///   - component: 要获取的值（年、月、日、时、分、秒）
    ///   - date: 计算值的日期
    /// - Returns: 算出的值（年、月、日、时、分、秒）
    static func getDate(_ component: ClockComponent,from date: Date) -> Int {
        let calendar = NSCalendar.current
        switch component {
        case .year:
            return calendar.component(.year, from: date)
        case .month:
            return calendar.component(.month, from: date)
        case .day:
            return calendar.component(.day, from: date)
        case .hour:
            return calendar.component(.hour, from: date)
        case .minute:
            return calendar.component(.minute, from: date)
        case .second:
            return calendar.component(.second, from: date)
        case .weekday:
            return calendar.component(.weekday, from: date)
        }
    }
    
    
    /// 计算指针旋转角度
    ///
    /// - Parameters:
    ///   - component: 要计算的指针(时针、分针、秒针)
    ///   - date: 计算的日期时间
    /// - Returns: 计算好对应旋转的弧度
    static func getRotation(_ component: ClockComponent,from date: Date) -> CGFloat {
        let second = getDate(.second, from: date)
        let minute = getDate(.minute, from: date)
        let hour = getDate(.hour, from: date)
        
        switch component {
        case .second:
            return CGFloat(second) * perSecondS * CGFloat.pi / 180
        case .minute:
            return CGFloat(60 * minute + second) * perSecondM * CGFloat.pi / 180
        case .hour:
            return CGFloat(60 * hour + minute) * perSecondH * CGFloat.pi / 180
        default:
            return 0
        }
    }
    
    
    /// 通过日期获取星期
    ///
    /// - Parameter date: 日期
    /// - Returns: 星期几
    static func getWeakDay(from date: Date) -> String {
        switch getDate(.weekday, from: date) {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }

}
