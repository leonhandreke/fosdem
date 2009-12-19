// http://www.iphonedevsdk.com/forum/iphone-sdk-development/12093-nsdate-isbetween.html

@interface NSDate (Extend)
- (BOOL)isBetweenDate:(NSDate *)dateStart andDate:(NSDate *)dateEnd;
@end