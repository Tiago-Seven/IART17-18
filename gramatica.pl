%hotel(Nome,Local,Rating,Custo,Estrela,Servicos)
hotel('Hotel Borges Chiado','Lisboa',6.8,90,3,['wifi']).
hotel('Turim Terreiro Do Paço','Lisboa',8.7,91,1,[]).
hotel('TRYP Colina do Castelo','Castelo Branco',8.4,74,4,['restaurante']).
hotel('Pedras do Mar Resort and Spa','Ponta Delgada',8.6,67,5,['piscina']).
hotel('Santa Cruz','Coimbra',7.0,22,1,['piscina']).
hotel('Hotel Do Mar','Sesimbra',7.8,52,4,['wifi']).
hotel('Yellow Praia Monte Gordo','Monte Gordo',4.7,39,4,['piscina','pisos para fumadores']).
hotel('TRYP Lisboa Caparica Mar','Costa da Caparica',7.2,67,4,['wifi']).
hotel('Alfamar Beach and Sport Resort','Albufeira',7.2,39,4,['wifi']).
hotel('Meliá Braga Hotel','Braga',3.4,58,4,[]).
hotel('The Lince Azores Great Hotel','Ponta Delgada',7.9,48,4,['piscina']).
hotel('Crowne Plaza Vilamoura','Vilamoura',8.5,95,5,['wifi','piscina']).
hotel('Marquês de Pombal','Lisboa',4.5,119,4,['wifi']).
hotel('Eurostars Porto Douro','Porto',8.7,77,4,['baby-sitting','restaurante','estacionamento']).
hotel('Eurostars Oasis Plaza','Figueira da Foz',8.8,49,4,['wifi','piscina','pisos para fumadores','restaurante','baby-sitting','estacionamento','vista de mar']).

frase --> frase_declarativa(_X,_Y).
frase_declarativa(X,Y) --> sintagma_nominal(X,Y), sintagma_verbal(X,Y).
frase_declarativa(X,Y) --> sintagma_nominal(X,Y), sintagma_verbal(X,Y), conjuncao(X,Y), sintagma_verbal(X,Y).
sintagma_nominal(X,Y) --> quantificador(X,Y), um_ou_mais_nomes(X,Y).
sintagma_nominal(X,Y) --> preposicao(X,Y), nome(X,Y).
sintagma_nominal(X,Y) --> nome(X,Y).
um_ou_mais_nomes(X,Y) --> nome(X,Y).
um_ou_mais_nomes(X,Y) --> nome(X,Y), um_ou_mais_nomes(X,Y).
sintagma_verbal(X,Y) --> verbo(X,Y).
sintagma_verbal(X,Y) --> verbo(X,Y), sintagma_nominal(_,_).
sintagma_verbal(X,Y) --> verbo(X,Y), nome(X,Y), uma_ou_mais_conjucoes(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), nome(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), nome(X,Y), uma_ou_mais_conjucoes(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), sintagma_verbal(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), sintagma_verbal(X,Y), uma_ou_mais_conjucoes(X,Y).

/*Quantos (são) os hotéis do Porto?
Quais (são) os hotéis de categoria superior a 3 estrelas em Lisboa?
E em Coimbra?
Que serviços disponibiliza o Hotel X
Quais serviços disponibiliza o Hotel X?
Quais os hotéis parisienses que possuem serviço de babysitting?
Quais os hoteis de Faro que possuem categoria inferior a 4 e quartos com vista de mar?
O Hotel X fica em Faro e possui 4 estrelas.
Quantos hotéis têm wifi e babysitting e piscina?
E com wifi?
Quanto custa duas noites no hotel X?
Quais os hotéis com rating igual/superior/inferior a 8?*/

