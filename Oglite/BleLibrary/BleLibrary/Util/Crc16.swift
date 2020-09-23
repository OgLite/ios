//
//  Crc16.swift
//  BleLibrary
//
//  Created by Sam Andersson on 10.01.19.
//  Copyright © 2019 Arendi Ag. All rights reserved.
//

import Foundation
public enum Crc16
{
    /**
     CRC16 "Kermit" (Polynomial: 0x840)
     */
    case Kermit
    
    /**
     CRC16 "Kermit" (Polynomial: 0x1020)
     */
    case XModem
}
