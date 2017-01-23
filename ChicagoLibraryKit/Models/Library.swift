//
//  Library.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import Foundation
import RealmSwift

@objc
public class Library: Object {
    
    public dynamic var id = ""
    public dynamic var address = ""
    public dynamic var city = ""
    public dynamic var cybernavigator = ""
    public dynamic var hoursOfOperation = ""
    public dynamic var name = ""
    public dynamic var phone = ""
    public dynamic var lat = 0.0
    public dynamic var lon = 0.0
    public dynamic var state = ""
    public dynamic var zip = ""
    public dynamic var website = ""
    public dynamic var updatedAt = Date()
    public dynamic var teacherInTheLibrary = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public func timesOfOperation() -> [String] {
        return self.hoursOfOperation.components(separatedBy: "; ")
    }
}
