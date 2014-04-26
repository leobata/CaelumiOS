//
//  FormularioContatoViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"


@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

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
    if(self.contato){
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        if (self.contato.foto){
            [self.botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
        }
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criarContato)];
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    return self;
}

- (void)criarContato
{
    Contato *contato = [self pegaDadosDoFormulario];
    //[self.contatos addObject:contato];
    [self.delegate contatoAdicionado:contato];
    NSLog(@"Contato adicionado: %@", contato);
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (Contato *)pegaDadosDoFormulario
{
    if(!self.contato){
        self.contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.context];
    }
    self.contato.nome = self.nome.text;
    self.contato.endereco = self.endereco.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.site = self.site.text;
    if (self.botaoFoto.imageView.image){
        self.contato.foto = self.botaoFoto.imageView.image;
    }
    self.contato.latitude = [NSNumber numberWithDouble:[self.latitude.text doubleValue]];
    self.contato.longitude = [NSNumber numberWithDouble:[self.longitude.text doubleValue]];
    return self.contato;
}

- (id)initWithContato:(Contato *)contato
{
    self = [super init];
    if(self){
        self.contato = contato;
        self.navigationItem.title = @"Alteração";
        UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc] initWithTitle:@"Confirma" style:UIBarButtonItemStylePlain target:self action:@selector(alterarContato)];
        self.navigationItem.rightBarButtonItem = confirmButton;
    }
    
    return self;
}

- (void)alterarContato
{
    [self pegaDadosDoFormulario];
    if([self.delegate respondsToSelector:@selector(contatoAlterado:)])
    {
        [self.delegate contatoAlterado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)selecionaFoto:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
    }
    else{
        UIImagePickerController *photoLibraryPicker = [[UIImagePickerController alloc] init];
        photoLibraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoLibraryPicker.allowsEditing = YES;
        photoLibraryPicker.delegate = self;
        [self presentViewController:photoLibraryPicker animated:YES completion:nil];
    }
}

-(IBAction)buscarCoordenadas:(id)sender
{
    self.botaoLocation.hidden = YES;
    [self.rodinha startAnimating];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:^(NSArray *resultados, NSError *erro){
         if (!erro && [resultados count] > 0) {
             CLPlacemark *resultado = resultados[0];
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
        [self.rodinha stopAnimating];
        self.botaoLocation.hidden = NO;
     }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = info[UIImagePickerControllerEditedImage];
    [self.botaoFoto setImage:img forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
