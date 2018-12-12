//
//  TastCenterModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TastCenterModel.h"

@implementation TastCenterModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.viewjobtotal=[dic[@"viewjobtotal"] intValue];
        self.viewjobscore=[dic[@"viewjobscore"] intValue];
        self.viewjobnow=[dic[@"viewjobnow"] intValue];
        self.viewjobdone=[dic[@"viewjobdone"] boolValue];
        self.collectjobnow=[dic[@"collectjobnow"] intValue];
        self.commentjobnow=[dic[@"commentjobnow"] intValue];
        self.praisejobnow=[dic[@"praisejobnow"] intValue];
        self.clickjobscore=[dic[@"clickjobscore"] intValue];
        self.clickjobdone=[dic[@"clickjobdone"] boolValue];
        self.postjobnow=[dic[@"postjobnow"] boolValue];
        self.postjobscore=[dic[@"postjobscore"] intValue];
        self.postjobdone=[dic[@"postjobdone"] boolValue];
        self.ideajobscore=[dic[@"ideajobscore"] intValue];
        self.ideajobnow=[dic[@"ideajobnow"] intValue];
        self.projobscore=[dic[@"projobscore"] intValue];
        self.projobnow=[dic[@"projobnow"] intValue];
        self.teamjobscore=[dic[@"teamjobscore"] intValue];
        self.teamjobnow=[dic[@"teamjobnow"] intValue];
        self.hotpostjobscore=[dic[@"hotpostjobscore"] intValue];
        self.hotpostjobnow=[dic[@"hotpostjobnow"] intValue];
        self.regjobnow=[dic[@"regjobnow"] boolValue];
        self.regjobdone=[dic[@"regjobdone"] boolValue];
        self.regjobscore=[dic[@"regjobscore"] intValue];
        self.bindjobnow=[dic[@"bindjobnow"] boolValue];
        self.bindjobdone=[dic[@"bindjobdone"] boolValue];
        self.bindjobscore=[dic[@"bindjobscore"] intValue];
        self.completejobnow=[dic[@"completejobnow"] boolValue];
        self.completejobdone=[dic[@"completejobdone"] boolValue];
        self.completejobscore=[dic[@"completejobscore"] intValue];
        self.totalscore=[dic[@"totalscore"] intValue];
        self.todayscore=[dic[@"todayscore"] intValue];
        self.todaysign=[dic[@"todaysign"] intValue];
        self.tomorrowsign=[dic[@"tomorrowsign"] intValue];
        self.Signed=[dic[@"signed"] boolValue];
    }
    return self;
}
@end
