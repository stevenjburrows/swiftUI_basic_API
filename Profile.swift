//
//  Profile.swift
//  superheros_socal
//
//  Created by Steven Burrows on 12/06/2020.
//  Copyright © 2020 Steven Burrows. All rights reserved.
//

import Foundation

struct Profile: Decodable, Hashable{
    var userName: String
    var age: Int
    var profilePhotoURL: URL
    var bio: String
}


