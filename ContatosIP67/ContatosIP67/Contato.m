//
//  Contato.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato
-(NSString *) description
{
    return [NSString stringWithFormat:@"%@ <%@>", self.nome, self.email];
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.email forKey:@"email"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
    }
    
    return self;
}

@end
