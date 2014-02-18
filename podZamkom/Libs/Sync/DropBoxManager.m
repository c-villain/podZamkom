#import "DropboxManager.h"

@implementation DropboxManager

@synthesize objDBSession,relinkUserId,apiCallDelegate;
@synthesize objRestClient;
@synthesize currentPostType;

@synthesize strFileName;
@synthesize strFilePath;
@synthesize strDestDirectory;

@synthesize strFolderCreate;

@synthesize strFolderToList;

static DropboxManager *singletonManager = nil;

+(id)dropBoxManager
{
    if(!singletonManager)
        singletonManager = [[DropboxManager alloc] init];
    
    return singletonManager;
}

-(void)initDropbox
{
    DBSession* session =  [[DBSession alloc] initWithAppKey:kDropbox_AppKey appSecret:kDropbox_AppSecret root:kDropbox_RootFolder];
    session.delegate = self;
    [DBSession setSharedSession:session];
    [session release];
    
    if([[DBSession sharedSession] isLinked] && objRestClient == nil)
    {
        self.objRestClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.objRestClient.delegate = self;
    }
}

+(BOOL)checkForLinkAccount
{
    [[DropboxManager alloc] init];
    if (![[DBSession sharedSession] isLinked])
        return false;
    return true;
}

-(void)checkForLink
{
    if(![[DBSession sharedSession] isLinked])
        [[DBSession sharedSession] linkFromController:apiCallDelegate];
}

-(BOOL)handledURL:(NSURL*)url
{
    BOOL isLinked=NO;
    if ([[DBSession sharedSession] handleOpenURL:url])
    {
        
        if([[DBSession sharedSession] isLinked])
        {
            isLinked=YES;
            [self dropboxDidLogin];
        }
        else
        {
            isLinked = NO;
            [self dropboxDidNotLogin];
        }
    }
    return isLinked;
}

#pragma mark -
#pragma mark Handle login

-(void)dropboxDidLogin
{
    NSLog(@"Logged in");
    
    if([[DBSession sharedSession] isLinked] && self.objRestClient == nil)
    {
        self.objRestClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.objRestClient.delegate = self;
    }
    
    switch(currentPostType)
    {
        case DropBoxTypeStatusNone:
            
            break;
            
        case DropBoxGetAccountInfo:
            [self loginToDropbox];
            break;
            
        case DropBoxGetFolderList:
            [self listFolders];
            break;
            
        case DropBoxCreateFolder:
            [self createFolder];
            break;
            
        case DropBoxUploadFile:
            [self uploadFile];
            break;
    }
    
}

-(void)dropboxDidNotLogin
{
    NSLog(@"Not Logged in");
    switch(currentPostType)
    {
        case DropBoxTypeStatusNone:
            
            break;
            
        case DropBoxUploadFile:
            if([self.apiCallDelegate respondsToSelector:@selector(failedToUploadFile:)])
                [self.apiCallDelegate failedToUploadFile:@"Problem connecting dropbox. Please try again later."];
            break;
            
        case DropBoxGetFolderList:
            
            break;
            
        case DropBoxCreateFolder:
            
            break;
            
        case DropBoxGetAccountInfo:
            
            break;
    }
}

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId
{
    relinkUserId = [userId retain];
    [[[[UIAlertView alloc] initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil] autorelease] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    if (index != alertView.cancelButtonIndex)
        [[DBSession sharedSession] linkUserId:relinkUserId fromController:apiCallDelegate];
    
    [relinkUserId release];
    relinkUserId = nil;
}

#pragma mark -
#pragma mark Fileupload

-(void)uploadFolder
{
    command = UPLOAD;
//    if([[DBSession sharedSession] isLinked])
//    {
//        [self.objRestClient deletePath:strDestDirectory];
//        NSError *error;
//        
//        NSArray *subPaths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:strFilePath error:&error];
//    
//        folderSize = [self folderSize:strFilePath];
//        uploadSize = 0;
//        for(NSString *path in subPaths)
//        {
//            strFileName = path;
//            NSString *from = [strFilePath stringByAppendingPathComponent:path];
////            NSString *parentRiv = [strDestDirectory stringByAppendingPathComponent: strFileName];
//            [self.objRestClient uploadFile:strFileName toPath:strDestDirectory withParentRev:nil fromPath:from];
//        }
//    }
//    else
//        [self checkForLink];
    
    if([[DBSession sharedSession] isLinked])
    {
        NSError *error;
        
        NSArray *subPaths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:strFilePath error:&error];
        folderSize = [self folderSize:strFilePath];
        for(NSString *path in subPaths)
        {
            strFileName = path;
            
            NSString *parentRiv = [strDestDirectory stringByAppendingPathComponent: strFileName];
            
            
            [self.objRestClient loadMetadata:parentRiv];
        }
    }
    else
        [self checkForLink];


}

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata
{
    switch (command) {
        case UPLOAD:
            if (metadata.isDirectory)
            {
                NSLog(@"uploadFile failed. pathname is directory");
            } else
            {
                NSLog(@"%lld", metadata.totalBytes);
                if([[DBSession sharedSession] isLinked])
                {
                    NSError *error;
                    
                    NSArray *subPaths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:strFilePath error:&error];
                    
                    folderSize = [self folderSize:strFilePath];
                    for(NSString *path in subPaths)
                    {
                        strFileName = path;
                        NSString *from = [strFilePath stringByAppendingPathComponent:path];
                        if ([strFileName isEqualToString:metadata.filename])
                            [self.objRestClient uploadFile:strFileName toPath:strDestDirectory withParentRev:metadata.rev fromPath:from];
                    }
                }
                else
                    [self checkForLink];
            }
            break;
            
       case DOWNLOAD:
            if ([metadata.filename isEqualToString:@"backup.sqlite"])
                uploadDb = metadata.totalBytes;
            if ([metadata.filename isEqualToString:@"cash.underlock"])
                uploadCash = metadata.totalBytes;
            backupSize = uploadDb + uploadCash;
            
            //скачиваем файлы:
            [self downloadFileFromSourcePath:@"/Backup/backup.sqlite" destinationPath:[self GetDbPathInDropBox:DB]];
            [self downloadFileFromSourcePath:@"/Backup/cash.underlock" destinationPath:[self GetDbPathInDropBox:CASH]];
            //--------------------------------------------
            break;
    }

    
    }


