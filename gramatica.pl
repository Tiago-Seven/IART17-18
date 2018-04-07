% base de dados

%hotel(Nome,Local,Rating,Custo,Estrela,Servicos)
hotel("Hotel Borges Chiado","Lisboa",6.8,90,3,["wifi"]).
hotel("Turim Terreiro Do Paco","Lisboa",8.7,91,1,[]).
hotel("TRYP Colina do Castelo","Castelo Branco",8.4,74,4,["restaurante"]).
hotel("Pedras do Mar Resort and Spa","Ponta Delgada",8.6,67,5,["piscina"]).
hotel("Santa Cruz","Coimbra",7.0,22,1,["piscina"]).
hotel("Hotel Do Mar","Sesimbra",7.8,52,4,["wifi"]).
hotel("Yellow Praia Monte Gordo","Monte Gordo",4.7,39,4,["piscina","pisos para fumadores"]).
hotel("TRYP Lisboa Caparica Mar","Costa da Caparica",7.2,67,4,["wifi"]).
hotel("Alfamar Beach and Sport Resort","Albufeira",7.2,39,4,["wifi"]).
hotel("Melia Braga Hotel","Braga",3.4,58,4,[]).
hotel("The Lince Azores Great Hotel","Ponta Delgada",7.9,48,4,["piscina"]).
hotel("Crowne Plaza Vilamoura","Vilamoura",8.5,95,5,["wifi","piscina"]).
hotel("Marques de Pombal","Lisboa",4.5,119,4,["wifi"]).
hotel("Eurostars Porto Douro","Porto",8.7,77,4,["baby-sitting","restaurante","estacionamento"]).
hotel("Eurostars Oasis Plaza","Figueira da Foz",8.8,49,4,["wifi","piscina","pisos para fumadores","restaurante","baby-sitting","estacionamento","vista de mar"]).

%frase --> frase_declarativa(_X,_Y).
frase --> frase_interrogativa(_X,_Y).
frase_interrogativa(X,Y) --> pronome(X,Y), sintagma_verbal_interrogativo(X,Y), sintagma_nominal_interrogativo(_,_).
frase_declarativa(X,Y) --> sintagma_nominal(X,Y), sintagma_verbal(X,Y).
frase_declarativa(X,Y) --> sintagma_nominal(X,Y), sintagma_verbal(X,Y), conjuncao(X,Y), sintagma_verbal(X,Y).
sintagma_nominal(X,Y) --> (quantificador(X,Y),numero(X,Y),nome(X,Y));(quantificador(X,Y),nome(X,Y));(quantificador(_,m), nome_hotel).
sintagma_nominal(X,Y) --> (preposicao(X,Y), nome(X,Y)) ; (preposicao(X,Y), nome(X,Y), comparacao(X,Y)).
sintagma_nominal(X,Y) --> nome(X,Y);(nome(X,Y),comparacao(X,Y)).
sintagma_nominal_interrogativo(X,Y) --> (preposicao(X,Y), nome(X,Y), comparacao(_,_));(preposicao(X,Y), nome(X,Y)).
comparacao(X,Y) --> comparador(X,Y),sintagma_nominal(X,Y).
nome_hotel --> nome(_,_).
nome_hotel --> nome(_,_), ((preposicao(X,Y), nome(X,Y), nome_hotel); nome_hotel).
sintagma_verbal(X,Y) --> verbo(X,Y).
sintagma_verbal(X,Y) --> verbo(X,Y), sintagma_nominal(_,_).
sintagma_verbal(X,Y) --> verbo(X,Y), nome(_,_), uma_ou_mais_conjucoes(_,_).
sintagma_verbal_interrogativo(X,Y) --> verbo(X,Y), sintagma_nominal(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), nome(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), nome(X,Y), uma_ou_mais_conjucoes(_,_).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), sintagma_verbal(X,Y).
uma_ou_mais_conjucoes(X,Y) --> conjuncao(X,Y), sintagma_verbal(X,Y), uma_ou_mais_conjucoes(X,Y).

verifica_sintaxe(X) :- split_string(X," "," ",L), frase(L,[]).

/*Quantos (sao) os hoteis do Porto?
Quais (sao) os hoteis de categoria superior a 3 estrelas em Lisboa?
E em Coimbra?
Que servicos disponibiliza o Hotel X
Quais servicos disponibiliza o Hotel X?
Quais os hoteis parisienses que possuem servico de babysitting?
Quais os hoteis de Faro que possuem categoria inferior a 4 e quartos com vista de mar?
O Hotel X fica em Faro e possui 4 estrelas.
Quantos hoteis tem wifi e babysitting e piscina?
E com wifi?
Quanto custa duas noites no hotel X?
Quais os hoteis com rating igual/superior/inferior a 8?*/

