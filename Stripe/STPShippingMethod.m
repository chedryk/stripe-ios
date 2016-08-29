//
//  STPShippingMethod.m
//  Stripe
//
//  Created by Ben Guo on 8/29/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import "STPShippingMethod.h"
#import "NSDecimalNumber+Stripe_Currency.h"
#import "STPLocalizationUtils.h"

@interface STPShippingMethod ()
@property (nonatomic)NSNumberFormatter *numberFormatter;
@end

@implementation STPShippingMethod

- (instancetype)initWithAmount:(NSInteger)amount
                      currency:(nonnull NSString *)currency
                         label:(nonnull NSString *)label
                        detail:(nonnull NSString *)detail
                    identifier:(nonnull NSString *)identifier {
    self = [super init];
    if (self) {
        _amount = amount;
        _currency = currency;
        _label = label;
        _detail = detail;
        _identifier = identifier;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithPKShippingMethod:(PKShippingMethod *)method currency:(NSString *)currency {
    self = [super init];
    if (self) {
        _amount = [method.amount stp_amountWithCurrency:currency];
        _currency = currency;
        _label = method.label;
        _detail = method.detail;
        _identifier = method.identifier;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSMutableDictionary<NSString *,NSString *>*localeInfo = [@{NSLocaleCurrencyCode: self.currency} mutableCopy];
    localeInfo[NSLocaleLanguageCode] = [[NSLocale preferredLanguages] firstObject];
    NSString *localeID = [NSLocale localeIdentifierFromComponents:localeInfo];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:localeID];
    formatter.locale = locale;
    formatter.usesGroupingSeparator = YES;
    _numberFormatter = formatter;
}

- (PKShippingMethod *)pkShippingMethod {
    PKShippingMethod *method = [[PKShippingMethod alloc] init];
    method.amount = [NSDecimalNumber stp_decimalNumberWithAmount:self.amount
                                                        currency:self.currency];
    method.label = self.label;
    method.detail = self.detail;
    method.identifier = self.identifier;
    return method;
}

- (NSString *)amountString {
    if (self.amount == 0) {
        return STPLocalizedString(@"Free", @"Label for free shipping method");
    }
    NSDecimalNumber *number = [NSDecimalNumber stp_decimalNumberWithAmount:self.amount
                                                                  currency:self.currency];
    return [self.numberFormatter stringFromNumber:number];
}

@end
