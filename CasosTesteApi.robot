*** Settings ***
Suite Setup    Conectar a minha API
Resource    resourceApi.robot

*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retorna uma lista com 200 livros


Buscar a listagem de um livros (GET em um livro)
    Requisitar um livro 15
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se todos todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
    Conferir o status code    200
    Conferir o reason    OK
    Conferir dados do post Livro