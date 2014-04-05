//
//  Contato.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject <NSCoding>
{
    NSString *_nome;
}
@property (strong, atomic) NSString *nome;
@property (strong, atomic) NSString *telefone;
@property (strong, atomic) NSString *endereco;
@property (strong, atomic) NSString *email;
@property (strong, atomic) NSString *site;

@end