- (unsigned long long int)folderSize:(NSString *)folderPath
{
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize;
}

-(NSString *)GetDbPathInDropBox: (BackupPath) path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    switch (path)
    {
        case DB:
            return [documentsDirectory stringByAppendingPathComponent:@"Backup/backup.sqlite"];
        case BACKUPDIR:
            return [documentsDirectory stringByAppendingPathComponent:@"/Backup"];
        case CASH:
            return [documentsDirectory stringByAppendingPathComponent:@"Backup/cash.underlock"];
    }
}


-(void)downloadFolder
{
    command = DOWNLOAD;
    /*
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
   
    //Checks Database Path
    //создаем пути, куда сохранять:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"Backup/backup.sqlite"];
    NSString *cashPath = [documentsDirectory stringByAppendingPathComponent:@"Backup/cash.underlock"];

    NSString *dirPath = [documentsDirectory stringByAppendingPathComponent:@"/Backup"];
    
    BOOL isDirectory;
    
    //проверяем существует ли директория Backup:
    if (![manager fileExistsAtPath:dirPath isDirectory:&isDirectory] || !isDirectory)
    {
        //если нет, то создаем:
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [manager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:attr error:&error];
    }
    
    else
    {
        [manager removeItemAtPath:dbPath error:&error];
        [manager removeItemAtPath:cashPath error:&error];
    }
    
    //скачиваем файлы:
    [self downloadFileFromSourcePath:@"/Backup/backup.sqlite" destinationPath:dbPath];
    [self downloadFileFromSourcePath:@"/Backup/cash.underlock" destinationPath:cashPath];
    
     */
    
    //--------------------------------------------
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    //Checks Database Path
    //создаем пути, куда сохранять:
    BOOL isDirectory;
    
    //проверяем существует ли директория Backup:
    if (![manager fileExistsAtPath:[self GetDbPathInDropBox:BACKUPDIR] isDirectory:&isDirectory] || !isDirectory)
    {
        //если нет, то создаем:
        NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
        [manager createDirectoryAtPath:[self GetDbPathInDropBox:BACKUPDIR] withIntermediateDirectories:YES attributes:attr error:&error];
    }
    
    else
    {
        [manager removeItemAtPath: [self GetDbPathInDropBox:DB] error:&error];
        [manager removeItemAtPath: [self GetDbPathInDropBox:CASH] error:&error];
    }

    
    [self.objRestClient loadMetadata:@"/Backup/backup.sqlite"];
    [self.objRestClient loadMetadata:@"/Backup/cash.underlock"];
}


-(void)uploadFile
{
    if([[DBSession sharedSession] isLinked])
    {
//        [self.objRestClient deletePath:strDestDirectory];
        [self.objRestClient uploadFile:strFileName toPath:strDestDirectory withParentRev:nil fromPath:strFilePath];
    }
    else
        [self checkForLink];
}


