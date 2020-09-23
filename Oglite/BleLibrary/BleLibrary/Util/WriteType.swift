//
//  WriteType.swift
//  BleLibrary
//
//  Created by Sam Andersson on 21.01.19.
//  Copyright © 2019 Arendi Ag. All rights reserved.
//

import Foundation
public enum WriteType
{
    /**
     The implementaion decides what write operation is the best choice. The criterias are: 1) Which write types are supported 2) Reliability is prefered.
     */
    case general
    
    /**
     Use a write command. The write command can be used on characteristics with write without response support. Due to the not required response this is the faster communication, but there is no confirmation till the operation is completed.
     */
    case command
    
    /**
     The write request is the reliable write operation. It is confirmed by the peer device and there is an error feedback if the peer doesn't acknowledge the oepration
     */
    case request    
}
