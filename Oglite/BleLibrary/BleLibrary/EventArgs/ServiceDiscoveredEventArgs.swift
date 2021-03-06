/******************************************************************************
 * Copyright © 2019, Semiconductor Components Industries, LLC
 * (d/b/a ON Semiconductor). All rights reserved.
 *
 * This code is the property of ON Semiconductor and may not be redistributed
 * in any form without prior written permission from ON Semiconductor.
 * The terms of use and warranty for this code are covered by contractual
 * agreements between ON Semiconductor and the licensee.
 *
 * This is Reusable Code.
 *
 * Class Name: ServiceDiscoveredEventArgs.swift
 ******************************************************************************/

import Foundation
public struct ServiceDiscoveredEventArgs {
    
    public var peripheral: PeripheralBase
    {
        return _peripheral
    }
    
    public var result: BleResult
    {
        return _result
    }
    
    private var _peripheral: PeripheralBase
    private var _result: BleResult
    
    init(_ peripheral: PeripheralBase, _ result: BleResult )
    {
        self._peripheral = peripheral
        self._result = result
    }
}
