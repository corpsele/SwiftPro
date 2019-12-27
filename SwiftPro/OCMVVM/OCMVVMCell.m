//
//  OCMVVMCell.m
//  SwiftPro
//
//  Created by eport2 on 2019/12/27.
//  Copyright © 2019 eport. All rights reserved.
//

#import "OCMVVMCell.h"

#import <Masonry/Masonry.h>

@interface OCMVVMCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblSubTitle;

@end

@implementation OCMVVMCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblTitle = [UILabel new];
        [self.contentView addSubview:_lblTitle];
        
        _lblSubTitle = [UILabel new];
        [self.contentView addSubview:_lblSubTitle];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10.0);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(80.0);
    }];
    
    [_lblSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView).offset(-10.0);
       make.centerY.equalTo(self.contentView);
       make.height.mas_equalTo(80.0);
    }];
}

@end
