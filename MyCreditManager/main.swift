//
//  main.swift
//  MyCreditManager
//
//  Created by 문다 on 2022/11/16.
//

import Foundation

var records: [String: [Grade]] = [:] // 학생이름: 성적표

enum MenuType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case gradeScore = "3"
    case deleteScore = "4"
    case showGPA = "5"
    case exit = "X"
}

func addStudent() {
    var newStudentName: String = ""
    print("추가할 학생의 이름을 입력해주세요.")
    newStudentName = readLine()!
    
    if let _ = records[newStudentName] {
        print("\(newStudentName) 학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else {
        records[newStudentName] = []
        print("\(newStudentName) 학생을 추가했습니다.")
    }
}

func deleteStudent() {
    
}

// 프로그램 동작 시작
var chosenMenu: String
while true {
    printMenu()
    chosenMenu = readLine()!
    if let menu = MenuType(rawValue: chosenMenu) {
    switch menu {
    case .addStudent:
        addStudent()
        break
    case .deleteStudent:
        break
    case .gradeScore:
        break
    case .deleteScore:
        break
    case .showGPA:
        break
    case .exit:
        exit(0)
    default:
        break
    }
    } else {
        printErrorMsg()
    }
}
