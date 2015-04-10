//
//  TTManagedObjectContext.m
//  CoreDataExample
//
//  Created by Tapan Thaker on 09/04/15.
//  Copyright (c) 2015 Tapan Thaker. All rights reserved.
//

#import "TTManagedObjectContext.h"

@implementation TTManagedObjectContext

+(TTManagedObjectContext*)managedObjectContextForManagedObjectModel:(NSString*)momName andSqliteFileName:(NSString*)filename{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorForManagedObjectModel:momName andFilename:filename];
    TTManagedObjectContext *context = [[TTManagedObjectContext alloc]init];
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}


+ (NSManagedObjectModel *)managedObjectModelForName:(NSString*)momName {
    
    NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:momName withExtension:@"momd"];
    if (modelURL == nil){
        NSLog(@"Could not find file:%@.momd",momName);
        abort();
    }
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinatorForManagedObjectModel:(NSString*)mom andFilename:(NSString*)filename{
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelForName:mom]];
    NSError *error = nil;
    if (filename != nil) {
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:filename];
        [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }else{
        [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error];
    }
    
    if (error) {
        NSLog(@"ERROR OCCURED:%@",error);
        abort();
    }
    
    return persistentStoreCoordinator;
}

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