nome(s,m) --> ["hotel"].
nome(p,m) --> ["hoteis"].
nome(s,m) --> ["Porto"].
nome(s,f) --> ["Lisboa"].
nome(s,f) --> ["Coimbra"].
nome(s,m) --> ["Faro"].
nome(s,m) --> ["Castelo Branco"].
nome(s,f) --> ["Ponta Delgada"].
nome(s,f) --> ["Sesimbra"].
nome(s,m) --> ["Monte Gordo"].
nome(s,f) --> ["Costa da Caparica"].
nome(s,f) --> ["Albufeira"].
nome(s,f) --> ["Braga"].
nome(s,f) --> ["Vilamoura"].
nome(s,f) --> ["Figueira da Foz"].
nome(s,f) --> ["categoria"].
nome(s,f) --> ["estrela"].
nome(p,f) --> ["estrelas"].
nome(s,m) --> ["servico"].
nome(p,m) --> ["servicos"].
nome(s,m) --> ["quarto"].
nome(p,m) --> ["quartos"].
nome(s,f) --> ["vista de mar"].
nome(s,a) --> ["wifi"].
nome(s,a) --> ["piscina"].
nome(s,m) --> ["baby-sitting"].
nome(s,m) --> ["babysitting"].
nome(s,m) --> ["restaurante"].
nome(s,m) --> ["piso"].
nome(p,m) --> ["pisos"].
nome(p,m) --> ["fumadores"].
nome(s,m) --> ["estacionamento"].
nome(s,f) --> ["noite"].
nome(p,f) --> ["noites"].
nome(s,m) --> ["rating"].
nome(s,m) --> ["Hotel"].
nome(p,m) --> ["Borges"].
nome(s,m) --> ["Chiado"].
nome(s,m) --> ["Turim"].
nome(s,m) --> ["Terreiro"].
nome(s,m) --> ["Paco"].
nome(s,f) --> ["Colina"].
nome(s,m) --> ["Castelo"].
nome(p,f) --> ["Pedras"].
nome(s,m) --> ["Mar"].
nome(s,m) --> ["Resort"].
nome(_,_) --> ["and"].
nome(s,m) --> ["Spa"].
nome(s,f) --> ["Santa"].
nome(s,f) --> ["Cruz"].
nome(s,m) --> ["Mar"].
nome(s,m) --> ["Yellow"].
nome(s,f) --> ["Praia"].
nome(s,m) --> ["Monte"].
nome(s,m) --> ["Gordo"].
nome(_,_) --> ["TRYP"].
nome(s,f) --> ["Caparica"].
nome(s,m) --> ["Alfamar"].
nome(_,_) --> ["Beach"].
nome(_,_) --> ["and"].
nome(_,_) --> ["Sport"].
nome(_,_) --> ["Resort"].
nome(s,m) --> ["Melia"].
nome(_,_)  --> ["The"].
nome(s,m) -->["Lince"].
nome(p,m)-->["Azores"].
nome(_,_)-->["Great"].
nome(_,_)-->["Crowne"].
nome(_,_)-->["Plaza"].
nome(s,f)-->["Vilamoura"].
nome(s,m)-->["Marques"].
nome(s,m)-->["Pombal"].
nome(_,_)-->["Eurostars"].
nome(s,m)-->["Douro"].
nome(_,_)-->["Oasis"].
nome(s,f) --> ["manel"].

digito(_,_) --> ["1"].
digito(_,_) --> ["2"].
digito(_,_) --> ["3"].
digito(_,_) --> ["4"].
digito(_,_) --> ["5"].
digito(_,_) --> ["6"].
digito(_,_) --> ["7"].
digito(_,_) --> ["8"].
digito(_,_) --> ["9"].
digito(_,_) --> ["0"].
numero_extenso(s,m) --> ["um"].
numero_extenso(s,f) --> ["uma"].
numero_extenso(p,m) --> ["dois"].
numero_extenso(p,f) --> ["duas"].
numero_extenso(p,_) --> ["tres"].
numero_extenso(p,_) --> ["quatro"].
numero_extenso(p,_) --> ["cinco"].
numero(X,Y) --> numero_extenso(X,Y) ; digito(_,_).

