//
//  CSVParser.m
//  CSVParser
//
//  Created by Ha Minh Vuong on 8/31/12.
//  Copyright (c) 2012 Ha Minh Vuong. All rights reserved.
//

#import "CSVParser.h"

@interface CSVParser()
+ (NSArray *)trimComponents:(NSArray *)array withCharacters:(NSString *)characters;
@end

@implementation CSVParser

+ (NSArray *)trimComponents:(NSArray *)array withCharacters:(NSString *)characters
{
    NSMutableArray *marray = [[NSMutableArray alloc] initWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [marray addObject:[obj stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characters]]];
    }];
    return marray;
}

+ (void)parseCSVIntoArrayOfDictionariesFromFile:(NSString *)path
                   withSeparatedCharacterString:(NSString *)character
                           quoteCharacterString:(NSString *)quote
                                      withBlock:(void (^)(NSArray *array, NSError *error))block
{
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t queue = dispatch_queue_create("parseQueue", NULL);
    dispatch_async(queue, ^{
        NSError *err = nil;
        NSMutableArray *mutArray = [[NSMutableArray alloc] init];
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
        
        if (!content) return;
        NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
        NSString *trimStr = (quote != nil) ? [quote stringByAppendingString:@"\n\r "] : @"\n\r ";
        
        NSArray *keys = [CSVParser trimComponents:[[rows objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                   withCharacters:trimStr];
        
        for (int i = 1; i < rows.count; i++) {
//            NSArray *objects = [CSVParser trimComponents:[[rows objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
//                                          withCharacters:trimStr];
            
            NSArray *objects = [self trimComponents:[self slipStringWith:[rows objectAtIndex:i] columnSeparator:character]
                                     withCharacters:trimStr];
            
            [mutArray addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
        }
        if (block) {
            dispatch_async(callerQueue, ^{
                block(mutArray, err);
            });
        }
        dispatch_release(callerQueue);
    });
    dispatch_release(queue);
}

+ (void)parseCSVIntoArrayOfArraysFromFile:(NSString *)path
             withSeparatedCharacterString:(NSString *)character
                     quoteCharacterString:(NSString *)quote
                                withBlock:(void (^)(NSArray *array, NSError *error))block
{
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t queue = dispatch_queue_create("parseQueue", NULL);
    
    dispatch_async(queue, ^{
        NSError *err = nil;
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
        if (!content) return;
        NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
        NSString *trimStr = (quote != nil) ? [quote stringByAppendingString:@"\n\r "] : @"\n\r ";
        [rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [mutableArray addObject:[CSVParser trimComponents:[obj componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                               withCharacters:trimStr]];
        }];
        if (block) {
            dispatch_async(callerQueue, ^{
                block(mutableArray, err);
            });
        }
        dispatch_release(callerQueue);
    });
    dispatch_release(queue);
}

+ (NSArray *)parseCSVIntoArrayOfDictionariesFromFile:(NSString *)path
                        withSeparatedCharacterString:(NSString *)character
                                quoteCharacterString:(NSString *)quote
{
    NSError *error = nil;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];    
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!content) return nil;
    NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
    NSString *trimStr = (quote != nil) ? [quote stringByAppendingString:@"\n\r "] : @"\n\r ";
    
    
    NSArray *keys = [CSVParser trimComponents:[[rows objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                               withCharacters:trimStr];
    
    
    for (int i = 1; i < rows.count; i++) {
        
        NSArray *objects = [CSVParser trimComponents:[ [rows objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                      withCharacters:trimStr];
        [mutableArray addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
    }
    return mutableArray;
}


+ (NSArray *)parseCSVIntoArrayOfArraysFromFile:(NSString *)path
                  withSeparatedCharacterString:(NSString *)character
                          quoteCharacterString:(NSString *)quote
{
    NSError *error = nil;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!content) return nil;
    NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
    NSString *trimStr = (quote != nil) ? [quote stringByAppendingString:@"\n\r "] : @"\n\r ";
    [rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutableArray addObject:[CSVParser trimComponents:[obj componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                           withCharacters:trimStr]];
    }];
    return mutableArray;
}


+(NSArray*) slipStringWith:(NSString*)content columnSeparator:(NSString*) character {
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:content];
    NSString * separator = [NSString stringWithFormat:@"\"%@", character];
    
    NSCharacterSet *characters = [NSCharacterSet characterSetWithCharactersInString:separator];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableArray * column = [[NSMutableArray alloc]init];
    NSMutableString *word = [[NSMutableString alloc] init];
    BOOL inQuotes = NO;
    while(scanner.isAtEnd == NO)
    {
        NSString *subString;
        [scanner scanUpToCharactersFromSet:characters intoString:&subString];
        NSUInteger currentLocation = [scanner scanLocation];
        if(currentLocation >= scanner.string.length)
        {
            if(subString.length > 0)
                [column addObject:subString];
            break;
        }
        if([scanner.string characterAtIndex:currentLocation] == '"')
        {
            inQuotes = !inQuotes;
            if(subString == nil)
            {
                [scanner setScanLocation:currentLocation + 1];
                continue;
            }
            [word appendFormat:@"%@",subString];
            if(word.length > 0)
                [column addObject:word.copy];
            [word deleteCharactersInRange:NSMakeRange(0, word.length)];
        }
        if([scanner.string characterAtIndex:currentLocation] == ',')
        {
            if(subString == nil)
            {
                [column addObject:@""];
                [scanner setScanLocation:currentLocation + 1];
                continue;
            }
            if(inQuotes == NO)
                [column addObject:subString];
            else
                [word appendFormat:@"%@%@",subString, character];
        }
        [scanner setScanLocation:currentLocation + 1];
    }
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF endswith %@", @","];
    BOOL find = [predicate evaluateWithObject:content];
    if (find) {
        [column addObject:@""];
    }
    
    return column;
}



@end