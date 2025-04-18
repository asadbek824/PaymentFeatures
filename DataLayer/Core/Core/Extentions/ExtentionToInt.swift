//
//  ExtentionToInt.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import Foundation

public extension Int {
    static var zero: Int { return 0 }
    static var one: Int { return 1 }
    static var two: Int { return 2 }
    static var three: Int { return 3 }
    static var four: Int { return 4 }
    static var five: Int { return 5 }
    static var six: Int { return 6 }
    static var seven: Int { return 7 }
    static var eight: Int { return 8 }
    static var nine: Int { return 9 }
    static var ten: Int { return 10 }
    static var eleven: Int { return 11 }
    static var twelve: Int { return 12 }
    static var thirteen: Int { return 13 }
    static var fourteen: Int { return 14 }
    static var fifteen: Int { return 15 }
    static var sixteen: Int { return 16 }
    static var seventeen: Int { return 17 }
    static var eighteen: Int { return 18 }
    static var nineteen: Int { return 19 }
    static var twenty: Int { return 20 }
    static var twentyOne: Int { return 21 }
    static var twentyTwo: Int { return 22 }
    static var twentyThree: Int { return 23 }
    static var twentyFour: Int { return 24 }
    static var twentyFive: Int { return 25 }
    static var twentySix: Int { return 26 }
    static var twentySeven: Int { return 27 }
    static var twentyEight: Int { return 28 }
    static var twentyNine: Int { return 29 }
    static var thirty: Int { return 30 }
    static var thirtyOne: Int { return 31 }
    static var thirtyTwo: Int { return 32 }
    static var thirtyThree: Int { return 33 }
    static var thirtyFour: Int { return 34 }
    static var thirtyFive: Int { return 35 }
    static var thirtySix: Int { return 36 }
    static var thirtySeven: Int { return 37 }
    static var thirtyEight: Int { return 38 }
    static var thirtyNine: Int { return 39 }
    static var forty: Int { return 40 }
    static var fortyOne: Int { return 41 }
    static var fortyTwo: Int { return 42 }
    static var fortyThree: Int { return 43 }
    static var fortyFour: Int { return 44 }
    static var fortyFive: Int { return 45 }
    static var fortySix: Int { return 46 }
    static var fortySeven: Int { return 47 }
    static var fortyEight: Int { return 48 }
    static var fortyNine: Int { return 49 }
    static var fifty: Int { return 50 }
    static var fiftyOne: Int { return 51 }
    static var fiftyTwo: Int { return 52 }
    static var fiftyThree: Int { return 53 }
    static var fiftyFour: Int { return 54 }
    static var fiftyFive: Int { return 55 }
    static var fiftySix: Int { return 56 }
    static var fiftySeven: Int { return 57 }
    static var fiftyEight: Int { return 58 }
    static var fiftyNine: Int { return 59 }
    static var sixty: Int { return 60 }
    static var sixtyOne: Int { return 61 }
    static var sixtyTwo: Int { return 62 }
    static var sixtyThree: Int { return 63 }
    static var sixtyFour: Int { return 64 }
    static var sixtyFive: Int { return 65 }
    static var sixtySix: Int { return 66 }
    static var sixtySeven: Int { return 67 }
    static var sixtyEight: Int { return 68 }
    static var sixtyNine: Int { return 69 }
    static var seventy: Int { return 70 }
    static var seventyOne: Int { return 71 }
    static var seventyTwo: Int { return 72 }
    static var seventyThree: Int { return 73 }
    static var seventyFour: Int { return 74 }
    static var seventyFive: Int { return 75 }
    static var seventySix: Int { return 76 }
    static var seventySeven: Int { return 77 }
    static var seventyEight: Int { return 78 }
    static var seventyNine: Int { return 79 }
    static var eighty: Int { return 80 }
    static var eightyOne: Int { return 81 }
    static var eightyTwo: Int { return 82 }
    static var eightyThree: Int { return 83 }
    static var eightyFour: Int { return 84 }
    static var eightyFive: Int { return 85 }
    static var eightySix: Int { return 86 }
    static var eightySeven: Int { return 87 }
    static var eightyEight: Int { return 88 }
    static var eightyNine: Int { return 89 }
    static var ninety: Int { return 90 }
    static var ninetyOne: Int { return 91 }
    static var ninetyTwo: Int { return 92 }
    static var ninetyThree: Int { return 93 }
    static var ninetyFour: Int { return 94 }
    static var ninetyFive: Int { return 95 }
    static var ninetySix: Int { return 96 }
    static var ninetySeven: Int { return 97 }
    static var ninetyEight: Int { return 98 }
    static var ninetyNine: Int { return 99 }
    static var oneHundred: Int { return 100 }
}

public extension Int {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
