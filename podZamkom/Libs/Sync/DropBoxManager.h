//
//  DropBoxManager.h
//  podZamkom
//
//  Created by Alexander Kraev on 02.02.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

#define kDropbox_AppKey @"pop3ulvz03nmdig" // Provide your key here
#define kDropbox_AppSecret @"s7etth4oaoze8ig" // Provide your secret key here

#define kDropbox_RootFolder kDBRootAppFolder //Decide level access like root or app

@protocol DropBoxDelegate;

typedef enum
{
    DropBoxTypeStatusNone = 0,
    DropBoxGetAccountInfo = 1,
    DropBoxGetFolderList = 2,
    DropBoxCreateFolder = 3,
    DropBoxUploadFile = 4
} DropBoxPostType;

typedef enum {
    UPLOAD = 0,
    DOWNLOAD
} Command;

typedef enum {
    DB = 0,
    CASH,
    BACKUPDIR
} BackupPath;

@interface DropboxManager : NSObject <DBRestClientDelegate,DBSessionDelegate,UIAlertViewDelegate>
{
    UIViewController<DropBoxDelegate> *apiCallDelegate;
    
    DBSession *objDBSession;
    NSString *relinkUserId;
    DBRestClient *objRestClient;
    
    DropBoxPostType currentPostType;
    
    NSString *strFileName;
    NSString *strFilePath;
    NSString *strDestDirectory;
    NSString *strFolderCreate;
    NSString *strFolderToList;
    unsigned long long int folderSize; //размер папки Backup в телефоне
    unsigned long long int uploadSize;
    
//    static unsigned long long int backupSize; //размер резервной копии в dropbox-е
    
    unsigned long long int uploadCash;
//    unsigned long long int currentUploadCash; //текущий размер загруженного кэша

    unsigned long long int uploadDb;
//    unsigned long long int currentUploadDb; //текущий размер загруженной копии
    
    
    NSString *destPathToBeUsed;
    NSString *origPathToBeUsed;
    
    int command; //текущая команда (upload/download)
    
    int filesDownloaded;
//    NSString *dbPath;   //   @"Backup/backup.sqlite"
//    NSString *cashPath; //   @"Backup/cash.underlock"
}

@property (nonatomic,retain) DBSession *objDBSession;
@property (nonatomic,retain) NSString *relinkUserId;

@property (nonatomic,assign) UIViewController<DropBoxDelegate> *apiCallDelegate;

@property (nonatomic,retain) DBRestClient *objRestClient;

@property (nonatomic,assign) DropBoxPostType currentPostType;

@property (nonatomic,retain) NSString *strFileName;
@property (nonatomic,retain) NSString *strFilePath;
@property (nonatomic,retain) NSString *strDestDirectory;

@property (nonatomic,retain) NSString *strFolderCreate;

@property (nonatomic,retain) NSString *strFolderToList;


-(NSString *)GetDbPathInDropBox: (BackupPath) path; //получает путь бэкапа на сервере dropbox

//Singleton
+(id)dropBoxManager;

//Initialize dropbox
-(void)initDropbox;

+(BOOL)checkForLinkAccount;
-(void)checkForLink;

//Authentication Verification
-(BOOL)handledURL:(NSURL*)url;
-(void)dropboxDidLogin;
-(void)dropboxDidNotLogin;

//Upload file
-(void)uploadFile;

//upload folder
-(void)uploadFolder;

//download folder
-(void)downloadFolder;

//Download File
-(void)downloadFileFromSourcePath:(NSString*)pstrSourcePath destinationPath:(NSString*)toPath;

//Create Folder
-(void)createFolder;

//Get Account Information
-(void)loginToDropbox;
-(void)logoutFromDropbox;
-(BOOL)isLoggedIn;

//List Folders
-(void)listFolders;

-(void)clearSession; //stop loads
-(void)clearSync; //stop uploads

@end

@protocol DropBoxDelegate <NSObject>

@optional

- (void)finishedLogin:(NSMutableDictionary*)userInfo;
- (void)failedToLogin:(NSString*)withMessage;

- (void)finishedCreateFolder;
- (void)failedToCreateFolder:(NSString*)withMessage;

- (void)finishedUploadFile;
- (void)failedToUploadFile:(NSError*)error;

- (void)finishedDownloadFile;
- (void)failedToDownloadFile:(NSError *)error;

- (void)downloadProgressed:(CGFloat)progress;

- (void)getFolderContentFinished:(DBMetadata*)metadata;
- (void)getFolderContentFailed:(NSString*)withMessage;

@end