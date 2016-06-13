

#import "SuserModel.h"

@implementation SuserModel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.uid = [coder decodeIntegerForKey:@"uid"];
        self.utype = [coder decodeObjectForKey:@"utype"];
        self.userid = [coder decodeObjectForKey:@"userid"];
        self.pwd = [coder decodeObjectForKey:@"pwd"];
        self.uname = [coder decodeObjectForKey:@"uname"];
        self.birthday = [coder decodeObjectForKey:@"birthday"];
        self.sex = [coder decodeObjectForKey:@"sex"];
        self.rank = [coder decodeObjectForKey:@"rank"];
        self.address = [coder decodeObjectForKey:@"address"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.mobile = [coder decodeObjectForKey:@"mobile"];
        self.jointime = [coder decodeObjectForKey:@"jointime"];
        self.logintime = [coder decodeObjectForKey:@"logintime"];
        self.Picture = [coder decodeObjectForKey:@"Picture"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.uid forKey:@"uid"];
    [coder encodeObject:self.utype forKey:@"utype"];
    [coder encodeObject:self.userid forKey:@"userid"];
    [coder encodeObject:self.pwd forKey:@"pwd"];
    [coder encodeObject:self.uname forKey:@"uname"];
    [coder encodeObject:self.birthday forKey:@"birthday"];
    [coder encodeObject:self.sex forKey:@"sex"];
    [coder encodeObject:self.rank forKey:@"rank"];
    [coder encodeObject:self.address forKey:@"address"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.jointime forKey:@"jointime"];
    [coder encodeObject:self.logintime forKey:@"logintime"];
    [coder encodeObject:self.Picture forKey:@"Picture"];
}





+(SuserModel*) fromDict:(NSDictionary*) dict
{
    SuserModel *model = [SuserModel yy_modelWithDictionary:dict];
    return model;
}

+(NSArray*) fromArray:(NSArray*) array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        SuserModel *model = [SuserModel fromDict:dict];
        [arr addObject:model];
    }
    return [NSArray arrayWithArray:arr];
}




@end
