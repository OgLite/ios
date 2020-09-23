//
//  DataExtention.swift
//  BleLibrary
//
//  Created by Sam Andersson on 10.04.19.
//  Copyright © 2019 arendi. All rights reserved.
//
extension Data {
    func subdata(in range: ClosedRange<Index>) -> Data{
        return subdata(in: range.lowerBound..<range.upperBound)
    }
    
    mutating func insertRangeAt(source: Data, sourceIndex: Int, destinationIndex: Int, length: Int)
    {
        for i in 0..<length
        {
            self.insert(source[i + sourceIndex], at: (destinationIndex + i))
        }
    }
    
    func reverse() -> Data{
        return Data(reversed())
    }
    
    func toArray() -> [UInt8]{
        return [UInt8](self)
    }
}
