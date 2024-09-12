//
//  PhotoCell.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (strong, nonatomic) UIView *shadowBGView;
@property (strong, nonatomic) UIImageView *placeholderView;
@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation PhotoCell

@synthesize shadowBGView, containerView, photoView, placeholderView, blurView, titleLabel;

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureLayout];
    }
    return self;
}

- (void)configureLayout {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupShadowBGView];
    [self setupContainerView];
    [self setupPhotoView];
    [self setupPlaceholderView];
    [self setupBlurView];
    [self setupTitleLabel];
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.contentView addSubview:shadowBGView];
    [self.shadowBGView addSubview:self.containerView];
    [self.containerView addSubview:self.placeholderView];
    [self.containerView addSubview:self.photoView];
    [self.containerView addSubview:self.blurView];
    [self.containerView addSubview:self.titleLabel];
    
    NSLayoutConstraint *bgBottomConstraint = [self.shadowBGView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor
                                                                                            constant:-6];
    bgBottomConstraint.priority = 999;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.shadowBGView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:6],
        [self.shadowBGView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:12],
        [self.shadowBGView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-12],
        bgBottomConstraint,
        [self.shadowBGView.heightAnchor constraintEqualToAnchor:self.shadowBGView.widthAnchor multiplier:0.56],
    
        [self.containerView.topAnchor constraintEqualToAnchor:self.shadowBGView.topAnchor],
        [self.containerView.leadingAnchor constraintEqualToAnchor:self.shadowBGView.leadingAnchor],
        [self.containerView.trailingAnchor constraintEqualToAnchor:self.shadowBGView.trailingAnchor],
        [self.containerView.bottomAnchor constraintEqualToAnchor:self.shadowBGView.bottomAnchor],
        
        [self.placeholderView.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor],
        [self.placeholderView.centerYAnchor constraintEqualToAnchor:self.containerView.centerYAnchor],
        
        [self.photoView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
        [self.photoView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor],
        [self.photoView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor],
        [self.photoView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor],
        
        [self.blurView.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor constant:-8],
        [self.blurView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor],
        [self.blurView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor],
        [self.blurView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:8],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-8],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-8]
    ]];
}

- (void)setupShadowBGView {
    self.shadowBGView = [[UIView alloc] initWithFrame:CGRectZero];
    self.shadowBGView.backgroundColor = UIColor.systemBackgroundColor;
    self.shadowBGView.layer.cornerRadius = 6;
    self.shadowBGView.layer.shadowColor = UIColor.secondaryLabelColor.CGColor;
    self.shadowBGView.layer.shadowOpacity = 0.9;
    self.shadowBGView.layer.shadowRadius = 2;
    self.shadowBGView.layer.shadowOffset = CGSizeMake(0, 3);
    self.shadowBGView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupContainerView {
    self.containerView = [[ShimmeringView alloc] init];
    self.containerView.backgroundColor = UIColor.systemGray4Color;
    self.containerView.layer.cornerRadius = 6;
    self.containerView.layer.borderWidth = 1;
    self.containerView.layer.borderColor = UIColor.tertiaryLabelColor.CGColor;
    self.containerView.clipsToBounds = YES;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupPhotoView {
    self.photoView = [[UIImageView alloc] init];
    self.photoView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupPlaceholderView {
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:80];
    UIImage *placeholderImage = [UIImage systemImageNamed:@"photo" withConfiguration:configuration];
    self.placeholderView = [[UIImageView alloc] initWithImage:placeholderImage];
    self.placeholderView.tintColor = UIColor.secondaryLabelColor;
    self.placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupBlurView {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.blurView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
