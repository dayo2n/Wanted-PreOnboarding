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
    
    // FIXME: var to let, 학생의 이름을 입력하지않은 경우 (newStudentName.count == 0)
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
    
    // FIXME: var to let, 학생의 이름을 입력하지않은 경우 (newStudentName.count == 0)
    var studentName: String = ""
    print("삭제할 학생의 이름을 입력해주세요.")
    studentName = readLine()!
    
    if let _ = records[studentName] {
        records[studentName] = nil
        print("\(studentName) 학생을 삭제하였습니다.")
    } else {
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
}

func gradeScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    // MARK: input[0] = 학생 이름, input[1] = 과목 이름, input[2] = 성적
    let input: [String] = readLine()!.split(separator: " ").map{String($0)}
    if input.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    // MARK: 없는 학생인 경우 성적을 추가하지 않음
    if let _ = records[input[0]] {
        // MARK: 성적이 비정삭적으로 입력된 경우 처리
        if let grade = GradeType[input[2]] {
            // MARK: 성적이 이미 존재하면 변경(삭제 후 추가), 아니면 바로 추가
            if records[input[0]]!.contains(where: {$0.subject == input[1]}) {
                records[input[0]]!.remove(at: records[input[0]]!.firstIndex(where: {$0.subject == input[1]})!)
            }
            records[input[0]]!.append(Grade(subject: input[1], grade: grade))
            print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])로 추가(변경)되었습니다.")
        } else {
            print("성적 입력이 잘못되었습니다. A+, A, B+, B, C+, C, D+, D, F 중 하나를 입력해주세요.")
        }
    } else {
        print("존재하지 않은 학생입니다. 없는 학생의 성적은 추가하지 않습니다.")
    }
}

func deleteScore() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    // MARK: input[0] = 학생 이름, input[1] = 과목 이름
    let input: [String] = readLine()!.split(separator: " ").map{String($0)}
    if input.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    // MARK: 없는 학생인 경우 성적을 삭제하지 않음
    if let _ = records[input[0]] {
        // TODO: 존재하지 않은 과목을 삭제하려는 경우
        if records[input[0]]!.filter({$0.subject==input[1]}).isEmpty {
            print("\(input[0]) 학생은 \(input[1]) 과목에 대한 성적 정보가 없습니다.")
        } else {
            records[input[0]]!.remove(at: records[input[0]]!.firstIndex(where: {$0.subject == input[1]})!)
            print("\(input[0]) 학생의 \(input[1]) 과목의 성적이 삭제되었습니다.")
        }
    } else {
        print("\(input[0]) 학생을 찾지 못했습니다.")
    }
}

func showGPA() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    let studentName: String = readLine()!
    if studentName.count == 0 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    // MARK: 없는 학생인 경우 처리
    if let _ = records[studentName] {
        if records[studentName]!.isEmpty { print("저장된 성적 정보가 존재하지 않습니다.") }
        else {
            var sum: Double = 0.0
            for record in records[studentName]! {
                print("\(record.subject): \(GradeType.first(where: {$0.value == record.grade})!.key)")
                sum += record.grade
            }
            let GPA: Double = sum / Double(records[studentName]!.count)
            // FIXME: 소수점이 첫번째자리 이상인 경우는 필요없는 소수점 아예 버리도록
            if String(GPA).split(separator: ".")[1].count < 2 { print("평점: \(GPA)") }
            else { print("평점: \(String(format: "%.2f", GPA))") }
        }
    } else {
        print("\(studentName) 학생을 찾지 못했습니다.")
    }
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
        
        case .deleteStudent:
            deleteStudent()

        case .gradeScore:
            gradeScore()
        
        case .deleteScore:
            deleteScore()
        
        case .showGPA:
            showGPA()
        
        case .exit:
            exit(0)
    }
    } else {
        printErrorMsg()
    }
}
