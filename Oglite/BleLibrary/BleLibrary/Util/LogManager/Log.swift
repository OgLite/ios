//
//  Log.swift
//  BleLibrary
//
//  Created by Sam Andersson on 17.01.19.
//  Copyright © 2019 Arendi AG. All rights reserved.
//

import Foundation
import os.log

public class Log: LogProtocol
{
    public var name: String { return _name }
    private var _name: String
    
    public var level: LogLevel
    
    public init( name: String, level: LogLevel)
    {
        _name = name
        self.level = level
    }
    
    public convenience init(name: String)
    {
        self.init(name: name, level: LogLevel.All)
    }
    
    public convenience init()
    { 
        self.init(name: "-", level: LogLevel.All)
    }
    
    
    public func info(_ message: String)
    {
        if (level == LogLevel.All || level == LogLevel.Info)
        {
            os_log("%@", log: .default, type: .info, "\(name): \(message)")
        }
    }
    
    public func debug(_ message: String)
    {
        if (level == LogLevel.All || level == LogLevel.Debug)
        {
            os_log("%@", log: .default, type: .debug, "\(name): \(message)")
        }
    }
    
    public func fault(_ message: String)
    {
        if (level == LogLevel.All || level == LogLevel.Fault)
        {
            os_log("%@", log: .default, type: .fault, "\(name): \(message)")
        }
    }
    
    public func error(_ message: String)
    {
        if (level == LogLevel.All || level == LogLevel.Error)
        {
            os_log("%@", log: .default, type: .error, "\(name): \(message)")
        }
    }
}
