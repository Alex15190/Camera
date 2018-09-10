//
//  ViewController.m
//  Camera
//
//  Created by Alex Chekodanov on 10.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;

@property (strong, nonatomic) AVPlayerViewController *AVPlayerController;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *movieURL;
@property (copy, nonatomic) NSString *lastChosenMediaType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        self.takePictureButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)updateDisplay
{
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
    {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        self.AVPlayerController.view.hidden = YES;
    }
    else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie])
    {
        [self.AVPlayerController.view removeFromSuperview];
        self.AVPlayerController.player = [[AVPlayer alloc] initWithURL:self.movieURL];
        [self.AVPlayerController.player play];
        UIView *AVView = self.AVPlayerController.view;
        AVView.frame = self.imageView.frame;
        AVView.clipsToBounds = YES;
        [self.view addSubview:AVView];
        self.imageView.hidden = YES;
    }
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&[mediaTypes count] > 0)
    {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error accessing media" message:@"Unsupported media source." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Drat!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)shootPictureOrVideo:(id)sender
{
    
}

- (IBAction)selectExistingPictureOrVideo:(id)sender
{
    
}


@end
