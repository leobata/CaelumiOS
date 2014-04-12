//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 12/04/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import "Contato.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

-(id)init
{
    self = [super init];
    if (self) {
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:[UIImage imageNamed:@"mapa-contatos.png"] tag:0];
        self.tabBarItem = tabItem;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MKUserTrackingBarButtonItem *trackBtn = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = trackBtn;
    
    self.mapa.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapa addAnnotations:self.contatos];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mapa removeAnnotations:self.contatos];
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *pool = @"Any";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pool];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pool];
    } else {
        pin.annotation = annotation;
    }
    
    pin.pinColor = MKPinAnnotationColorRed;
    pin.canShowCallout = YES;
    
    if (((Contato*)annotation).foto) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        iv.image = ((Contato*)annotation).foto;
        pin.leftCalloutAccessoryView = iv;
    }
    
    return pin;
}
@end
