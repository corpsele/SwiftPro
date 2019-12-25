

#define kUIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define VIEW_CORNER 5
#define AUTO_DEBUG 1
#define TITLE_FONTSIZE 16.0

#import "HGNotifactionMainView.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@interface HGNotifactionMainView()
{
    ///滚动视图
    UIScrollView *svMain;
    ///分页视图
    UIPageControl *pcMain;
    ///frame
    CGRect rectMain;
    ///间隔
    CGFloat duration;
    ///数据源
    NSArray *arraySource;
    ///定时器
    dispatch_source_t timer;
    ///当前页
    NSInteger curPage;
}

@end

@implementation HGNotifactionMainView

// MARK: 初始化实例
- (id)initWithFrame:(CGRect)frame withDuration:(CGFloat)duration withArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self){
        self->rectMain = frame;
        NSAssert(array!=nil, @"数据源不能为nil");
        self->arraySource = array;
        NSAssert(duration>0, @"duration不能小于0");
        self->duration = duration;
        [self initViews];
    }
    return self;
}

// MARK: 初始化视图
- (void)initViews
{
    curPage=0;
    [self initBackgroundShadowView];
    [self initScrollView];
//    [self initPageControl];
    [self addTmpView];
    [self addSubMainView];
//    [svMain scrollRectToVisible:CGRectMake(0, rectMain.size.height * 2, rectMain.size.width, rectMain.size.height) animated:true];
    [self startTimer];
}

// MARK: 添加视图阴影
- (void)initBackgroundShadowView
{
    UIImageView *imgView = [UIImageView new];
    imgView.backgroundColor = UIColor.whiteColor;
    imgView.layer.shadowColor = kUIColorFromRGB(0x000000, 0.6).CGColor;
    imgView.layer.shadowOffset = CGSizeMake(2, 5);
    imgView.layer.shadowOpacity = 0.5;
    imgView.layer.shadowRadius = VIEW_CORNER;
    imgView.layer.cornerRadius = VIEW_CORNER;
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(1.0);
        make.top.equalTo(self.mas_top).offset(1.0);
        make.right.equalTo(self.mas_right).offset(-1.0);
        make.bottom.equalTo(self.mas_bottom).offset(-1.0);
    }];
    
}

// MARK: 初始化滚动视图
- (void)initScrollView
{
    svMain = [UIScrollView new];
    svMain.showsVerticalScrollIndicator = false;
    svMain.showsHorizontalScrollIndicator = false;
    svMain.alwaysBounceHorizontal = false;
    svMain.alwaysBounceVertical = false;
    svMain.pagingEnabled = true;
    svMain.scrollEnabled = false;
    svMain.contentSize = CGSizeMake(self->rectMain.size.width, self->rectMain.size.height * self->arraySource.count);
    NSLog(@"contentSize = %f", self->rectMain.size.height * self->arraySource.count);
//    svMain.contentOffset = CGPointMake(0, 0);
//    svMain.layer.masksToBounds = true;
//    svMain.layer.cornerRadius = VIEW_CORNER;
//    svMain.layer.borderColor = kUIColorFromRGB(0x000000, 0.2).CGColor;
//    svMain.layer.borderWidth = 0.2;
//    svMain.layer.shadowColor = kUIColorFromRGB(0x000000, 0.6).CGColor;
//    svMain.layer.shadowOffset = CGSizeMake(2, 5);
//    svMain.layer.shadowOpacity = 0.5;
//    svMain.layer.shadowRadius = VIEW_CORNER;
    svMain.tag = 14431;
//    svMain.backgroundColor = UIColor.greenColor;
    [self addSubview:svMain];
    [svMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(1.0);
        make.top.equalTo(self.mas_top).offset(1.0);
        make.right.equalTo(self.mas_right).offset(-1.0);
        make.bottom.equalTo(self.mas_bottom).offset(-1.0);
    }];
}

// MARK: 初始化分页视图
- (void)initPageControl
{
    pcMain = [UIPageControl new];
    pcMain.numberOfPages = self->arraySource.count;
    pcMain.pageIndicatorTintColor = UIColor.clearColor;
    pcMain.currentPageIndicatorTintColor = UIColor.clearColor;
    pcMain.hidesForSinglePage = true;
    pcMain.userInteractionEnabled = true;
    [self addSubview:pcMain];
    [pcMain mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.mas_left).offset(1.0);
       make.top.equalTo(self.mas_top).offset(1.0);
       make.right.equalTo(self.mas_right).offset(-1.0);
       make.bottom.equalTo(self.mas_bottom).offset(-1.0);
    }];
}

// MARK: 添加铺垫视图
- (void)addTmpView
{
            UIView *viewSub = [UIView new];
            viewSub.layer.masksToBounds = true;
            viewSub.layer.cornerRadius = VIEW_CORNER;
            [svMain addSubview:viewSub];
            [viewSub mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(svMain.mas_left);
    //            make.right.equalTo(svMain.mas_right);
            make.top.equalTo(svMain.mas_top);
    //            make.bottom.equalTo(svMain.mas_bottom);
                make.height.equalTo(svMain.mas_height);
                make.width.mas_equalTo(self->rectMain.size.width);
            }];
}

