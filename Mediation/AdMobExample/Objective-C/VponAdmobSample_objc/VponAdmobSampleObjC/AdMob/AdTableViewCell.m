//
//  AdTableViewCell.m
//  VponAdmobSampleObjC
//
//  Created by EricChien on 2018/12/12.
//  Copyright © 2018 Soul. All rights reserved.
//

#import "AdTableViewCell.h"

@import GoogleMobileAds;

@interface AdTableViewCell () <GADBannerViewDelegate>

@property (strong, nonatomic) GADBannerView *gadBannerView;

@property (weak, nonatomic) IBOutlet UIView *loadBannerView;

@end

@implementation AdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self requestButtonDidTouch:nil];
}

#pragma mark - Button Method

- (void) requestButtonDidTouch:(UIButton *)sender {
    if (self.gadBannerView != nil) {
        [self.gadBannerView removeFromSuperview];
    }
    
    GADRequest *request = [GADRequest request];
    self.gadBannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(_loadBannerView.frame.size)];
    self.gadBannerView.adUnitID = @"ca-app-pub-9118969380667719/2438325587";
    self.gadBannerView.delegate = self;
    self.gadBannerView.rootViewController = (UIViewController *)_rootViewController;
    [self.gadBannerView loadRequest:request];
}

#pragma mark - GADBannerView Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [self.loadBannerView addSubview:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
