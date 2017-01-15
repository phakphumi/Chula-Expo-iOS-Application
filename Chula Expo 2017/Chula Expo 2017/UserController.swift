//
//  UserController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation

class UserController {
    
    private static var _userId: String = ""
    
    static var userId: String? {
        
        get{
            
            return self._userId
            
        }
        set(value) {
            
            self._userId = value!
            
        }
        
    }
    
}