// MARK: 添加子视图
- (void)addSubMainView
{
    for (int i = 0; i < self->arraySource.count; i++) {
        HGNotifactionMainDataSource *dataSource = self->arraySource[i];
        NSAssert([self->arraySource[i] isKindOfClass:HGNotifactionMainDataSource.class], @"数据源中的对象和调用的不同");
        //子视图容器
        UIView *viewSub = [UIView new];
        viewSub.tag = 144410 + i;
        viewSub.layer.masksToBounds = true;
        viewSub.layer.cornerRadius = VIEW_CORNER;
        [svMain addSubview:viewSub];
        [viewSub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(svMain.mas_left);
//            make.right.equalTo(svMain.mas_right);
        make.top.equalTo(svMain.mas_top).offset(self->rectMain.size.height * (i + 1));
//            make.bottom.equalTo(svMain.mas_bottom);
            make.height.equalTo(svMain.mas_height);
            make.width.mas_equalTo(self->rectMain.size.width);
        }];
        
        //图标 90x72
        UIImageView *imgView = [UIImageView new];
        imgView.tag = 144420 + i;
#if AUTO_DEBUG
        imgView.backgroundColor = UIColor.blueColor;
#else
        [imgView sd_setImageWithURL:[NSURL URLWithString:dataSource.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
#endif
        [viewSub addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewSub.mas_left).offset(10.0);
            make.centerY.equalTo(viewSub.mas_centerY);
            make.width.mas_equalTo(45.0);
            make.height.mas_equalTo(36.0);
        }];
        
        //日期
        UILabel *lblDate = [UILabel new];
        lblDate.tag = 144430 + i;
        lblDate.text = dataSource.strDate;
        lblDate.textColor = kUIColorFromRGB(0xABABAB, 1.0);
        lblDate.font = [UIFont systemFontOfSize:14.0];
        [viewSub addSubview:lblDate];
        [lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewSub.mas_right).offset(-10.0);
            make.top.equalTo(viewSub.mas_top).offset(9.0);
        }];
        
        //标题
        UILabel *lblTitle = [UILabel new];
        lblTitle.tag = 144440 + i;
        lblTitle.text = dataSource.strTitle;
        lblTitle.textColor = UIColor.blackColor;
        lblTitle.font = [UIFont systemFontOfSize:TITLE_FONTSIZE];
        [viewSub addSubview:lblTitle];
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(9.0);
            make.top.equalTo(viewSub.mas_top).offset(8.0);
//            make.right.equalTo(lblDate.mas_left);
        }];
        
        //副标题
        UILabel *lblSubText = [UILabel new];
        lblSubText.tag = 144450 + i;
        lblSubText.text = dataSource.strSubText;
        lblSubText.textColor = kUIColorFromRGB(0x999899, 1.0);
        lblSubText.lineBreakMode = NSLineBreakByTruncatingTail;
        lblSubText.font = [UIFont systemFontOfSize:14.0];
        [viewSub addSubview:lblSubText];
        [lblSubText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(9.0);
            make.top.equalTo(lblTitle.mas_bottom).offset(8.0);
            make.right.equalTo(viewSub.mas_right).offset(-10.0);
        }];
        
        //视图点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [viewSub addGestureRecognizer:tap];
        
    }
}

// MARK: 点击事件
- (void)tapEvent:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap = %@ tap tag = %ld", tap.view, tap.view.tag);
    NSLog(@"page = %ld", curPage);
    if (_notifactionBlock) {
        _notifactionBlock(curPage);
    }
}

// MARK: 开始定时器
- (void)startTimer
{
    __weak __typeof(self) weakSelf = self;
    if (timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), duration * NSEC_PER_SEC,  0);
    dispatch_source_set_event_handler(timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf runTimePage];
            });
    });
    dispatch_resume(timer);
    
}

// MARK: 暂停定时器
-(void) pauseTimer{
    if(timer){
        dispatch_suspend(timer);
    }
}

// MARK: 恢复定时器
-(void) resumeTimer{
    if(timer){
        dispatch_resume(timer);
    }
}

// MARK: 停止定时器
-(void) stopTimer{
    if(timer){
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

// MARK: 计算页数
- (void)runTimePage
{
//   NSInteger page = pcMain.currentPage; // 获取当前的page
    NSInteger page = curPage;
    if (page == self->arraySource.count) {
        page = 0;
    }else{
        page++;
    }
   curPage = page > self->arraySource.count ? 0 : page;
//   pcMain.currentPage = page;
    NSLog(@"page = %ld", page);
   [self turnPage];
}

// MARK: 实现滚动
-(void)turnPage{
//    NSInteger page = pcMain.currentPage;
    NSInteger page = curPage;
    CGRect rect = self->rectMain;
    if (page == 0) {
        //一直向上滚动效果，到铺垫视图后到第一视图
        [svMain setContentOffset:CGPointMake(svMain.frame.origin.x, 0) animated:false];
        [svMain scrollRectToVisible:CGRectMake(svMain.frame.origin.x, 0, self->rectMain.size.width, self->rectMain.size.height) animated:false];
        [svMain setContentOffset:CGPointMake(svMain.frame.origin.x, self->rectMain.size.height) animated:true];
        [svMain scrollRectToVisible:CGRectMake(svMain.frame.origin.x, self->rectMain.size.height, self->rectMain.size.width, self->rectMain.size.height) animated:true];
        //赋值后修正第一视图后慢的问题
        curPage = 1;
    }else{
        //正常滚动
       [svMain setContentOffset:CGPointMake(svMain.frame.origin.x, rect.size.height * page) animated:true];
       [svMain scrollRectToVisible:CGRectMake(svMain.frame.origin.x, rect.size.height * page, rect.size.width, rect.size.height) animated:true];
    }
}


@end


// MARK: 数据源
@implementation HGNotifactionMainDataSource


@end
