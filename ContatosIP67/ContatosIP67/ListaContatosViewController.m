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
@end