-(void)downloadFileFromSourcePath:(NSString*)pstrSourcePath destinationPath:(NSString*)toPath
{
    if([[DBSession sharedSession] isLinked])
        [self.objRestClient loadFile:pstrSourcePath intoPath:toPath];
    else
        [self checkForLink];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata
{
    if([self.apiCallDelegate respondsToSelector:@selector(finishedUploadFile)])
        [self.apiCallDelegate finishedUploadFile];
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)contentType
{
    if([self.apiCallDelegate respondsToSelector:@selector(finishedDownloadFile)])
        [self.apiCallDelegate finishedDownloadFile];
}

-(void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error
{
    if([self.apiCallDelegate respondsToSelector:@selector(failedToDownloadFile:)])
        [self.apiCallDelegate failedToDownloadFile:[error description]];
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error
{
    if([self.apiCallDelegate respondsToSelector:@selector(failedToUploadFile:)])
        [self.apiCallDelegate failedToUploadFile:[error description]];
    
    NSLog(@"File upload failed with error - %@", error);
}

-(void) restClient:(DBRestClient *)client loadProgress:(CGFloat)progress forFile:(NSString *)destPath
{
    if ([destPath isEqualToString:@"/Backup/backup.sqlite"])
        currentUploadCash = uploadDb * progress;
    if ([destPath isEqualToString:@"/Backup/cash.underlock"])
        currentUploadDb = uploadDb * progress;
    
    if([self.apiCallDelegate respondsToSelector:@selector(downloadProgressed:)])
    [self.apiCallDelegate downloadProgressed:(double)(currentUploadCash + currentUploadDb)/backupSize];
}

-(void) restClient:(DBRestClient *)client uploadProgress:(CGFloat)progress forFile:(NSString *)destPath from:(NSString *)srcPath
{
    static NSDate* date = nil;
    static double oldUploadedFileSize = 0;
    if (!date) {
        date = [[NSDate date] retain];
    } else {
//        NSTimeInterval sec = -[date timeIntervalSinceNow];
        [date release];
        date = [[NSDate date] retain];
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:srcPath error:nil];
        double uploadedFileSize = (double)[fileAttributes fileSize] * progress;
        if ([destPath isEqualToString:@"/Backup/backup.sqlite"])
            uploadDb = uploadedFileSize;
        if ([destPath isEqualToString:@"/Backup/cash.underlock"])
            uploadCash = uploadedFileSize;
            
//        uploadSize += uploadedFileSize;
//        double uploadedFileSize = (double)(folderSize* progress);
//        CGFloat absProgress = uploadedFileSize/folderSize;
//        if (sec) {
//            NSLog(@"speed approx. %.2f KB/s", (uploadedFileSize - oldUploadedFileSize )/1024.0 / sec );
//        }
        NSLog(@"%f", (double)(uploadCash + uploadDb)/folderSize);
        if([self.apiCallDelegate respondsToSelector:@selector(downloadProgressed:)])
            [self.apiCallDelegate downloadProgressed:(double)(uploadCash + uploadDb)/folderSize];
        
        oldUploadedFileSize = uploadedFileSize;
    }
}


#pragma mark -
#pragma mark Create Folder

-(void)createFolder
{
    if([[DBSession sharedSession] isLinked])
        [self.objRestClient createFolder:strFolderCreate];
    else
        [self checkForLink];
}


- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder
{
    if([self.apiCallDelegate respondsToSelector:@selector(finishedCreateFolder)])
        [self.apiCallDelegate finishedCreateFolder];
    
    NSLog(@"Folder created successfully to path: %@", folder.path);
}

- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error
{
    if([self.apiCallDelegate respondsToSelector:@selector(failedToCreateFolder:)])
        [self.apiCallDelegate failedToCreateFolder:[error description]];
    
    NSLog(@"Folder create failed with error - %@", error);
}

#pragma mark -
#pragma mark Load account information

-(void)loginToDropbox
{
    if([[DBSession sharedSession] isLinked])
        [self.objRestClient loadAccountInfo];
    else
        [self checkForLink];
}

- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info
{
    if([self.apiCallDelegate respondsToSelector:@selector(finishedLogin:)])
    {
        NSMutableDictionary *userInfo = [[[NSMutableDictionary alloc] init] autorelease];
        [userInfo setObject:info.displayName forKey:@"UserName"];
        [userInfo setObject:info.userId forKey:@"UserID"];
        [userInfo setObject:info.referralLink forKey:@"RefferelLink"];
        [self.apiCallDelegate finishedLogin:userInfo];
    }
    
    NSLog(@"Got Information: %@", info.displayName);
}

- (void)restClient:(DBRestClient*)client loadAccountInfoFailedWithError:(NSError*)error
{
    if([self.apiCallDelegate respondsToSelector:@selector(failedToLogin:)])
        [self.apiCallDelegate failedToLogin:[error description]];
    
    NSLog(@"Failed to get account information with error - %@", error);
}

#pragma mark -
#pragma mark Logout

-(void)logoutFromDropbox
{
    [[DBSession sharedSession] unlinkAll];
    [self.objRestClient release];
}

#pragma mark -
#pragma mark Check for login

-(BOOL)isLoggedIn
{
    return [[DBSession sharedSession] isLinked] ? YES : NO;
}

#pragma mark -
#pragma mark Load Folder list

-(void)listFolders
{
    NSLog(@"Here-->%@",self.strFolderToList);
    if([[DBSession sharedSession] isLinked])
        [self.objRestClient loadMetadata:self.strFolderToList];
    else
        [self checkForLink];
}



- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path
{
    
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error
{
    NSLog(@"Load meta data failed with error - %@", error);
    
    if([apiCallDelegate respondsToSelector:@selector(getFolderContentFailed:)])
        [apiCallDelegate getFolderContentFailed:[error localizedDescription]];
}
@end
