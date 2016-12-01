//
//  Shop_RootViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "Shop_RootViewController.h"
#import "IconDisplayCell.h"
#import "ButtonCell.h"
#import "User.h"
#import "Shop.h"
#import "ShopOverview.h"
#import "TapImageView.h"
#import "QQFMNetManager.h"

@interface Shop_RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) Shop *shop;
@property (nonatomic, strong) ShopOverview *shopOverview;
@property (nonatomic, strong) User *user;

@end

@implementation Shop_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shop = [Shop currentShop];
    self.shopOverview = [ShopOverview currentShopOverview];
    [self configTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [self loadUserInfo];
}


- (void)configTableView {
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[IconDisplayCell class] forCellReuseIdentifier:kCellIdentifier_IconDisplayCell];
        [tableView registerClass:[ButtonCell class] forCellReuseIdentifier:kCellIdentifier_ButtonCell];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.bounces = NO;
        [self.view addSubview:tableView];
        tableView;
    });
    _myTableView.tableHeaderView = [self headerView];
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark - TableHeaderFooterView

- (UIView *)headerView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 120)];
    header.backgroundColor = [UIColor colorWithHexString:@"0xf61d4a"];
    TapImageView *imageView = [[TapImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [imageView sd_setImageWithURL:[NSURL URLWithImagemedium:_shopOverview.photo] placeholderImage:[UIImage imageNamed:@"添加图片"]];
    [imageView addTapBlock:^(id obj) {
        DebugLog(@"点击头像");
    }];
    imageView.layer.borderColor = kColorNavBG.CGColor;
    imageView.layer.borderWidth = 0.2;
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    [header addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.left.equalTo(header).offset(kPaddingLeftWidth);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreen_Width/2, 100)];
    label.text = [NSString stringWithFormat:@"%@\n商家编号: %ld\n佣金比例: %@",@"这是一个很长的名字啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊",_shopOverview.store_id,_shopOverview.deduction_rate];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    [label resizeFrameToFitText];
    [header addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width/2, 100));
        make.left.mas_equalTo(imageView.mas_right).offset(10);
    }];
    return header;
}

#pragma mark -network

- (void)loadUserInfo {
    NSString *u_id = [NSString stringWithFormat:@"%ld",(long)self.shop.u_id];
    [[QQFMNetManager sharedManager] loadUserInfoWithURLString:@"/appstore/index/index.html" Params:@{@"u_id":u_id} andBlock:^(id data, NSError *error) {
        self.user = [User currentUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_myTableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 6;
            break;
        case 1:
            return 1;
            break;
        
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 && indexPath.row == 5) {
        ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ButtonCell forIndexPath:indexPath];
        [cell setButtonSize:CGSizeMake(200, 30) titles:@[@"积分兑换"] clolors:@[[UIColor colorWithHexString:@"0xf5b963"]] target:self addActions:@[@"exchange"]];
        return cell;
    }else if(indexPath.section == 0){
        IconDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_IconDisplayCell forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTitle:[NSString stringWithFormat:@"当前赠送权:   %ld",(long)_user.store_score_power] icon:@"当前赠送权" accessory:IconCellAccessoryTypeNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 1) {
            [cell setTitle:[NSString stringWithFormat:@"累计赠送权:   %ld",(long)_user.store_score_power_accumulatie] icon:@"累计赠送权" accessory:IconCellAccessoryTypeRedArrow];
        }
        if (indexPath.row == 2) {
            [cell setTitle:[NSString stringWithFormat:@"当前积分:   %@ 分",_user.store_score] icon:@"当前积分" accessory:IconCellAccessoryTypeNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 3) {
            [cell setTitle:[NSString stringWithFormat:@"累计积分:   %@ 分",_user.store_score_accumulatie] icon:@"累计积分" accessory:IconCellAccessoryTypeRedArrow];
        }
        if (indexPath.row == 4) {
            [cell setTitle:[NSString stringWithFormat:@"累计兑换:   %ld 分",(long)_user.store_money_accumulatie] icon:@"累计兑换" accessory:IconCellAccessoryTypeRedArrow];
        }
        return cell;
    }else{
        IconDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_IconDisplayCell forIndexPath:indexPath];
        
        [cell setTitle:[NSString stringWithFormat:@"绑定银行卡"] icon:@"绑定银行卡" accessory:IconCellAccessoryTypeRedArrow];
        
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
            
        }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (void)exchange{
    DebugLog(@"exchange");
}

@end
