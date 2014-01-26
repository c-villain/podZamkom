//
//  CollectionRV.m
//  podZamkom
//
//  Created by Alexander Kraev on 12.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "CollectionRV.h"
#import "FrameVC.h"

@implementation CollectionRV
{
    UIActionSheet *actionSheet;
    UIImagePickerController *picker;
    NSMutableArray *imageList;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

- (IBAction) addPhotoPressed: (id)sender
{
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"Отмена"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"Снять фото", @"Выбрать имеющееся фото", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.superview];
}

#pragma mark - actionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [[self viewController] presentViewController:picker animated:YES completion:nil];
            break;
        }
            
            
        case 1:
        {
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [[self viewController] presentViewController:picker animated:YES completion:nil];
            break;
        }
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    image = [self rotateImage:image];
    
    if ([_addImageDelegate respondsToSelector:@selector(AddNewPhotoPressed:)])
    {
        [_addImageDelegate AddNewPhotoPressed:image];
    }
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)rotateImage:(UIImage *)image {
    
    int orient = image.imageOrientation;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    UIImage *imageCopy = [[UIImage alloc] initWithCGImage:image.CGImage];
    
    
    switch (orient) {
        case UIImageOrientationUp:
        case UIImageOrientationLeft:
            imageView.transform = CGAffineTransformMakeRotation(3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            imageView.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            imageView.transform = CGAffineTransformMakeRotation(M_PI);
        default:
            break;
    }
    
    imageView.image = imageCopy;
    return (imageView.image);
}


@end
