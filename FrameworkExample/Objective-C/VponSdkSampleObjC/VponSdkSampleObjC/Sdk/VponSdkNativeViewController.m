//
//  VponSdkNativeViewController.m
//  VponSdkSampleObjC
//
//  Created by EricChien on 2020/1/20.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "VponSdkNativeViewController.h"

@import VpadnSDKAdKit;
@import AdSupport;

@interface VponSdkNativeViewController () <VpadnMediaViewDelegate, VpadnNativeAdDelegate>

@property (strong, nonatomic) VpadnNativeAd *nativeAd;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *adIcon;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adBody;
@property (weak, nonatomic) IBOutlet UILabel *adSocialContext;
@property (weak, nonatomic) IBOutlet UIButton *adAction;
@property (weak, nonatomic) IBOutlet VpadnMediaView *adMediaView;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end

@implementation VponSdkNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDK - Native";
    [self requestButtonDidTouch:_requestButton];
}

#pragma mark - Initial VpadnAdRequest

- (VpadnAdRequest *) initialRequest {
    VpadnAdRequest *request = [[VpadnAdRequest alloc] init];
    [request setTestDevices:@[[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString]];   //取得測試廣告
    [request setUserInfoGender:VpadnGenderMale];                                                        //性別
    [request setUserInfoBirthdayWithYear:2000 Month:8 andDay:17];                                       //生日
    [request setMaxAdContentRating:VpadnMaxAdContentRatingGeneral];                                     //最高可投放的年齡(分類)限制
    [request setTagForUnderAgeOfConsent:VpadnTagForUnderAgeOfConsentFalse];                             //是否專為特定年齡投放
    [request setTagForChildDirectedTreatment:VpadnTagForChildDirectedTreatmentFalse];                   //是否專為兒童投放
    [request addKeyword:@"keywordA"];                                                                   //關鍵字
    [request addKeyword:@"key1:value1"];                                                                //鍵值
    return request;
}

#pragma mark - Button Method

- (IBAction)requestButtonDidTouch:(UIButton *)sender {
    sender.enabled = NO;
    
    if (_nativeAd) {
        [_nativeAd unregisterView];
    }
    
    _nativeAd = [[VpadnNativeAd alloc] initWithLicenseKey:@"8a80854b6a90b5bc016ad81ac68c6530"];
    _nativeAd.delegate = self;
    [_nativeAd loadRequest:[self initialRequest]];
}

- (void)setNativeAd {
    _adIcon.image = nil;
    
    __block typeof(self) safeSelf = self;
    [_nativeAd.icon loadImageAsyncWithBlock:^(UIImage * _Nullable image) {
        safeSelf.adIcon.image = image;
    }];
    
    [_adMediaView setNativeAd:_nativeAd];
    _adMediaView.delegate = self;
    
    _adTitle.text = [_nativeAd.title copy];
    _adBody.text = [_nativeAd.body copy];
    _adSocialContext.text = [_nativeAd.socialContext copy];
    [_adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateNormal];
    [_adAction setTitle:[_nativeAd.callToAction copy] forState:UIControlStateHighlighted];
    
    [_nativeAd registerViewForInteraction:_contentView withViewController:self];
}

#pragma mark -

/// 通知有廣告可供拉取 call back
- (void) onVpadnNativeAdReceived:(VpadnNativeAd *)nativeAd {
    _requestButton.enabled = YES;
    [self setNativeAd];
}

/// 通知拉取廣告失敗 call back
- (void) onVpadnNativeAd:(VpadnNativeAd *)nativeAd didFailToReceiveAdWithError:(NSError *)error {
    _requestButton.enabled = YES;
}

/// 通知廣告被點擊 call back
- (void) onVpadnNativeAdDidClicked:(VpadnNativeAd *)nativeAd {
    
}

/// 通知離開publisher應用程式 call back
- (void) onVpadnNativeAdLeaveApplication:(VpadnNativeAd *)nativeAd {
    
}

/// 多媒體素材讀取成功
- (void) mediaViewDidLoad:(VpadnMediaView *)mediaView {
    
}

/// 多媒體素材讀取失敗
- (void) mediaViewDidFailed:(VpadnMediaView *)mediaView error:(NSError *)error {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
