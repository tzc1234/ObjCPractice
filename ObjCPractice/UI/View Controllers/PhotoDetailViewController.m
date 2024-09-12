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
@property (strong, nonatomic, nonnull) PhotoDetailViewModel *viewModel;
@property (nonatomic) BOOL isInit;

@end

@implementation PhotoDetailViewController

@synthesize stackView, authorLabel, webURLButton, imageContainerView, imageView, reloadButton, viewModel, isInit;

- (nullable instancetype)initWithViewModel:(nonnull PhotoDetailViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.isInit = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLayout];
    [self setupBindings];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    if (self.isInit) {
        self.isInit = NO;
        [self loadPhoto];
    }
}

- (void)setupBindings {
    __weak PhotoDetailViewController *weakSelf = self;
    
    self.viewModel.onLoad = ^(BOOL isLoading) {
        weakSelf.imageContainerView.isShimmering = isLoading;
    };
    
    self.viewModel.didLoad = ^(NSData * _Nullable data) {
        weakSelf.imageView.image = [[UIImage alloc] initWithData:data];
    };
    
    self.viewModel.shouldReload = ^(BOOL shouldReload) {
        [weakSelf.reloadButton setHidden:!shouldReload];
    };
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
    [self.view addSubview:self.imageContainerView];
    [self.imageContainerView addSubview:self.imageView];
    [self.imageContainerView addSubview:self.reloadButton];
    
    [self.view addSubview:self.stackView];
    [self.stackView addArrangedSubview:self.authorLabel];
    [self.stackView addArrangedSubview:self.webURLButton];
    
    CGFloat ratio = ((CGFloat)self.viewModel.photoHeight) / ((CGFloat)MAX(self.viewModel.photoWidth, 1));
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageContainerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.imageContainerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.imageContainerView.centerYAnchor constraintLessThanOrEqualToAnchor:self.view.centerYAnchor],
        [self.imageContainerView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:ratio],
        [self.imageContainerView.bottomAnchor constraintLessThanOrEqualToAnchor:self.stackView.topAnchor constant:-8],
        
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.imageContainerView.leadingAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.imageContainerView.trailingAnchor],
        [self.imageView.topAnchor constraintEqualToAnchor:self.imageContainerView.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.imageContainerView.bottomAnchor],
        
        [self.reloadButton.centerXAnchor constraintEqualToAnchor:self.imageContainerView.centerXAnchor],
        [self.reloadButton.centerYAnchor constraintEqualToAnchor:self.imageContainerView.centerYAnchor],
        
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-8],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8]
    ]];
}

- (void)setupStackView {
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentLeading;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupAuthorLabel {
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.authorLabel.text = self.viewModel.author;
}

- (void)setupWebURLButton {
    self.webURLButton = [[UIButton alloc] init];
    self.webURLButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [self.webURLButton addTarget:self action:@selector(openWeb) forControlEvents: UIControlEventTouchUpInside];
    
    NSString *url = self.viewModel.webURL.absoluteString;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:url];
    [attributedString addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, url.length)];
    [self.webURLButton setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (void)setupImageContainerView {
    self.imageContainerView = [[ShimmeringView alloc] init];
    self.imageContainerView.backgroundColor = UIColor.systemGray5Color;
    self.imageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupImageView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupReloadButton {
    self.reloadButton = [[UIButton alloc] init];
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:70];
    UIImage *image = [UIImage systemImageNamed:@"arrow.clockwise" withConfiguration:configuration];
    [self.reloadButton setImage:image forState:UIControlStateNormal];
    self.reloadButton.tintColor = UIColor.whiteColor;
    [self.reloadButton addTarget:self action:@selector(loadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.reloadButton setHidden:YES];
    self.reloadButton.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)openWeb {
    [UIApplication.sharedApplication openURL:self.viewModel.webURL options:@{} completionHandler:nil];
}

- (void)loadPhoto {
    [self.viewModel loadPhotoData];
}

@end
