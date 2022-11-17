//
//  Grade.swift
//  MyCreditManager
//
//  Created by 문다 on 2022/11/17.
//

import Foundation

enum GradeType: Double {
    case upA = 4.5
    case A = 4.0
    case upB = 3.5
    case B = 3.0
    case upC = 2.5
    case C = 2.0
    case upD = 1.5
    case D = 1.0
    case F = 0.0
}

struct Grade {
    var subject: String!
    var grade: GradeType
}
