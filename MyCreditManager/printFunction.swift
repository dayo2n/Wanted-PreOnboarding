//
//  printFunction.swift
//  MyCreditManager
//
//  Created by 문다 on 2022/11/17.
//

import Foundation

// === 출력에 대한 메소드

func printMenu() {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}

func printErrorMsg() {
    print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
}

func printMsgForMenu1(_ studentName: String?) {
    if let studentName = studentName {
        // 신규 학생인 경우
        print("\(studentName) 학생을 추가했습니다.")
        // 기존 학생인 경우
        print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else { print("추가할 학생의 이름을 입력해주세요.") }
}
