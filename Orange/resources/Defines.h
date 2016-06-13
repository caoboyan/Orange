////////////////////////////////////////////////////////////
//  Defines.h                                             //
//  Candy2                                                //
//                                                        //
//  Created by Aiwa on 10/30/15.                          //
//  Copyright © 2015 Aiwa. All rights reserved.           //
////////////////////////////////////////////////////////////

#ifndef Defines_h
#define Defines_h

#define K_SCREEN_W  [[UIScreen mainScreen] bounds].size.width
#define K_SCREEN_H [[UIScreen mainScreen] bounds].size.height


////// debug logs .... ////
#define K_DEBUG_FLAG YES
#define K_REQUEST_DETAIL YES
#define K_EASEMOB_DEBUG NO


#define EASEMOB_APPKEY      @"orangertechnologyltd#oranger"
#define EASEMOB_CERNAME  @"3candies_new_dist"




#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ORANGE_C [UIColor wbt_colorWithHexValue:0xf04124 alpha:1]
#define KEY_TABBAR_VISIBLE @"KEY_TABBAR_VISIBLE_234KAFLIAWF"
#define IMAGE_PREFIX @"http://123.127.244.149:8090/upload/"
#define IMAGE_PLACE [UIImage imageNamed:@"welcome1"]

#ifndef EVENT_HEARTS_XXX
#define EVENT_HEART_LOVE @"icon_heart_on"
#define EVENT_HEART_NO_LOVE @"icon_heart_off"
#endif


#endif /* Defines_h */



