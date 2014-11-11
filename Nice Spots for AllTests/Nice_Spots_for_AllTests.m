//
//  Nice_Spots_for_AllTests.m
//  Nice Spots for AllTests
//
//  Created by Josh Click on 11/11/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface Nice_Spots_for_AllTests : XCTestCase

@end

@implementation Nice_Spots_for_AllTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
