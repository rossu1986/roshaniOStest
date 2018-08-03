//
//  APITest.swift
//  DemoTestTests
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import XCTest
@testable import DemoTest

class APITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Enabled Tests
    func testGetAboutCountryData() {
        let aboutCountryUrl = APIPaths.itemsUrl
        let except = expectation(description: "Success")
        
        ServerHandler.sendGetRequest(functionName: aboutCountryUrl, showLoader: true) { (result, error) in
            //Success result from the server
            if error == nil {
                except.fulfill()
                let response = self.convertToDictionary(text: result as! String)
                if let responseData = response!["rows"], responseData is [[String: Any]]{
                    print(responseData)
                }
            } else {
                XCTAssertNil(error, "Whoops, error \(error!.localizedDescription)")
                
            }
        }
        //Check API response time
        waitForExpectations(timeout: 20) { (error) in
            if let e = error {
                print(e)
                 XCTFail("Request time out...")
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
}
