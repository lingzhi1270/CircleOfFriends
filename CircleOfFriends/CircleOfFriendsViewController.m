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
#import "AlbumOperationView.h"
#import "SendMessageView.h"
#import "CircleTableViewCell.h"
#import "StoreManager.h"
#import "Album.h"


#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

@interface CircleOfFriendsViewController ()<UITableViewDelegate,UITableViewDataSource,CircleTableViewCellDelegate,UITextFieldDelegate,SendMessageViewDelegate>

@property (nonatomic,strong)UITableView *circleTab;

@property (nonatomic,strong)NSMutableArray *dataArray;

/*
 * 视觉差的TableViewHeaderView
 */
@property (nonatomic,strong)TopPathCover *albumHeaderContainerViewPathCover;

//点击进相册  改背景
@property (nonatomic,strong)PhotographyHelper *photographyHelper;

//评论
@property(nonatomic,strong)AlbumOperationView *albumOperationView;

//sendView
@property (nonatomic,strong)SendMessageView *sendMessageView;

@property (nonatomic,strong)NSIndexPath *selectedIndexPath;

@end

@implementation CircleOfFriendsViewController

#pragma mark- getter

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
        
    }
    return _dataArray;
}

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
            
            //reloadData
            [weakSelf loadDataSource];
            
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

- (AlbumOperationView *)albumOperationView
{
    if (_albumOperationView == nil) {
        _albumOperationView  = [AlbumOperationView initailzerAlbumOperationView];
        WEAKSELF
        _albumOperationView.didSelectedOperationCompleted = ^(AlbumOperationType operationType){
        STRONGSELF
            switch (operationType) {
                case AlbumOperationTypeLike:{
                   [strongSelf addLike];
                }
                    break;
                case AlbumOperationTypeReply:
                {
                    [strongSelf.sendMessageView becomeFirstResponderForTextField];
                }
                    break;
                    
                default:
                    break;
            }
        
            
        };
        
        
    }
    return _albumOperationView;
}

- (SendMessageView *)sendMessageView
{
    if (_sendMessageView == nil) {
        _sendMessageView = [[SendMessageView alloc] initWithFrame:CGRectZero];
        _sendMessageView.sendMessageDelegate = self;
    }
    return _sendMessageView;
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
    
    [self.view addSubview:self.sendMessageView];
    
    
    [self.view addSubview:self.circleTab];
    
    self.circleTab.tableHeaderView = self.albumHeaderContainerViewPathCover;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    [self.circleTab addGestureRecognizer:tapGesture];
    
    [self loadDataSource];
    
}

- (void)hidenKeyboard
{

    [self.sendMessageView finishSendMessage];
    
}


#pragma mark- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleTableViewCell"];
    if (cell == nil) {
        cell = [[CircleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CircleTableViewCell"];
        cell.circleCellDelegate = self;
    }
    if (indexPath.row < self.dataArray.count) {
        cell.indexPath = indexPath;
        cell.currentAlbum = self.dataArray[indexPath.row];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CircleTableViewCell calculateCellHeightWithAlbum:self.dataArray[indexPath.row]];
}

#pragma mark - DataSource
- (void)loadDataSource
{
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        //获取数据
     NSMutableArray *dataArray = [[StoreManager shareStoreManager] getAlbumConfigureArray];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            [weakSelf.albumHeaderContainerViewPathCover stopRefresh];
            weakSelf.dataArray = dataArray;
            //刷新表
            [weakSelf.circleTab reloadData];
            
        });
        
    });
}


#pragma mark - SendMessageView Delegate
- (void)didSendMessage:(NSString *)message albumInputView:(SendMessageView *)sendMessageView
{
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataArray.count)
    {
        Album *updateCurrentAlbum = self.dataArray[self.selectedIndexPath.row];
        NSMutableArray *comments = [[NSMutableArray alloc] initWithArray:updateCurrentAlbum.albumShareComments];
        [comments insertObject:message atIndex:0];
        updateCurrentAlbum.albumShareComments = comments;
        [self.circleTab reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
        //失去第一响应
        [sendMessageView finishSendMessage];
    }

}

- (void)addLike
{
    if (self.selectedIndexPath && self.selectedIndexPath.row < self.dataArray.count)
    {
        Album *updateCyrrentAlbum = self.dataArray[self.selectedIndexPath.row];
        
        NSMutableArray *likes = [[NSMutableArray alloc] initWithArray:updateCyrrentAlbum.albumShareLikes];
        //先判断用户有没有点赞
        if (![likes containsObject:@"Leslie"])
        {
            [likes addObject:@"Leslie"];
            updateCyrrentAlbum.albumShareLikes = likes;
            [self.circleTab reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            //
            return;
        }
       
        
    }
}

#pragma mark - CircleTableViewCellDelegate
- (void)didShowOperationView:(UIButton *)sender indexPath:(NSIndexPath *)indexPath
{
    //rectForRowAtIndexPath:  获取不同cell在表上的rect
    CGRect rectInTableView = [self.circleTab rectForRowAtIndexPath:indexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;

    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.albumOperationView.shouldShowed) {
        [self.albumOperationView dismiss];
        return;
    }
    
    self.selectedIndexPath = indexPath;
    [self.albumOperationView showAtView:self.circleTab rect:targetRect];
    
    
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
  
    [self.albumOperationView dismiss];
    
    [self.sendMessageView resignFirstResponderForInputTextFields];
   
    self.selectedIndexPath = nil;
    
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
