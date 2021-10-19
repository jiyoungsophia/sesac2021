import UIKit

var rawString1 = "rawString1: 이 예시는 \"Raw Strings\"에 대한 것 입니다"
var rawString2 = #"rawString2: 이 예시는 "Raw Strings"에 대한 것 입니다"#
var rawString3 = #"rawString3: 이 예시는 \n "Raw Strings"에 대한 것 입니다"#
var rawString4 = #"rawString4: 이 예시는 \#n "Raw Strings"에 대한 것 입니다"#

let exampleString = "Raw Strings"
var rawString5 = #"rawString5: 이 예시는 \#(exampleString)에 대한 것 입니다"#


print(rawString1)
print(rawString2)
print(rawString3)
print(rawString4)
print(rawString5)