comparador(s,_) --> ["superior"].
comparador(p,_) --> ["superiores"].
comparador(s,_) --> ["inferior"].
comparador(p,_) --> ["inferiores"].
comparador(s,_) --> ["igual"].
comparador(p,_) --> ["iguais"].

adjetivo(s,_) --> ["parisiense"].
adjetivo(p,_) --> ["parisienses"].
adjetivo(s,_) --> ["portugues"].
adjetivo(p,_) --> ["portugueses"].

pronome(p,m) --> ["quantos"].
pronome(s,m) --> ["quanto"].
pronome(p,f) --> ["quantas"].
pronome(s,f) --> ["quanta"].
pronome(p,_) --> ["quais"].
pronome(s,_) --> ["qual"].
pronome(_,_) --> ["que"].
verbo(s,_) --> ["e"].
verbo(p,_) --> ["sao"].
verbo(s,_) --> ["disponibiliza"].
verbo(p,_) --> ["disponibilizam"].
verbo(s,_) --> ["possui"].
verbo(p,_) --> ["possuem"].
verbo(s,_) --> ["fica"].
verbo(p,_) --> ["ficam"].
verbo(s,_) --> ["tem"].
verbo(p,_) --> ["tem"].
verbo(s,_) --> ["custa"].
verbo(p,_) --> ["custam"].
quantificador(s,m) --> ["o"].
quantificador(p,m) --> ["os"].
quantificador(p,f) --> ["as"].
quantificador(s,f) --> ["a"].
quantificador(s,m) --> ["um"].
quantificador(p,m) --> ["uns"].
quantificador(s,f) --> ["uma"].
quantificador(p,f) --> ["umas"].
preposicao(s,m) --> ["Do"].
preposicao(s,m) --> ["do"].
preposicao(p,m) --> ["dos"].
preposicao(p,f) --> ["das"].
preposicao(s,f) --> ["da"].
preposicao(s,m) --> ["no"].
preposicao(p,m) --> ["nos"].
preposicao(s,f) --> ["na"].
preposicao(p,f) --> ["nas"].
preposicao(_,_) --> ["de"].
preposicao(_,_) --> ["em"].
preposicao(_,_) --> ["com"].
preposicao(_,_) --> ["em"].
preposicao(_,_) --> ["para"].
conjuncao(_,_) --> ["e"].
pontuacao --> ["?"].

% testes semanticos
possuir(X,"rating") :- hotel(X,_,_,_,_,_).
possuir(X,"servicos") :- hotel(X,_,_,_,_,_).
possuir(X,"categoria") :- hotel(X,_,_,_,_,_).
possuir(X,"quartos") :- hotel(X,_,_,_,_,_).
possuir(X,"estrelas") :- hotel(X,_,_,_,_,_).
disponibilizar(X,"servicos") :- hotel(X,_,_,_,_,_).
com(X,"rating") :- hotel(X,_,_,_,_,_).
com(X, "estrelas") :- hotel(X,_,_,_,_,_).
com(X, "categoria") :- hotel(X,_,_,_,_,_).
com(X, "servicos") :- hotel(X,_,_,_,_,_).
com(X, "custo") :- hotel(X,_,_,_,_,_).
local("Porto").
local("Lisboa").
local("Coimbra").
local("Faro").
local("Castelo Branco").
local("Ponta Delgada").
local("Sesimbra").
local("Monte Gordo").
local("Costa da Caparica").
local("Albufeira").
local("Braga").
local("Vilamoura").
local("Figueira da Foz").
ficar(X, Y) :- hotel(X,_,_,_,_,_), local(Y).
ser("restaurante","servico").
ser("vista de mar","servico").
ser("wifi","servico").
ser("piscina","servico").
ser("baby-sitting","servico").
ser("piso para fumadores","servico").
ser("pisos para fumadores","servico").
ser("estacionamento","servico").
ser(X, "hotel") :- hotel(X,_,_,_,_,_).
ser(X,"numero") :- integer(X).
caracteristica("superior").
caracteristica("inferior").
caracteristica("igual").
adjetivo("estrelas", Y) :- caracteristica(Y).
adjetivo("rating", Y) :- caracteristica(Y).
adjetivo("custo", Y) :- caracteristica(Y).
ter(X,"rating") :- hotel(X,_,_,_,_,_).
ter(X,"servico") :- hotel(X,_,_,_,_,_).
ter(X, Y) :- hotel(X,_,_,_,_,_), ser(Y,"servico").

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
