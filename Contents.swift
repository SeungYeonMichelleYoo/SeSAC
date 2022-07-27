import Foundation

struct ExchangeRate {
    var oldCurrencyRate: Double = 0
    var currencyRate: Double {
        willSet(newCurrencyRate) {
            oldCurrencyRate = currencyRate
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newCurrencyRate)")
        }
        didSet {
            print("currencyRate DidSet - 환율 변동 완료: \(oldCurrencyRate) -> \(currencyRate)")
        }
    }
    var USD: Double {
        willSet(newUSD) {
            print("환전금액: USD: \(newUSD)달러로 환전될 예정")
        }
        didSet {
            print("KRW: \(KRW)원 -> \(USD)달러로 환전되었음")
        }
    }
    var KRW: Double {
        get {
            return self.KRW
        }
        set {
            self.KRW = newValue
            USD = KRW / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
