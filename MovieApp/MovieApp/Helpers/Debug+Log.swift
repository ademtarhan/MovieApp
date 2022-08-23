//
//  Debug+Log.swift
//  MovieApp
//
//  Created by Adem Tarhan on 22.08.2022.
//

import Foundation


func currentDateString() -> String {
    var ds = ""
        let df = DateFormatter()
        df.dateFormat = "dd-MM HH:mm:ss.SSSS"
        ds = df.string(from: Date())
    return ds
}

enum LogType {
    case Error
    case Warning
    case Success
    case Info
}

func dlog(
    _ cls: AnyObject,
    _ items: Any...) {
    #if DEBUG
    var list : [Any] = []
    let logInfo = "\(currentDateString())        \(getFixedLengthStringType(cls))🧿"
    list.append(logInfo)
    list.append(contentsOf: items)
    print(list, separator: " ", terminator: "\n")
    #endif
}

func dlog(
    _ tag: String,
    _ cls: AnyObject,
    _ items: Any...) {
    #if DEBUG
    var list : [Any] = []
    let logInfo = "\(currentDateString()) \(tag) \(getFixedLengthStringType(cls))🧿"
    list.append(logInfo)
    list.append(contentsOf: items)
    print(list, separator: " ", terminator: "\n")
    #endif
}

func dlog(
    _ logType: LogType,
    _ tag: String,
    _ cls: AnyObject,
    _ items: Any...) {
    #if DEBUG
    var list : [Any] = []
    
    var icon = "📗"
    switch logType {
    case .Error:
        icon = "📕"
    case .Warning:
        icon = "📙"
    case .Success:
        icon = "📗"
    case .Info:
        icon = "📘"
    }
    
    let logInfo = "\(currentDateString()) \(tag) \(icon) \(getFixedLengthStringType(cls))🧿"
    list.append(logInfo)
    list.append(contentsOf: items)
    print(list, separator: " ", terminator: "\n")
    #endif
}

func getFixedLengthStringType(_ cls: AnyObject) -> String {
    let len = 20
    let str = "\(type(of: cls))"
    if str.count > len{
        return String(str.prefix(len))
    }else if str.count < len {
        return str.padding(toLength: len, withPad: " ", startingAt: 0)
    }
    
    return str
}
