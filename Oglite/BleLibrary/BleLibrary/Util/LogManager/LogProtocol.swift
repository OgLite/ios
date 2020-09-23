//
//  LogProtocol.swift
//  BleLibrary
//
//  Created by Sam Andersson on 17.01.19.
//  Copyright © 2019 Arendi Ag. All rights reserved.
//

import Foundation
public protocol LogProtocol
{
    /**
     Get the name of the logger instance
     */
    var name: String { get }
    
    /**
     Get or sets the level of the actual logger instance while the logger is in use
     */
    var level: LogLevel{ get set }
    
    /**
     Log a INFO message
     */
    func info(_ message: String)
    
    /**
     Log a DEBUG message
     */
    func debug(_ message: String)
    
    /**
     Log a FAULT message
     */
    func fault(_ message: String)
    
    /**
     Log a Error message
     */
    func error(_ message: String)
}
