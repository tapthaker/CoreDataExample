//
//  TTManagedObjectContext.h
//  CoreDataExample
//
//  Created by Tapan Thaker on 09/04/15.
//  Copyright (c) 2015 Tapan Thaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TTManagedObjectContext : NSManagedObjectContext

+(TTManagedObjectContext*)managedObjectContextForManagedObjectModel:(NSString*)momName andSqliteFileName:(NSString*)filename;


@end
