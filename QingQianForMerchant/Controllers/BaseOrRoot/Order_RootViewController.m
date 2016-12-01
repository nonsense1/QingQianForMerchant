//
//  Order_RootViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "RDVTabBarController.h"
#import "Order_RootViewController.h"
#import "IconDisplayCell.h"
#import "Shop.h"
#import "ShopOverview.h"
#import "User.h"
#import "ButtonCell.h"
#import "QQFMStarView.h"
#import "TapImageView.h"
#import "QQFMNetManager.h"

@interface Order_RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) Shop *shop;
@property (nonatomic, strong) ShopOverview *shopOverview;
@property (nonatomic, strong) User *user;
@end

@implementation Order_RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.shop = [Shop currentShop];
    [self loadShopDetail];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadUserInfo];
}

- (void)configTableView {
    
    self.title = @"商家中心";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[IconDisplayCell class] forCellReuseIdentifier:kCellIdentifier_IconDisplayCell];
        [tableView registerClass:[ButtonCell class] forCellReuseIdentifier:kCellIdentifier_ButtonCell];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tableView];
        tableView;
    });
    _myTableView.tableHeaderView = [self headerView];
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -network

- (void)loadShopDetail {
    NSString *u_id = [NSString stringWithFormat:@"%ld",(long)self.shop.u_id];
    [[QQFMNetManager sharedManager] loadShopInfoWithURLString:@"/appstore/passport/detail_20160923.html" params:@{@"u_id":u_id} andBlock:^(id data, NSError *error) {
        self.shopOverview = [ShopOverview currentShopOverview];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configTableView];
        });
    }];
}

- (void)loadUserInfo {
    NSString *u_id = [NSString stringWithFormat:@"%ld",(long)self.shop.u_id];
    [[QQFMNetManager sharedManager] loadUserInfoWithURLString:@"/appstore/index/index.html" Params:@{@"u_id":u_id} andBlock:^(id data, NSError *error) {
        self.user = [User currentUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_myTableView reloadData];
        });
    }];
}

#pragma mark - TableHeaderFooterView

