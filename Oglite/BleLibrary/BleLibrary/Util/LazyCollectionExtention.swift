//
//  LazyCollectionExtention.swift
//  BleLibrary
//
//  Created by Sam Andersson on 10.04.19.
//  Copyright © 2019 arendi. All rights reserved.
//
public extension LazyCollection
{
    func toArray<T>() -> [T]
    {
        return Array(self) as! [T]
    }
}
