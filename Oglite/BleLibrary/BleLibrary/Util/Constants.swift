//
//  Constants.swift
//  BleLibrary
//
//  This is the definition area for constants used over the library
//
//  Created by Sam Andersson on 14.01.19.
//  Copyright © 2019 Arendi Ag. All rights reserved.
//

import Foundation
public struct Constants {
    
    /**
     Default timeout for connecting to the peripheral [ms].
     */
    public static let connectTimeout: Int = 5000
    
    /**
     Default timeout for requesting maximum write length from the peripheral [ms].
     */
    public static let maxWriteLenghtRequestTimeout: Int = 1000
    
    /**
     Default timeout for disconnecting from the peripheral [ms].
     */
    public static let disconnectTimeout: Int = 300
    
    /**
     Default timeout for discovering services from the peripheral [ms].
     */
    public static let discoverServicesTimeout: Int = 15000
    
    /**
     Default timeout for reading the RSSI level from the peripheral [ms].
     */
    public static let readRssiTimeout: Int = 2000
    
    /**
     Default timeout for encrypting a peripheral connection [ms].
     */
    public static let encryptTimeout: Int = 60000
    
    /**
     Default timeout for updating the connection parameters of a peripheral connection [ms].
     */
    public static let updateParameterTimeout: Int = 2000
    
    /**
     Default timeout for updating the data length of a peripheral connection [ms].
     */
    public static let updateDataLengthTimeout: Int = 2000
        
    /**
     Default timeout for the exchange of the ATT MTU on a peripheral connection [ms].
     */
    public static let exhangeAttMtuTimeout: Int = 2000
    
    /**
     Default timeout for reading a characteristic from the peripheral [ms].
     */
    public static let readDataTimeout: Int = 4000
    
    /**
     Default timeout for writing a characteristic in the peripheral [ms].
     */
    public static let writeDataTimeout: Int = 4000
    
    /**
     Default timeout for changing the notification of a characteristic in the peripheral [ms].
     */
    public static let changeNotificationTimeout: Int = 4000
    
    /**
     Default timeout for changing the indication of a characteristic in the peripheral [ms].
     */
    public static let changeIndicationTimeout: Int = 4000
    
    /**
     Default timeout for reading a CCCD from the peripheral [ms].
     */
    public static let readCccdTimeout: Int = 4000
    
    /**
     Default ATT MTU after a connection has been established.
     */
    public static let attMtuDefault: Int = 23    
}
