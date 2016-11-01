//
//  ViewController.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/10/31.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "CircleOfFriendsViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)NSArray *imageArray;

@property (nonatomic,strong)UITableView *circleTab;

@end

@implementation ViewController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSArray alloc] initWithObjects:@[@"朋友圈"],@[@"扫一扫",@"摇一摇"],@[@"附近的人",@"漂流瓶"],@[@"游戏"], nil];
        
    }
    return _dataArr;
}

- (NSArray *)imageArray
{
    if (_imageArray == nil) {
        
      _imageArray = [[NSArray alloc] initWithObjects:@[@"ff_IconShowAlbum"],@[@"ff_IconQRCode",@"ff_IconShake"],@[@"ff_IconLocationService",@"ff_IconBottle"],@[@"MoreGame"], nil];
    }
    return _imageArray;
}

- (UITableView *)circleTab
{
    if (_circleTab == nil) {
        _circleTab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
        _circleTab.backgroundColor = [UIColor lightGrayColor];
        
        [_circleTab registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CustomCell"];
        _circleTab.delegate = self;
        _circleTab.dataSource = self;
    }
    return _circleTab;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.backgroundColor =[ UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.circleTab];
    
}

#pragma mark- UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1 || section == 2)
    {
        return 2;
    }
    else
    {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    
    cell.iconImageView.image = [UIImage imageNamed:[[self.imageArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.titleLabel.text = [[self.dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        CircleOfFriendsViewController *circleFVC = [[CircleOfFriendsViewController alloc] init];
        
        circleFVC.title = @"朋友圈";
        
        [self.navigationController pushViewController:circleFVC animated:YES];
    }
    else
    {
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
