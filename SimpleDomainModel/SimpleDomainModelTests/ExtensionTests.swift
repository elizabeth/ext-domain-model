//
//  ExtensionTests.swift
//  ExtDomainModel
//
//  Created by Elizabeth on 10/15/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class ExtensionTests: XCTestCase {
    // Test add
    func testAdd() {
        let tenUSD = Money(amount: 10, currency: Money.currencyType.USD)
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == Money.currencyType.USD)
    }
    
    // Test subtract
    func testSubtract() {
        let tenUSD = Money(amount: 10, currency: Money.currencyType.USD)
        let total = tenUSD.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == Money.currencyType.USD)
    }
    
    // Test job description
    func testJobDescription() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer Salary(1000)")
    }
    
    // Test person description
    func testPersonDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    
    // Test family description
    func testFamilyDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        
        print(family.description)
    }

    // Test double extension
    func testDouble() {
        XCTAssert(22.0.USD.amount == 22.0)
    }
    
    // Test double extension
    func testDoubleCurrency() {
        XCTAssert(22.0.YEN.currency == Money.currencyType.YEN)
    }
}
