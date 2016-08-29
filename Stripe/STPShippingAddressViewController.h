//
//  STPShippingAddressViewController.h
//  Stripe
//
//  Created by Ben Guo on 8/29/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPTheme.h"
#import "STPPaymentContext.h"

@protocol STPShippingAddressViewControllerDelegate;

@interface STPShippingAddressViewController : UIViewController

@property(nonatomic, weak) id<STPShippingAddressViewControllerDelegate> delegate;

- (instancetype)initWithPaymentContext:(STPPaymentContext *)context;

@end

@protocol STPShippingAddressViewControllerDelegate <NSObject>

- (void)shippingAddressViewControllerDidCancel:(STPShippingAddressViewController *)addressViewController;
- (void)shippingAddressViewController:(STPShippingAddressViewController *)addressViewController didFinishWithAddress:(STPAddress *)address method:(STPShippingMethod *)method;

@end
