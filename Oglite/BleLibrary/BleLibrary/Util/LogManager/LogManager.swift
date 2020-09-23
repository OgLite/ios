//
//  LogManager.swift
//  BleLibrary
//
//  Created by Sam Andersson on 18.01.19.
//  Copyright © 2019 Arendi Ag. All rights reserved.
//

import Foundation
public class LogManager: DisposableProtocol
{
    /**
     Get the log manager instace
     */
    public static let manager = LogManager()
    
    /**
     The default log level
     */
    public var defaultLogLevel: LogLevel
    {
        get{ return _defaultLogLevel }
        set{ _defaultLogLevel = newValue }
    }
    private var _defaultLogLevel: LogLevel = LogLevel.All
    
    private var loggers = [LogProtocol]()
    private var _lockLoggers = DispatchQueue(label: "ch.arendi.bleLibrary.LogManager.lockLoggers", attributes: .concurrent )
    
    private init(){}
    
    /**
     Create and return a new log instance
     
     - returns:
     A new log instance of LogProtocol
     
     - parameters:
        - name: Log instance name, ex. Class name where the log exists
     */
    public func createLog(name: String) -> LogProtocol
    {
        let newLog = Log(name: name, level: defaultLogLevel)
        
        _lockLoggers.sync {
            loggers.append(newLog)
        }
        
        return loggers.last!
    }
    
    /**
     Change the log level of all awalible logs
     
     - parameter:
        - level: the new log level
     */
    public func setLogLevelToAllLogs(level: LogLevel)
    {
        self.defaultLogLevel = level
        
        _lockLoggers.sync {
            for var l in self.loggers
            {
                l.level = level;
            }
        }
    }
    
    public func dispose() {
        
    }
}
