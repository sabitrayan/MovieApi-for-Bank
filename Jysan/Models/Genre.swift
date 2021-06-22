//
//  Genre.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import Foundation
import ObjectMapper

public class Genre {

    var id: Int = 0
    var name = ""

    required init?(map: Map) {
    }

    required init() {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
