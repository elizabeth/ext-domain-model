//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money

public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Double
    public var currency : currencyType

    public enum currencyType {
        case USD
        case GBP
        case EUR
        case CAN
        case YEN
    }
    
    private func convertUSD(_ to: currencyType) -> Double {
        switch currency {
        case .USD:
            return amount
        case .GBP:
            return amount * 2
        case .EUR:
            return amount * 2 / 3
        case .CAN:
            return amount * 4 / 5
        case .YEN:
            return amount
        }
    }

    public func convert(_ to: currencyType) -> Money {
        var newAmount = convertUSD(to)

        switch to {
        case .USD:
            break
        case .GBP:
            newAmount = newAmount / 2
        case .EUR:
            newAmount = newAmount * 3 / 2
        case .CAN:
            newAmount = newAmount * 5 / 4
        case .YEN:
            break
        }

        return Money(amount: newAmount, currency: to)
    }

    public func add(_ to: Money) -> Money {
        var orig = self
        if currency != to.currency {
          orig = orig.convert(to.currency)
        }

        let newAmount = orig.amount + to.amount
        return Money(amount: newAmount, currency: to.currency)
    }

    public func subtract(_ from: Money) -> Money {
        var orig = self
        if currency != from.currency {
          orig = orig.convert(from.currency)
        }

        let newAmount = from.amount - orig.amount
        return Money(amount: newAmount, currency: from.currency)
    }
    
    public var description: String {
        return "\(currency)\(amount)"
    }
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ from: Money) -> Money
}

extension Double {
    var USD: Money {
        return Money(amount: self, currency: Money.currencyType.USD)
    }
        
    var EUR: Money {
        return Money(amount: self, currency: Money.currencyType.EUR)
    }
        
    var GBP: Money {
        return Money(amount: self, currency: Money.currencyType.GBP)
    }
    
    var CAN: Money {
        return Money(amount: self, currency: Money.currencyType.CAN)
    }
    
    var YEN: Money {
        return Money(amount: self, currency: Money.currencyType.YEN)
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let hourNum):
            return Int(hourNum * Double(hours))
        case .Salary(let salaryNum):
            return salaryNum
        }
    }
    
    open func raise(_ amt : Double) {
        switch type {
        case .Salary(let salaryNum):
            self.type = .Salary(salaryNum + Int(amt))
        case .Hourly(let hourNum):
            self.type = .Hourly(hourNum + amt)
        }
    }
    
    public var description: String {
        return "\(title) \(type)"
    }
}

////////////////////////////////////
// Person

open class Person: CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        
        set(value) {
            if age >= 16 {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        
        set(value) {
            if age >= 18 {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
    
    public var description: String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family

open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for member in members {
            if member.age >= 21 {
                members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var total = 0
        for member in members {
            let job = member.job
            if job != nil {
                total += job!.calculateIncome(2000)
            }
        }
        
        return total
    }
    
    public var description: String {
        var string = ""
        for member in members {
            string.append("Member: \(member.firstName) \(member.lastName)")
        }
        return string
    }
}
