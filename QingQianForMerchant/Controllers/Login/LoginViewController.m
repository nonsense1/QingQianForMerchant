//
//  LoginViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "LoginViewController.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import <UIImage_BlurredFrame/UIImage+BlurredFrame.h>
#import "Input_OnlyTest_Cell.h"
#import "Login.h"
#import "RegisterViewController.h"
#import "InteractionTransitionAnimation.h"
#import "QQFMNetManager.h"
#import "RootTabViewController.h"
#import "PasswordViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong) Login *myLogin;
@property (nonatomic,strong) TPKeyboardAvoidingTableView *myTableView;
@property (nonatomic,strong) UIImageView *iconUserView, *bgBlurredView;
@property (nonatomic,strong) UIButton *loginBtn, *regisBtn, *cannotLoginBtn;
@property (nonatomic, strong) InteractionTransitionAnimation *popInteraction;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLogin = [[Login alloc] init];
    self.myLogin = [self.myLogin readLoginInfo];
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds
                                                                                              style:UITableViewStylePlain];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Image];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundView = self.bgBlurredView;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    _myTableView.tableHeaderView = [self customHeaderView];
    _myTableView.tableFooterView = [self customFooterView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIImageView *)bgBlurredView {
    
    if (!_bgBlurredView) {
        _bgBlurredView = ({
            UIImageView *bgView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
            bgView.contentMode = UIViewContentModeScaleAspectFit;
            UIImage *bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"Login_bg_Image.jpg"]];
            CGSize bgImageSize = bgImage.size, bgViewSize = bgView.frame.size;
            if (bgImageSize.width>bgViewSize.width && bgImageSize.height>bgViewSize.height) {
                bgImage = [bgImage scaleToSize:bgViewSize usingMode:NYXResizeModeAspectFill];

            }
//            bgImage = [bgImage applyLightEffectAtFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
            bgView.image = bgImage;
//            UIColor *blackColor = [UIColor blackColor];
//            UIColor *redColor = [UIColor redColor];
//            [bgView addGradientLayerWithColors:
//             @[(id)[blackColor colorWithAlphaComponent:0.3].CGColor,
//               (id)[redColor colorWithAlphaComponent:0.3].CGColor
//               ] locations:nil startPoint:CGPointMake(0.0, 0.0) endPoint:CGPointMake(0.0, 0.0)];
            bgView;
        });
    }
    return _bgBlurredView;
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Input_OnlyTest_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_Cell_Image forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        [cell setPlaceholder:@"用户名" value:self.myLogin.userName showGuide:@""];
        [cell setPlaceholderImageViewWithImage:[UIImage imageNamed:@"username"]];
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        cell.textValueChangedBlock = ^(NSString *valueStr) {
            weakSelf.myLogin.userName = valueStr;
        };
    }else if (indexPath.row == 1){
        [cell setPlaceholder:@"密码" value:self.myLogin.password showGuide:@""];
        [cell setPlaceholderImageViewWithImage:[UIImage imageNamed:@"password"]];
        cell.textField.secureTextEntry = YES;
        cell.textValueChangedBlock = ^(NSString *valueStr) {
            weakSelf.myLogin.password = valueStr;
        };
    }
    
    return cell;
}

#pragma mark - TableView Header Footer
- (UIView *)customHeaderView {
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6){
        iconUserViewWidth = 90;
    }else{
        iconUserViewWidth = 75;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
//    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
//    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
//    _iconUserView.layer.masksToBounds = YES;
//    _iconUserView.layer.cornerRadius = _iconUserView.frame.size.width/2;
//    _iconUserView.layer.borderWidth = 2;
//    _iconUserView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    [headerView addSubview:_iconUserView];
//    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
//        make.centerX.equalTo(headerView);
//        make.centerY.equalTo(headerView).offset(30);
//    }];
//    [_iconUserView setImage:[UIImage imageNamed:@"avatar.jpg"]];
    return headerView;
}

- (UIView *)customFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendLogin)];
    [footerView addSubview:_loginBtn];
    RAC(self,loginBtn.enabled) = [RACSignal combineLatest:
                                          @[RACObserve(self, myLogin.userName),
                                            RACObserve(self, myLogin.password)] reduce:^id(NSString *username, NSString *password){
                                                return @(username.length >= 1 && password.length >= 1);
                                            }];
    
    
    _cannotLoginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.8] forState:UIControlStateHighlighted];
        
        [button setTitle:@"找回密码" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(findPassword) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(footerView).offset(-70.0);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    
    _regisBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.8] forState:UIControlStateHighlighted];
        
        [button setTitle:@"立即注册" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendRegister) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(footerView).offset(70.0);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    
    return footerView;
}

#pragma mark BTN Click
- (void)sendLogin {
  
    [[QQFMNetManager sharedManager] loginWithURLString:@"/appstore/passport/login_20160918.html" Params:@{@"account":self.myLogin.userName,@"password":self.myLogin.password}  andBlock:^(id data, NSError *error) {
        
        [self showMessage:data[@"message"] withDuring:3.0];
        
        if ([data[@"status"] isEqualToString:@"success"]) {
            RootTabViewController *rootTab = [[RootTabViewController alloc] init];
            [[UIApplication sharedApplication] delegate].window.rootViewController = rootTab;
            [self.myLogin saveLoginInfo];
        }else{
            DebugLog(@"登录失败");
        }
        
    }];
}

- (void)findPassword {
    PasswordViewController *vc = [[PasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendRegister {
    RegisterViewController *vc = [RegisterViewController vcWithMethodType:RegisterMethodPhone registerObj:nil];
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"" target:self action:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
