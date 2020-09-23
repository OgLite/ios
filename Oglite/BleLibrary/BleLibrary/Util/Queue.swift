//
//  Queue.swift
//  BleLibrary
//
//  Created by Sam Andersson on 10.12.18.
//  Copyright © 2018 Arendi Ag. All rights reserved.
//

import Foundation
public class Queue<T> {
    
    //object for locking the acess to the item array
    private var _lockItems = DispatchQueue(label: "ch.arendi.bleLibrary.lockQueue")
    
    /**
     Retuns an array with T
     */
    public var items: [T] = []
    
    /**
     Add new element of T
     
     - parameters:
        -element: obejct of T
     */
    public func enqueue(element: T)
    {
        _lockItems.sync {
            items.append(element)
        }
    }
    
    /**
     Remove the top moste object int the array and returns it
     
     - returns:
        The top most object int the array. If array is empty the nil
     */
    public func dequeue() -> T?
    {
        return _lockItems.sync {
            if(items.isEmpty)
            {
                return nil
            }
            else
            {
                let tempElement = items.first
                
                items.remove(at: 0)
                
                return tempElement
            }
        }
    }
    
    /**
     Return the top most object int the array
     
     - returns:
        The top most object in the array. If array is empty then nil
     
     - throws:
        QueueError.InvalidOperationError
     */
    public func peek()throws -> T
    {
        return try _lockItems.sync {
            if !items.isEmpty
            {
                return items.first!
            }
            else
            {
                throw BleLibraryError.generalError(message: "The queue is empty")
            }
        }
    }
    
    /**
     Clear the array
     */
    public func clear()
    {
        _lockItems.sync {
            items.removeAll()
        }
    }
    
    /**
     Returns amount of objects in the array
     */
    public func count() -> Int
    {
        return _lockItems.sync {
            return items.count
        }
    }
    
    public init()
    {}   
    
}
