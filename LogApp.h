//
//  LogApp.h
//  Price
//
//  Created by doanthegiang on 10/19/17.
//  Copyright © 2017 doanthegiang. All rights reserved.
//

#ifndef LogApp_h
#define LogApp_h



#define SHOW_LOGO NSLog(@"\n <--------LOGO_OF_GIANG ------> \n\t\t \(\\\(\\ zZZ \n\t\t \(\-\.\-\) \n\t\t \o\_\_\(\"\)\(\"\) \n ")

#define LOG_TYPE_OBJECT(Obj) NSLog(@"<<<_file: %s _func: %s -> line:%d  type_object = %@ >>",__FILE__, __func__, __LINE__, [Obj description])


#define LOG_JSON(Obj) NSLog(@"<<< JSON: %@ >>", [Obj description])



#endif /* LogApp_h */
