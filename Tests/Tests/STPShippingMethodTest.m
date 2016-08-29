//
//  STPShippingMethodTest.m
//  Stripe
//
//  Created by Ben Guo on 8/31/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STPShippingMethod+Private.h"

@interface STPShippingMethodTest : XCTestCase

@end

@implementation STPShippingMethodTest

- (void)testAmountString {
    STPShippingMethod *methodUSD = [[STPShippingMethod alloc] initWithAmount:599 currency:@"usd" label:@"foo" detail:@"bar" identifier:@"123"];
    XCTAssertEqualObjects([methodUSD amountString], @"$5.99");
    STPShippingMethod *methodJPY = [[STPShippingMethod alloc] initWithAmount:599 currency:@"jpy" label:@"foo" detail:@"bar" identifier:@"456"];
    XCTAssertEqualObjects([methodJPY amountString], @"¥599");
}

- (void)testInitWithPKShippingMethod {
    PKShippingMethod *pkMethod = [PKShippingMethod new];
    pkMethod.amount = [NSDecimalNumber decimalNumberWithString:@"100"];
    pkMethod.label = @"foo";
    pkMethod.detail = @"bar";
    pkMethod.identifier = @"123";
    STPShippingMethod *stpMethod = [[STPShippingMethod alloc] initWithPKShippingMethod:pkMethod currency:@"usd"];
    XCTAssertEqual(stpMethod.amount, 10000);
    XCTAssertEqualObjects(stpMethod.currency, @"usd");
    XCTAssertEqualObjects(stpMethod.label, pkMethod.label);
    XCTAssertEqualObjects(stpMethod.detail, pkMethod.detail);
    XCTAssertEqualObjects(stpMethod.identifier, pkMethod.identifier);

    PKShippingMethod *pkMethodJPY = [PKShippingMethod new];
    pkMethodJPY.amount = [NSDecimalNumber decimalNumberWithString:@"100"];
    STPShippingMethod *stpMethodJPY = [[STPShippingMethod alloc] initWithPKShippingMethod:pkMethodJPY currency:@"jpy"];
    XCTAssertEqual(stpMethodJPY.amount, 100);
    XCTAssertEqualObjects(stpMethodJPY.currency, @"jpy");
}

- (void)testPKShippingMethod {
    STPShippingMethod *methodUSD = [[STPShippingMethod alloc] initWithAmount:599 currency:@"usd" label:@"foo" detail:@"bar" identifier:@"123"];
    PKShippingMethod *pkMethodUSD = [methodUSD pkShippingMethod];
    XCTAssertEqualObjects(pkMethodUSD.amount, [NSDecimalNumber decimalNumberWithString:@"5.99"]);

    STPShippingMethod *methodJPY = [[STPShippingMethod alloc] initWithAmount:599 currency:@"jpy" label:@"foo" detail:@"bar" identifier:@"123"];
    PKShippingMethod *pkMethodJPY = [methodJPY pkShippingMethod];
    XCTAssertEqualObjects(pkMethodJPY.amount, [NSDecimalNumber decimalNumberWithString:@"599"]);
}

@end
