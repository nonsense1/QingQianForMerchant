//
//  PasswordViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/22.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "PasswordViewController.h"
#import "Input_OnlyTest_Cell.h"
#import "TPKeyboardAvoidingTableView.h"
#import <UIImage_BlurredFrame/UIImage+BlurredFrame.h>
#import <NYXImagesKit/NYXImagesKit.h>
#import "QQFMNetManager.h"

@interface PasswordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;
@property (nonatomic, strong) UIButton *submitBtn, *loginBtn;
@property (nonatomic, strong) UIImageView *bgBlurredView;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_password) {
        _password = [[Password alloc] init];
    }
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Text];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Captcha];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Password];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundView = self.bgBlurredView;
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
            UIImage *bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"Password_bg_Image.jpg"]];
            CGSize bgImageSize = bgImage.size, bgViewSize = bgView.frame.size;
            if (bgImageSize.width>bgViewSize.width && bgImageSize.height>bgViewSize.height) {
                bgImage = [bgImage scaleToSize:bgViewSize usingMode:NYXResizeModeAspectFill]; 
            }
            bgView.image = bgImage;
            bgView;
        });
    }
    return _bgBlurredView;
}

#pragma mark HeaderFooterView
- (UIView *)customHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4)];
    [self.view addSubview:header];
    return header;
}

- (UIView *)customFooterView {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    
    _submitBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"提交修改" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendSubmit)];
    [footer addSubview:_submitBtn];
    RAC(self,submitBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, password.username),
                                                             RACObserve(self, password.cellphone),
                                                             RACObserve(self, password.captcha),
                                                             RACObserve(self, password.password)] reduce:^id(NSString *username,NSString *cellphone,NSString *captcha,NSString *password){
                                                                 return @(username.length >= 1 && cellphone.length >= 1 && captcha.length >= 1 &&password.length >= 1);
    }];
    
    _loginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.8] forState:UIControlStateHighlighted];
        
        [button setTitle:@"返回登录" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(footer);
            make.top.equalTo(_submitBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [self.view addSubview:footer];
    return footer;
}

#pragma mark -TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuseIdentifier;
    cellReuseIdentifier = indexPath.row == 3?kCellIdentifier_Input_OnlyText_Cell_Password:(indexPath.row == 1?kCellIdentifier_Input_OnlyText_Cell_Captcha:kCellIdentifier_Input_OnlyText_Cell_Text);
    Input_OnlyTest_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    __weak typeof(self) weakself = self;
    if (indexPath.row == 0) {
        [cell setPlaceholder:@"用户名/登录账号" value:_password.username showGuide:@""];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakself.password.username = valueStr;
        };
    }else if(indexPath.row == 1){
        [cell setPlaceholder:@"手机号" value:_password.cellphone showGuide:@""];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakself.password.cellphone = valueStr;
        };
        cell.phoneCodeBtnClickedBlock = ^(PhoneCodeButton *btn){
            [weakself phoneCodeBtnClicked:btn];
        };
    }else if(indexPath.row == 2){
        [cell setPlaceholder:@"验证码" value:_password.captcha showGuide:@""];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakself.password.captcha = valueStr;
        };
    }else if(indexPath.row == 3){
        [cell setPlaceholder:@"新密码" value:_password.password showGuide:@""];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            weakself.password.password = valueStr;
        };
    }
    return cell;
}

#pragma mark - BTNClick

- (void)sendSubmit {
    [[QQFMNetManager sharedManager] changePasswordWithURLString:@"/appstore/passport/newpwd.html" Params:@{@"account":_password.username,@"mobile":_password.cellphone,@"scode":_password.captcha,@"newpwd":_password.password} andBlock:^(id data, NSError *error) {
        NSLog(@"%@",_password.username);
        [self showMessage:data[@"msg"] withDuring:2.0];
        if ([data[@"status"] isEqualToString:@"success"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)backToLogin {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)phoneCodeBtnClicked:(PhoneCodeButton *)sender {
    if (![_password.cellphone isPhoneNo]) {
        [self showMessage:@"手机号码格式有误" withDuring:2];
        return;
    }
    sender.enabled = NO;
    [[QQFMNetManager sharedManager] sendCaptchaForChangePasswordWithURLString:@"/Appv2/index/sendsms.html" Params:@{@"account":_password.cellphone} andBlock:^(id data, NSError *error) {
        [self showMessage:data[@"msg"] withDuring:2.0];
        NSString *ret = data[@"ret"];
        if (ret.integerValue == 0) {
            [sender startUpTimer];
        }
    }];
}

@end