nome(s,m) --> ['hotel'].
nome(p,m) --> ['hotéis'].
nome(s,m) --> ['Porto'].
nome(s,f) --> ['Lisboa'].
nome(s,f) --> ['Coimbra'].
nome(s,m) --> ['Faro'].
nome(s,m) --> ['Castelo Branco'].
nome(s,f) --> ['Ponta Delgada'].
nome(s,f) --> ['Sesimbra'].
nome(s,m) --> ['Monte Gordo'].
nome(s,f) --> ['Costa da Caparica'].
nome(s,f) --> ['Albufeira'].
nome(s,f) --> ['Braga'].
nome(s,f) --> ['Vilamoura'].
nome(s,f) --> ['Figueira da Foz'].
nome(s,f) --> ['categoria'].
nome(s,f) --> ['estrela'].
nome(p,f) --> ['estrelas'].
nome(s,m) --> ['servico'].
nome(p,m) --> ['servicos'].
nome(s,m) --> ['quarto'].
nome(p,m) --> ['quartos'].
nome(s,f) --> ['vista de mar'].
nome(s,a) --> ['wifi'].
nome(s,a) --> ['piscina'].
nome(s,m) --> ['baby-sitting'].
nome(s,m) --> ['restaurante'].
nome(s,m) --> ['piso para fumadores'].
nome(p,m) --> ['pisos para fumadores'].
nome(s,m) --> ['estacionamento'].
nome(s,f) --> ['noite'].
nome(p,f) --> ['noites'].
nome(s,m) --> ['rating'].
nome(['Hotel Borges Chiado']).
nome(['Turim Terreiro Do Paço']).
nome(['TRYP Colina do Castelo']).
nome(['Pedras do Mar Resort and Spa']).
nome(['Santa Cruz']).
nome(['Hotel Do Mar']).
nome(['Yellow Praia Monte Gordo']).
nome(['TRYP Lisboa Caparica Mar']).
nome(['Alfamar Beach and Sport Resort']).
nome(['Meliá Braga Hotel']).
nome(['The Lince Azores Great Hotel']).
nome(['Crowne Plaza Vilamoura']).
nome(['Marquês de Pombal']).
nome(['Eurostars Porto Douro']).
nome(['Eurostars Oasis Plaza']).

adjetivo(s,_) --> ['superior'].
adjetivo(p,_) --> ['superiores'].
adjetivo(s,_) --> ['inferior'].
adjetivo(p,_) --> ['inferiores'].
adjetivo(s,_) --> ['igual'].
adjetivo(p,_) --> ['iguais'].
adjetivo(s,_) --> ['parisiense'].
adjetivo(p,_) --> ['parisienses'].
adjetivo(s,_) --> ['português'].
adjetivo(p,_) --> ['portugueses'].

numero(_,_) --> ['1'].
numero(_,_) --> ['2'].
numero(_,_) --> ['3'].
numero(_,_) --> ['4'].
numero(_,_) --> ['5'].
numero(_,_) --> ['6'].
numero(_,_) --> ['7'].
numero(_,_) --> ['8'].
numero(_,_) --> ['9'].
numero(_,_) --> ['0'].

pronome(p,m) --> ['quantos'].
pronome(s,m) --> ['quanto'].
pronome(p,f) --> ['quantas'].
pronome(s,f) --> ['quanta'].
pronome(p,_) --> ['quais'].
pronome(s,_) --> ['qual'].
pronome(_,_) --> ['que'].
verbo(s,_) --> ['é'].
verbo(p,_) --> ['são'].
verbo(s,_) --> ['disponibiliza'].
verbo(p,_) --> ['disponibilizam'].
verbo(s,_) --> ['possui'].
verbo(p,_) --> ['possuem'].
verbo(s,_) --> ['fica'].
verbo(p,_) --> ['ficam'].
verbo(s,_) --> ['tem'].
verbo(p,_) --> ['têm'].
verbo(s,_) --> ['custa'].
verbo(p,_) --> ['custam'].
quantificador(s,m) --> ['o'].
quantificador(p,m) --> ['os'].
quantificador(p,f) --> ['as'].
quantificador(s,f) --> ['a'].
quantificador(s,m) --> ['um'].
quantificador(p,m) --> ['uns'].
quantificador(s,f) --> ['uma'].
quantificador(p,f) --> ['umas'].
quantificador(p,m) --> ['dois'].
quantificador(p,f) --> ['duas'].
quantificador(p,_) --> ['tres'].
quantificador(p,_) --> ['quatro'].
quantificador(p,_) --> ['cinco'].
preposicao(s,m) --> ['do'].
preposicao(p,m) --> ['dos'].
preposicao(p,f) --> ['das'].
preposicao(s,f) --> ['da'].
preposicao(s,m) --> ['no'].
preposicao(p,m) --> ['nos'].
preposicao(s,f) --> ['na'].
preposicao(p,f) --> ['nas'].
preposicao(_,_) --> ['de'].
preposicao(_,_) --> ['em'].
preposicao(_,_) --> ['com'].
preposicao(_,_) --> ['em'].
conjuncao(_,_) --> ['e'].
pontuacao --> ['?'].

