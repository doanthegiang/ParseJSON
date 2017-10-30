# ParseJSON
 Hello guys! This is Parsing JSON method by Giang Doan
 ----
# Use
1. Method: (NSDictionary *) convertObjectToDictionary: (id) object
- Convert Object to NSDictionary if you are lazy to do it because it's so long or so params.

Example:

*Create modal
>block quote
@interface Demo: NSObject
@property (weak, nonatomic) NSString *id;
@property (weak, nonatomic) NSString *gender;
@property (weak, nonatomic) NSString *avatar;
@end
----
*Use method 
>block quote 
NSDictionary *demo = [Demo convertObjectToDictionary: [[Demo alloc] init]];
----
*Result
##usage
{
    avatar = "https://github.com/doanthegiang/ParseJSON.git";
    gender = name;
    "user_name" = giang;
}
----

2. Method: (void) parseDictionaryToObject: (NSDictionary *) dictionary
- Convert JSON to Object (before you make do it allow so you just convert JSON to NSDictionary)

Example:

*Create modal
>block quote
@interface Demo: NSObject
@property (weak, nonatomic) NSString *id;
@property (weak, nonatomic) NSString *gender;
@property (weak, nonatomic) NSString *avatar;
@end
----
*Use method 
>block quote 
*Reponse JSON:
@{
        @"id": @"1000",
        @"gender": @"10",
        @"avatar": @"giang"
}
*Use method: 
Demo *c = [[Demo alloc] init]; // init model
[c parseDictionaryToObject:[self initializationDictionary]];
----
