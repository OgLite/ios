//
//  LogLevel.swift
//  BleLibrary
//
//  Created by Sam Andersson on 10.04.19.
//  Copyright © 2019 arendi. All rights reserved.
//

import Foundation

public enum LogLevel
{
    /**
     Level used to disallow any log messages to pass a logger filter
     */
    case Off
    
    /**
     Level for FAULT issues
     */
    case Fault
    
    /**
     Level for ERROR issues
     */
    case Error
    
    /**
     Level for DEBUG issues
     */
    case Debug
    
    /**
     Level for INFO issues
     */
    case Info
    
    /**
     Level used to allow all log messages to pass a logger filter
     */
    case All
}
