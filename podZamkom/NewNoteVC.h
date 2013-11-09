//
//  NewNoteVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBlib.h"
#import "FrameVC.h"

@interface NewNoteVC : FrameVC
{
    UIImagePickerController *picker;
    UIImage *newPhoto;
    NSMutableArray *dataArray;
}

@property (strong) Note *selectedNote; //заметка для редактирования

@property (nonatomic, retain) IBOutlet UITextField *noteTitle;
@property (nonatomic, retain) IBOutlet UITextView *note;

//- (IBAction)showUIActionSheet:(id)sender;
//-(void)takePhoto; //сделать снимок
//-(void)chooseExistingPhoto; //выбрать имеющийся

@end
