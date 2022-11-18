//
//  Grade.swift
//  MyCreditManager
//
//  Created by 문다 on 2022/11/17.
//

import Foundation

let GradeType : [String: Double] = ["A+": 4.5, "A": 4.0, "B+": 3.5, "B": 3.0,
                                    "C+": 2.5, "C": 2.0, "D+": 1.5, "D": 1.0, "F": 0.0]

struct Grade {
    var subject: String
    var grade: Double
}
