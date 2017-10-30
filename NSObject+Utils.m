//
//  NSObject+Utils.m
//  Price
//
//  Created by doanthegiang on 10/27/17.
//  Copyright © 2017 doanthegiang. All rights reserved.
//

#import "NSObject+Utils.h"
#import <objc/runtime.h>
#import "LogApp.h"

@implementation NSObject (Utils)

- (NSDictionary *) convertObjectToDictionary: (id) object
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *upCase = [key capitalizedString];
        id object_to_string = [[NSClassFromString(upCase) alloc] init];
        if (object_to_string)
        {
            id object_convert = [object valueForKey:key];
            [dict addEntriesFromDictionary: [self convertObjectToDictionary: object_convert]];
        }
        else
        {
            id value = [object valueForKey:key];
            if (value)
            {
                [dict setObject:[object valueForKey:key] forKey:key];
            }
        }
    }
    
    free(properties);
    return dict;
}

/**
 @parse JSON to Object
 */


- (void) parseDictionaryToObject: (NSDictionary *) dictionary /*andObject: (id) object*/
{
    
    NSDictionary *dTemp = [NSDictionary dictionaryWithDictionary: dictionary];
    NSArray *aParams    = [dTemp allKeys];
    
    for (int i = 0; i < aParams.count; i++) {
        
        NSString *key = aParams[i]; // get key in JSON
        NSString *keyProperty = [NSString string];
        
        id value = [dTemp valueForKey:key];
        
        BOOL isExist = [self checkExistKeyInObject:self andKey:key andKeyProperty:&keyProperty];
        
        if ( !isExist )
        {
            NSString *message = [NSString stringWithFormat:@" not exist: %@", key];
            LOG_TYPE_OBJECT(message);
            break;
        }
        
        if (   [value isKindOfClass:[NSDictionary class]]          /* Reponse is Object */
            || [value isKindOfClass:[NSMutableDictionary class]] )
        {
            
            id get_object = [[NSClassFromString([keyProperty capitalizedString]) alloc] init];
            if (get_object)
            {
                [self setValue:get_object forKey:keyProperty];
                [get_object parseDictionaryToObject: value /*andObject: get_object*/];
            }
        }
        else if (   [value isKindOfClass: [NSArray class]]         /* Reponse is Array */
                 || [value isKindOfClass: [NSMutableArray class]] )
        {
            NSMutableArray *muTemp = [[NSMutableArray alloc] init];
            for (id component in value) {
                
                id componentObj = [[NSClassFromString([keyProperty capitalizedString]) alloc] init];
                [componentObj parseDictionaryToObject: component /*andObject: componentObj*/];
                [muTemp addObject:componentObj];
                
            }
            [self setValue:muTemp.mutableCopy forKey:keyProperty];
        }
        else                                                       /* Reponse is string, int, bool... */
        {
            [self setValue:value forKey:keyProperty];
        }
    }
}


- (BOOL) checkExistKeyInObject: (id) object andKey: (NSString *) key andKeyProperty: (NSString **) keyProperties
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    NSString *ucKey             = [key uppercaseString];
    
    for (int i = 0; i < count; i++) {
        NSString *keyProperty   = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *ucKeyProperty = [keyProperty uppercaseString];
        
        /* check key exist in model */
        if ( [ucKeyProperty isEqualToString: ucKey])
        {
            *keyProperties = keyProperty;
            return YES; /* key exist in model */
        }
    }
    
    return NO; /* key not exist in model */
}

@end