possuir(X,'rating') :- hotel(X,_,_,_,_,_).
possuir(X,'serviços') :- hotel(X,_,_,_,_,_).
possuir(X,'categoria') :- hotel(X,_,_,_,_,_).
possuir(X,'quartos') :- hotel(X,_,_,_,_,_).
possuir(X,'estrelas') :- hotel(X,_,_,_,_,_).
disponibilizar(X,'serviços') :- hotel(X,_,_,_,_,_).
com(X,'rating') :- hotel(X,_,_,_,_,_).
com(X, 'estrelas') :- hotel(X,_,_,_,_,_).
com(X, 'categoria') :- hotel(X,_,_,_,_,_).
com(X, 'serviços') :- hotel(X,_,_,_,_,_).
local('Porto').
local('Lisboa').
local('Coimbra').
local('Faro').
local('Castelo Branco').
local('Ponta Delgada').
local('Sesimbra').
local('Monte Gordo').
local('Costa da Caparica').
local('Albufeira').
local('Braga').
local('Vilamoura').
local('Figueira da Foz').
ficar(X, Y) :- hotel(X,_,_,_,_,_), local(Y).
ser('restaurante','serviço').
ser('vista de mar','serviço').
ser('wifi','serviço').
ser('piscina','serviço').
ser('baby-sitting','serviço').
ser('restaurante','serviço').
ser('piso para fumadores','serviço').
ser('pisos para fumadores','serviço').
ser('estacionamento','serviço').
ser(X, 'hotel') :- hotel(X,_,_,_,_,_).
ser(X,'numero') :- integer(X).
ter(X,'rating') :- hotel(X,_,_,_,_,_).
ter(X,'serviço') :- hotel(X,_,_,_,_,_).
ter(X, Y) :- hotel(X,_,_,_,_,_), ser(Y,'serviço').

/*rating(Hotel,Rating,igual) :-  ser(rating,inteiro), ser(Hotel,hotel), hotel(X,_,Rating,_,_,_).
rating(Hotel,Rating,maior) :- ser(rating,inteiro), ser(Hotel,hotel), hotel(Hotel,_,RatingDB,_,_,_),RatingDB > Rating.
rating(Hotel,Rating,menor) :- ser(rating,inteiro), ser(Hotel,hotel), hotel(Hotel,_,RatingDB,_,_,_),RatingDB < Rating.
estrelas(Hotel,Estrelas,igual)  :- ser(estrelas,inteiro), ser(Hotel,hotel), hotel(Hotel,_,_,_,Estrelas,_).
estrelas(Hotel,Estrelas,maior) :- ser(estrelas,inteiro), ser(Hotel,hotel), hotel(Hotel,_,_,_,EstrelasDB,_),EstrelasDB > Estrelas.
estrelas(Hotel,Estrelas,menor) :- ser(estrelas,inteiro), ser(Hotel,hotel), hotel(Hotel,_,_,_,EstrelasDB,_),EstrelasDB < Estrelas.
custo(Hotel,Custo,igual) :- ser(custo,inteiro), ser(Hotel,hotel), hotel(X,_,_,Custo,_,_).
custo(Hotel,Custo,maior) :- ser(custo,inteiro), ser(Hotel,hotel), hotel(Hotel,_,_,_,CustoDB,_),CustoDB > Custo.
custo(Hotel,Custo,menor) :- ser(custo,inteiro), ser(Hotel,hotel), hotel(Hotel,_,_,_,CustoDB,_),CustoDB < Custo.
servico(Hotel,Servico) :- ser(Hotel,hotel), hotel(Hotel,_,_,_,_,Servicos), member(Servico,Servicos).
local(Hotel,Local) :- ser(Hotel,hotel), hotel(Hotel,Local,_,_,_,_).*/
