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
    [aCoder encodeObject:self.foto forKey:@"foto"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
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
        self.foto = [aDecoder decodeObjectForKey:@"foto"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    
    return self;
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title
{
    return self.nome;
}

-(NSString *)subtitle
{
    return self.email;
}
@end
