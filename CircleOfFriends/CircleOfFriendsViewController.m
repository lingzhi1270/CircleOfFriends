//
//  CircleOfFriendsViewController.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/1.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "CircleOfFriendsViewController.h"
#import "TopPathCover.h"
#import "PhotographyHelper.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface CircleOfFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *circleTab;

/*
 * 视觉差的TableViewHeaderView
 */
@property (nonatomic,strong)TopPathCover *albumHeaderContainerViewPathCover;

@property (nonatomic,strong)PhotographyHelper *photographyHelper;



@end

@implementation CircleOfFriendsViewController


- (TopPathCover *)albumHeaderContainerViewPathCover
{
    if (_albumHeaderContainerViewPathCover == nil) {
        _albumHeaderContainerViewPathCover = [[TopPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
        //设置背景图片
        [_albumHeaderContainerViewPathCover setBackgroundImage:[UIImage imageNamed:@"zgr"]];
        //设置头像
        [_albumHeaderContainerViewPathCover setAvatarImage:[UIImage imageNamed:@"avatar"]];
        [_albumHeaderContainerViewPathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Leslie",XHUserNameKey,@"1956-9-12",XHBirthdayKey, nil]];
        _albumHeaderContainerViewPathCover.isZoomingEffect = YES;
        
        
        WEAKSELF
        //手动刷新
        [_albumHeaderContainerViewPathCover setHandleRefreshEvent:^{
            
        }];
        
        //更换头像
        [_albumHeaderContainerViewPathCover setHandleTapBackgroundImageEvent:^{
           
            [weakSelf.photographyHelper showOnpickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:weakSelf completed:^(UIImage *image, NSDictionary *editingInfo) {
            
                if (image) {
                    [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:image];
                }
                else
                {
                    if (!editingInfo) {
                        return;
                    }
                    else
                    {
                        [weakSelf.albumHeaderContainerViewPathCover setBackgroundImage:[editingInfo objectForKey:UIImagePickerControllerOriginalImage]];
                    }
                }
                
            } ];
            
        }];
        
    
    }
    return _albumHeaderContainerViewPathCover;
}

- (PhotographyHelper *)photographyHelper
{
    if (_photographyHelper == nil) {
        _photographyHelper = [[PhotographyHelper alloc] init];
    }
    return _photographyHelper;
}


- (UITableView *)circleTab
{
    if (_circleTab == nil) {
        _circleTab = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _circleTab.backgroundColor = [UIColor whiteColor];
        
        
        
        _circleTab.delegate = self;
        _circleTab.dataSource = self;
    }
    return _circleTab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:self.circleTab];
    
    self.circleTab.tableHeaderView = self.albumHeaderContainerViewPathCover;
    
}

#pragma mark- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    return cell;
}

#pragma mark- UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_albumHeaderContainerViewPathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.operationView dismiss];
//    
//    [self.sendMessageView resignFirstResponderForInputTextFields];
//    
//    self.selectedIndexPath = nil;
    
    [_albumHeaderContainerViewPathCover scrollViewWillBeginDragging:scrollView];
}


- (void)dealloc
{
    self.albumHeaderContainerViewPathCover = nil;
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
