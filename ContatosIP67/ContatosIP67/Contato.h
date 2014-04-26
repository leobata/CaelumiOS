//
//  Contato.h
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Contato : NSManagedObject <NSCoding, MKAnnotation>
{
    NSString *_nome;
}
@property (strong, atomic) NSString *nome;
@property (strong, atomic) NSString *telefone;
@property (strong, atomic) NSString *endereco;
@property (strong, atomic) NSString *email;
@property (strong, atomic) NSString *site;
@property (strong, atomic) UIImage *foto;
@property (strong, atomic) NSNumber *latitude;
@property (strong, atomic) NSNumber *longitude;

@end
