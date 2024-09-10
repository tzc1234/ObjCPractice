//
//  PhotoDetailViewController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import "PhotoDetailViewController.h"
#import "ShimmeringView.h"

@interface PhotoDetailViewController ()

@property (strong, nonatomic) UIStackView *stackView;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UIButton *webURLButton;
@property (strong, nonatomic) ShimmeringView *imageContainerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *reloadButton;

@end

@implementation PhotoDetailViewController

@synthesize stackView, authorLabel, webURLButton, imageContainerView, imageView, reloadButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLayout];
}

- (void)configureLayout {
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self setupStackView];
    [self setupAuthorLabel];
    [self setupWebURLButton];
    [self setupImageContainerView];
    [self setupImageView];
    [self setupReloadButton];
    [self configureUIConstraints];
}

- (void)configureUIConstraints {
    [self.view addSubview:imageContainerView];
    [imageContainerView addSubview:imageView];
    [imageContainerView addSubview:reloadButton];
    
    [self.view addSubview:stackView];
    [stackView addArrangedSubview:authorLabel];
    [stackView addArrangedSubview:webURLButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [imageContainerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageContainerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [imageContainerView.centerYAnchor constraintLessThanOrEqualToAnchor:self.view.centerYAnchor],
        [imageContainerView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1],
        [imageContainerView.bottomAnchor constraintLessThanOrEqualToAnchor:stackView.topAnchor constant:-8],
        
        [imageView.leadingAnchor constraintEqualToAnchor:imageContainerView.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:imageContainerView.trailingAnchor],
        [imageView.topAnchor constraintEqualToAnchor:imageContainerView.topAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:imageContainerView.bottomAnchor],
        
        [reloadButton.centerXAnchor constraintEqualToAnchor:imageContainerView.centerXAnchor],
        [reloadButton.centerYAnchor constraintEqualToAnchor:imageContainerView.centerYAnchor],
        
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-8],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8]
    ]];
}

- (void)setupStackView {
    stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentLeading;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupAuthorLabel {
    authorLabel = [[UILabel alloc] init];
    authorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (void)setupWebURLButton {
    webURLButton = [[UIButton alloc] init];
    webURLButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [webURLButton addTarget:self action:@selector(openWeb) forControlEvents: UIControlEventTouchUpInside];
}

- (void)setupImageContainerView {
    imageContainerView = [[ShimmeringView alloc] init];
    imageContainerView.backgroundColor = UIColor.systemGray5Color;
    imageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupImageView {
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupReloadButton {
    reloadButton = [[UIButton alloc] init];
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:70];
    UIImage *image = [UIImage systemImageNamed:@"arrow.clockwise" withConfiguration:configuration];
    [reloadButton setImage:image forState:UIControlStateNormal];
    reloadButton.tintColor = UIColor.whiteColor;
    [reloadButton addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
    [reloadButton setHidden:YES];
    reloadButton.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)openWeb {
    
}

- (void)loadImage {
    
}

@end
