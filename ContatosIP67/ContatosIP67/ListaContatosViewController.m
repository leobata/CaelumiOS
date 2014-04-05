//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios4341 on 29/03/14.
//  Copyright (c) 2014 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm)];
        self.navigationItem.rightBarButtonItem = addButton;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.linhaSelecionada = -1;
    }
    return self;
}

-(void) exibeForm
{
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] init];
    //form.contatos = self.contatos;
    form.delegate = self;
    [self.navigationController pushViewController:form animated:YES];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contatos count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pool = @"pool";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pool];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool];
    }
    Contato *contato = self.contatos[indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Contato *contato = self.contatos[sourceIndexPath.row];
    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
    [self.contatos insertObject:contato atIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato:[self.contatos objectAtIndex:indexPath.row]];
    form.delegate = self;
    [self.navigationController pushViewController:form animated:YES];
}

-(void)contatoAdicionado:(Contato *)contato
{
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
    [self.contatos addObject:contato];
}

-(void)contatoAlterado:(Contato *)contato
{
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
    NSLog(@"Contato:%@ foi alterado", contato);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath *_indexPath = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];
    [self.tableView selectRowAtIndexPath:_indexPath animated:animated scrollPosition:UITableViewScrollPositionMiddle];
    self.linhaSelecionada = -1;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:lp];
}
-(void)exibeMaisAcoes:(UIGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:ponto];
        Contato *contato = self.contatos[ip.row];
        contatoSelecionado = contato;
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancela" destructiveButtonTitle:nil otherButtonTitles:@"Ligar",@"Enviar email",@"Mostrar mapa",@"Abrir site", nil];
        [as showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self mostrarMapa];
            break;
        case 3:
            [self abrirSite];
            break;
        default:
            break;
    }
}

-(void)ligar
{
    NSLog(@"Ligar para %@",contatoSelecionado.telefone);
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString *strUrl = [NSString stringWithFormat:@"tel:%@",contatoSelecionado.telefone];
        [self abrirAplicativoComUrl:strUrl];
    }
    else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Este dispositivo não suporta ligações."delegate:nil cancelButtonTitle:@"Que saco" otherButtonTitles:nil];
        [av show];
    }
}

-(void)enviarEmail
{
    NSLog(@"Enviar email para %@",contatoSelecionado.email);
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[contatoSelecionado.email]];
        [mailComposer setSubject:@"ContatosIP67"];
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
    else{
        
    }
}

-(void)mostrarMapa
{
    NSLog(@"Mostrar mapa em %@",contatoSelecionado.endereco);
    NSString *strUrl = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComUrl:strUrl];
}

-(void)abrirSite
{
    NSLog(@"Abrir site %@",contatoSelecionado.site);
    [self abrirAplicativoComUrl:contatoSelecionado.site];
}

-(void)abrirAplicativoComUrl:(NSString *)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
