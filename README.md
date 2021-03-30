<h1 align="center"> 
	🏋️‍♂️ Smartflix - Sistema de Matrículas e Planos 🏋️‍♀️
</h1>

<p align="center">
  <img src="http://img.shields.io/static/v1?label=License&message=MIT&color=green&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=Ruby&message=2.7.2&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=6.1.3&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E90&color=GREEN&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

> Status do Projeto: :warning: em desenvolvimento

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#funcionalidades)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação-arrow_forward)

:small_blue_diamond: [Como rodar os testes](#como-rodar-os-testes)

:small_blue_diamond: [JSON](#json-floppy_disk)

:small_blue_diamond: [Usuários](#usuários)

:small_blue_diamond: [Iniciando/Configurando banco de dados](#iniciando/configurando-banco-de-dados)


## Descrição do projeto 

<p align="justify">
  Sistema responsável pela criação e gerenciamento dos planos e matrículas da plataforma Smartflix. Implementa as funcionalidades necessárias para que pessoas interessadas em contratar o serviço de aulas por streaming, sejam capazes de criar uma conta e adquirir planos.
</p>

## Funcionalidades

:heavy_check_mark: Cadastro de Categorias de Aulas  

:heavy_check_mark: Cadastro de Planos  

:heavy_check_mark: Compra de Planos pela plataforma  

:heavy_check_mark: Criação de tokens para alunos  

## Pré-requisitos

:warning: [Ruby](https://www.ruby-lang.org/en/news/2020/10/02/ruby-2-7-2-released/)

:warning: [SQLite3](https://www.sqlite.org/index.html)

:warning: [Rails](https://rubyonrails.org/)

:warning: [Rails](https://rubyonrails.org/)

## Como rodar a aplicação :arrow_forward:

No terminal, clone o projeto: 

```
git clone https://github.com/TreinaDev/enrollment-system
```

Abra o diretório pelo terminal

```bash
cd  enrollment-system
```

Rode o script bin setup para configurar o projeto

```bash
bin/setup
```

## Como rodar os testes

Para rodar os testes da aplicação, execute o comando:

```
$ bundle exec rspec 
```

## JSON :floppy_disk:

### Usuários: 

|name|email|password|
| -------- |-------- |-------- |
|Renato|renato@flix.com.br|123456|
|Maria|maria@smartflix.com.br|123457|

## Iniciando/Configurando banco de dados

Para popular o projeto, utilize o comando:
```
$ rails db:seed 
```

## Desenvolvedores/Contribuintes :octocat:

| [<img src="https://avatars.githubusercontent.com/u/45540147?v=4" width=115><br><sub>Lucas Sanches</sub>](https://github.com/sancheslz) |  [<img src="https://avatars.githubusercontent.com/u/74281572?v=4" width=115><br><sub>Leticia Oliveira</sub>](https://github.com/leticiaoliveira5) |  [<img src="https://avatars.githubusercontent.com/u/72029258?v=4" width=115><br><sub>Helio Matsubaya</sub>](https://github.com/Matsubayashi-Helio) | [<img src="https://avatars.githubusercontent.com/u/19741423?v=4" width=115><br><sub>Filipe Pinato</sub>](https://github.com/tiofih) |  [<img src="https://avatars.githubusercontent.com/u/70206232?v=4" width=115><br><sub>Julia Jubileu</sub>](https://github.com/JuliaJubileu) |  [<img src="https://avatars.githubusercontent.com/u/5360344?v=4" width=115><br><sub>Murilo Miranda</sub>]() |
| :---: | :---: | :---: | :---: | :---: | :---: 

## Licença 

The [MIT License]() (MIT)

Copyright :copyright: 2021 - Smartflix - Sistema de Matrículas e Planos