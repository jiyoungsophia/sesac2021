import UIKit

// 함수 매개변수 반환값

// 매개변수 사용하지 않는 함수
func sayHello() -> String {
    print("hi")
    return "hello"
}

print("자기소개: \(sayHello())")

func bmi() -> Double {
    
    // 조건문
    
    return 20.1
}

func bmiResult() -> [String] {
    let name = "고래밥"
    let result = "정상"
    
    return [name, result]
}

let value = bmiResult()

print( value[0] + "님의 BMI 지수는" + value[1] + "입니다" )

//컬렉션(집단자료형): 배열, 딕셔너리, 집합 + 튜플

let userInfo: (String, String, Bool, Double) = ("고래밥", "sophia@sophia.com", true, 4.5)
print(userInfo.0)

// 전체 영하 갯수, 전체 러닝타임
@discardableResult
func getMoviewReport() -> (Int, Int) {

//    return (1000, 30000)
    
    //Swift5.1 return 키워드 생략 가능 (코드 한줄일 때)
    (1000, 30000)
}

//Swift5.1 return 키워드 생략 가능
//@discardableResult: 반환값을 무시하는 기능

//열거형(Enumeration)
enum AppleDevice {
    case iPhone
    case iPad
    case watch
}

//enum GameJob {
//    case rogue // 도적
//    case warrior
//    case mystic
//    case shaman
//    case fight
//}

enum GameJob : String {
    case rogue = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fight = "격투가"
}

//enum GameJob {
//    case rogue, warrior, mystic, shaman, fight
//}
//
//let selectJob: GameJob = GameJob.mystic
//let selectJob: GameJob = .mystic
let selectJob = GameJob.mystic

print("당신은 \(selectJob.rawValue)입니다")

if selectJob == .mystic {
    print("당신은 도사입니다")
} else if selectJob == .shaman {
    print("당신은 주술사입니다")
} else {
    
}

switch selectJob {
case .shaman:
    print("당신은 도사입니다")
case .mystic:
    print("당신은 주술사입니다")
default:
    print("")
}




enum Gender {
    case man, woman
}

enum HTTPCode: Int {
    case OK = 200
    case SEVER_ERROR = 500
    case NO_PAGE
    
    func showStatus() -> String {
        switch self {
        case .NO_PAGE:
            return "잘못된 주소입니다"
        case .SEVER_ERROR:
            return "서버 점검중입니다. 서버에 문제 생김"
        case .OK:
            return "정상"
        }
    }
}

var status: HTTPCode = .NO_PAGE

print(status.rawValue) // 원시값

status.showStatus()


if status == .NO_PAGE {
    print("잘못된 주소입니다")
} else if status == .SEVER_ERROR {
    print("서버 점검중입니다. 서버에 문제 생김")
}
