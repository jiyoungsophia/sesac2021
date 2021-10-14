import UIKit

struct ExchangeRate {
    var currencyRate: Double {
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {

    }
    
    var KRW: Double {
  
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
