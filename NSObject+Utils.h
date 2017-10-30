//
//  NSObject+Utils.h
//  Price
//
//  Created by doanthegiang on 10/27/17.
//  Copyright © 2017 doanthegiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utils)

/**
 @parse Object to JSON
 */

- (NSDictionary *) convertObjectToDictionary: (id) object;


/**
  @parse JSON to Object
 */
- (void) parseDictionaryToObject: (NSDictionary *) dictionary;

@end
