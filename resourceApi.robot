*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library     RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    	id=15
...             title=Book 15
...             pageCount=1500


*** Keywords ***
Conectar a minha API
    Create Session    FakeAPI    ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}    Get Request    FakeAPI    Books
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA} 

Conferir o status code
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings     ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}
Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com ${QTDE_LIVROS} livros
    Length Should Be    ${RESPOSTA.json()}    ${QTDE_LIVROS}

Requisitar um livro ${ID_LIVRO}
    ${RESPOSTA}    Get Request    FakeAPI    Books/${ID_LIVRO}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA} 

Conferir se todos todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}     id    ${BOOK_15.id} 
    Dictionary Should Contain Item    ${RESPOSTA.json()}     title    ${BOOK_15.title} 
    Dictionary Should Contain Item    ${RESPOSTA.json()}     pageCount    ${BOOK_15.pageCount} 
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty     ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty     ${RESPOSTA.json()["publishDate"]}

Cadastrar um novo livro
    ${HEADRES}    Create Dictionary    content-type=application/json
     ${RESPOSTA}    Post Request   FakeAPI    Books
     ...  data={"id": 200,"title": "teste","description": "teste","pageCount": 200,"excerpt": "teste","publishDate": "2022-09-02T19:49:58.290Z"}
     ...  headers=${HEADRES}
     Log    ${RESPOSTA.text}
     Set Test Variable    ${RESPOSTA} 

Conferir dados do post Livro
    Dictionary Should Contain Item    ${RESPOSTA.json()}     id    200 
    Dictionary Should Contain Item    ${RESPOSTA.json()}     title    teste 
    Dictionary Should Contain Item    ${RESPOSTA.json()}     pageCount    200 
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty     ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty     ${RESPOSTA.json()["publishDate"]}