- (UIView *)headerView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 120)];
    
    TapImageView *imageView = [[TapImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithImagemedium:_shopOverview.photo] placeholderImage:[UIImage imageNamed:@"添加图片"]];
    [imageView addTapBlock:^(id obj) {
        DebugLog(@"点击头像");
    }];
    imageView.layer.borderColor = kColorNavBG.CGColor;
    imageView.layer.borderWidth = 0.2;
    imageView.layer.cornerRadius = 5;
    [header addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.left.equalTo(header).offset(kPaddingLeftWidth);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width/3, header.height - 20));
    }];
    
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    shopNameLabel.font = [UIFont systemFontOfSize:17];
    shopNameLabel.text = _shopOverview.shop_name;
    [shopNameLabel resizeFrameToFitText];
    [header addSubview:shopNameLabel];
    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.right.mas_equalTo(header.mas_right).offset(-kPaddingLeftWidth);
        make.top.mas_equalTo(imageView.mas_top);
    }];
    
    QQFMStarView *starView = [[QQFMStarView alloc] initWithFrame:CGRectMake(0, 0, 80, 15) withTotalStar:5 totalPoint:100];
    starView.commentPoint = _shopOverview.score;
    [header addSubview:starView];
    
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.top.mas_equalTo(shopNameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *storeIdLabel = [[UILabel alloc] init];
    storeIdLabel.text = [NSString stringWithFormat:@"编号:%ld",_shopOverview.store_id];
    storeIdLabel.font = [UIFont systemFontOfSize:14];
    [header addSubview:storeIdLabel];
    [storeIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(starView.mas_right).offset(10);
        make.top.mas_equalTo(shopNameLabel.mas_bottom).offset(10);
    }];
    
    UILabel *cateLabel = [[UILabel alloc] init];
    cateLabel.font = [UIFont systemFontOfSize:14];
    cateLabel.text = [NSString stringWithFormat:@"店铺类型:%@",_shopOverview.cates];
    [header addSubview:cateLabel];
    [cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.right.mas_equalTo(header.right).offset(-kPaddingLeftWidth);
        make.top.mas_equalTo(starView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    return header;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ButtonCell forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setButtonSize:CGSizeMake(100, 30) titles:@[@"销售",@"充值"] clolors:@[[UIColor colorWithHexString:@"0xf61d4a"],[UIColor colorWithHexString:@"0x5bc0de"]] target:self addActions:@[@"sell",@"recharge"]];
        }else if (indexPath.row == 1){
            [cell setButtonSize:CGSizeMake(200, 30) titles:@[@"商务通"] clolors:@[[UIColor colorWithHexString:@"0x5bb85d"]] target:self addActions:@[@"test3"]];
        }
         return cell;
    }else{
        IconDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_IconDisplayCell forIndexPath:indexPath];
        switch (indexPath.section) {
            case 1:
            {
                if (indexPath.row == 0) {
                    [cell setTitle:[NSString stringWithFormat:@"充值余额:   %@ 元",_user.reserve_fund] icon:@"充值余额" accessory:IconCellAccessoryTypeNone];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row == 1) {
                    [cell setTitle:[NSString stringWithFormat:@"累计充值:   %@ 元",_user.reserve_fund_accumulatie] icon:@"累计充值" accessory:IconCellAccessoryTypeRedArrow];
                }
                if (indexPath.row == 2) {
                    [cell setTitle:[NSString stringWithFormat:@"累计扣款:   %@ 元",_user.store_sell_accumulatie] icon:@"累计扣款" accessory:IconCellAccessoryTypeNone];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
            }
                break;
            case 2:
            {
                if (indexPath.row == 0) {
                    [cell setTitle:@"销售记录" icon:@"销售记录" accessory:IconCellAccessoryTypeRedArrow];
                }
            }
                break;
            case 3:
            {
                if (indexPath.row == 0) {
                    [cell setTitle:@"立支付订单" icon:@"立支付订单" accessory:IconCellAccessoryTypeRedArrow];
                }
                if (indexPath.row == 1) {
                    [cell setTitle:@"立支付结算" icon:@"立支付结算" accessory:IconCellAccessoryTypeRedArrow];
                }
                if (indexPath.row == 2) {
                    [cell setTitle:@"立支付结算日志" icon:@"立支付结算日志" accessory:IconCellAccessoryTypeRedArrow];
                }
            }
                break;
            case 4:
            {
                if (indexPath.row == 0) {
                    [cell setTitle:@"商城订单" icon:@"立支付订单" accessory:IconCellAccessoryTypeRedArrow];
                }
                if (indexPath.row == 1) {
                    [cell setTitle:@"商城订单结算" icon:@"立支付结算" accessory:IconCellAccessoryTypeRedArrow];
                }
            }
                break;
            default:
                break;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 4 ? 20 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ButtonCell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    headerView.backgroundColor = kColorTabBG;
    
    UILabel *lineup = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
    lineup.backgroundColor = [UIColor lightGrayColor];
    lineup.alpha = 0.5;
    [headerView addSubview:lineup];
    
    UILabel *linedown = [[UILabel alloc] initWithFrame:CGRectMake(0, 19.5, kScreen_Width, 0.5)];
    linedown.backgroundColor = [UIColor lightGrayColor];
    linedown.alpha = 0.5;
    [headerView addSubview:linedown];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.myTableView) {
        CGFloat sectionHeaderHeight = 20;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            self.rdv_tabBarController.tabBarHidden = YES;
        }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
        
    }
}

#pragma mark - ButtonEvents
- (void)sell {
    DebugLog(@"test1");
}

- (void)recharge {
    DebugLog(@"test2");
}

- (void)test3 {
    DebugLog(@"test3");
}

@end
