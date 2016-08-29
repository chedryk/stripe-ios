//
//  STPShippingMethod+Private.h
//  Stripe
//
//  Created by Ben Guo on 8/31/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPShippingMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface STPShippingMethod (Private)

- (instancetype)initWithPKShippingMethod:(nonnull PKShippingMethod *)method currency:(nonnull NSString *)currency;
- (PKShippingMethod *)pkShippingMethod;
- (NSString *)amountString;

@end

NS_ASSUME_NONNULL_END
