//
//  CoreDataExampleTests.m
//  CoreDataExampleTests
//
//  Created by Tapan Thaker on 09/04/15.
//  Copyright (c) 2015 Tapan Thaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TTManagedObjectContext.h"

@interface CoreDataExampleTests : XCTestCase{
    TTManagedObjectContext *logContext;
    TTManagedObjectContext *charactersContext;
}

@end

@implementation CoreDataExampleTests

- (void)setUp {
    [super setUp];
    logContext = [TTManagedObjectContext managedObjectContextForManagedObjectModel:@"Log" andSqliteFileName:nil];
    charactersContext = [TTManagedObjectContext managedObjectContextForManagedObjectModel:@"Characters" andSqliteFileName:nil];
}


- (void)testSaveInCharacters {
    
    NSManagedObject *batman = [NSEntityDescription insertNewObjectForEntityForName:@"SuperHero" inManagedObjectContext:charactersContext];
    [batman setValue:@"Batman" forKey:@"name"];
    [batman setValue:@3 forKey:@"power"];
    [batman setValue:@5 forKey:@"brains"];
    NSManagedObject *superman = [NSEntityDescription insertNewObjectForEntityForName:@"SuperHero" inManagedObjectContext:charactersContext];
    
    [superman setValue:@"Superman" forKey:@"name"];
    [superman setValue:@5 forKey:@"power"];
    [superman setValue:@1 forKey:@"brains"];
    
    NSManagedObject  *log = [NSEntityDescription insertNewObjectForEntityForName:@"Log" inManagedObjectContext:logContext];
    [log setValue:@"Batman wins !!!" forKey:@"message"];
    [log setValue:@1 forKey:@"priority"];
    
    [charactersContext save:nil];
    [logContext save:nil];
    
    NSFetchRequest *fetchRequestCharacter = [[NSFetchRequest alloc]initWithEntityName:@"SuperHero"];
    NSFetchRequest *fetchRequestLog = [[NSFetchRequest alloc]initWithEntityName:@"Log"];
    
    NSArray *superHeros =  [charactersContext executeFetchRequest:fetchRequestCharacter error:nil];
    NSArray *logs = [logContext executeFetchRequest:fetchRequestLog error:nil];
    
    XCTAssertEqual(superHeros.count,2);
    XCTAssertEqual(logs.count, 1);
    XCTAssertEqual([logs[0] valueForKey:@"message"],@"Batman wins !!!");
}

@end
