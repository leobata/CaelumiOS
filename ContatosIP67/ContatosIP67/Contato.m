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

@end
