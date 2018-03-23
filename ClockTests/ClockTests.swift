//
//  ClockTests.swift
//  ClockTests
//
//  Created by Hanson on 22/03/2018.
//  Copyright © 2018 Hanson. All rights reserved.
//

import XCTest
@testable import Clock

class ClockTests: XCTestCase {
    
    var date: Date = Date()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let tempDate = dateFromestringFormatter(dateString: "2018-3-23 6:30:30") else {
            XCTFail("时间格式化错误")
            return
        }
        date = tempDate
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    // MARK: - 测试 ClockTool
    /// 获取时间
    func testClockToolGetDate() {
        
        XCTAssert(ClockTool.getDate(.year, from: date) == 2018, "获取年份错误")
        XCTAssert(ClockTool.getDate(.month, from: date) == 3, "获取月份错误")
        XCTAssert(ClockTool.getDate(.day, from: date) == 23, "获取日份错误")
        XCTAssert(ClockTool.getDate(.hour, from: date) == 6, "获取小时错误")
        XCTAssert(ClockTool.getDate(.minute, from: date) == 30, "获取分钟错误")
        XCTAssert(ClockTool.getDate(.second, from: date) == 30, "获取秒钟错误")
        XCTAssert(ClockTool.getDate(.weekday, from: date) == 6, "获取秒钟错误")
    }
    
    
    
    /// 计算弧度
    func testClockToolGetRotaion() {
        
        let hourOffset = 0.5 * 30 * CGFloat.pi / 180 + CGFloat.pi
        let minuteOffset = 0.1 * 30 * CGFloat.pi / 180 + CGFloat.pi
        
        XCTAssert(ClockTool.getRotation(.second, from: date) == CGFloat.pi, "秒针弧度计算错误")
        XCTAssert(ClockTool.getRotation(.minute, from: date) == minuteOffset, "分针弧度计算错误")
        XCTAssert(Float(ClockTool.getRotation(.hour, from: date)) == Float(hourOffset), "时针弧度计算错误")
        
    }

    
    /// 测试日期换算，测试时间从[0:0:0 ~ 23:59:59].
    func testClockToolGetWeakDay() {
        let monday = dateFromestringFormatter(dateString: "2018-3-12 0:0:0")!
        let tuesday = dateFromestringFormatter(dateString: "2018-3-6 7:59:0")!
        let wednesday = dateFromestringFormatter(dateString: "2018-3-21 10:59:59")!
        let thursday = dateFromestringFormatter(dateString: "2018-2-22 12:33:45")!
        let friday = dateFromestringFormatter(dateString: "2018-3-2 16:50:0")!
        let saturday = dateFromestringFormatter(dateString: "2018-3-23 18:0:0")!
        let sunday = dateFromestringFormatter(dateString: "2018-3-25 23:59:59")!
 
        XCTAssert(ClockTool.getWeakDay(from: monday) == "星期一")
        XCTAssert(ClockTool.getWeakDay(from: tuesday) == "星期二")
        XCTAssert(ClockTool.getWeakDay(from: wednesday) == "星期三")
        XCTAssert(ClockTool.getWeakDay(from: thursday) == "星期四")
        XCTAssert(ClockTool.getWeakDay(from: friday) == "星期五")
        XCTAssert(ClockTool.getWeakDay(from: saturday) == "星期六")
        XCTAssert(ClockTool.getWeakDay(from: sunday) == "星期日")
    }

    
    func dateFromestringFormatter(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateString)
    }
    
    func dateFormatterToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
}
