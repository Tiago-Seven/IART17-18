% Sujeito,Acao,Local,Rating,ComparadorRating,Estrelas,ComparadorEstrelas,ArrayServicos,

frase(A,S,Ob) --> frase_declarativa(A,S,Ob).
frase --> frase_interrogativa(_-_).
frase --> frase_conjuntiva(_-_).
frase_declarativa(A,S,Ob) --> sn(N,S), sv(N,A,Ob,S).
sn(N,S) --> determinante(N-G), nome(N-G,S).
sn(N,S) --> nome(N,S).
sv(N,ficar,Ob,S) --> verbo(N,ficar,S), {!}, preposicao(N1-G1),nome(N1-G1,Ob).
sv(N,A,Ob,S) --> verbo(N,A,S), sn(_,Ob).


verifica_sintaxe(X) :-frase(X,[]).

stringToAtom([],Aux,Aux).
stringToAtom([X|Resto],Aux,Fim):-name(Atom, X),stringToAtom(Resto,[Atom|Aux],Fim).

testes_declarativas :-
verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
\+verifica_sintaxe([a,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
\+verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,1,estrelas]),
verifica_sintaxe([o,hotel,the,lince,azores,great,hotel,e,em,ponta,delgada]),
verifica_sintaxe([o,yellow,praia,monte,gordo,tem,wifi,e,fica,em,monte,gordo]),
verifica_sintaxe([o,hotel,portugues,eurostars,oasis,plaza,tem,piscina,e,quartos,com,wifi]).

testes_interrogativas:-
verifica_sintaxe([quais,sao,os,hoteis,de,categoria,superior,a,3,estrelas,em,lisboa]),
\+verifica_sintaxe([quais,sao,as,hoteis,de,categoria,superior,a,3,estrelas,em,lisboa]),
verifica_sintaxe([e,em,coimbra]),
verifica_sintaxe([que,servicos,disponibiliza,o,hotel,eurostars,porto,douro]),
\+verifica_sintaxe([que,servicos,disponibilizam,o,hotel,eurostars,porto,douro]),
verifica_sintaxe([quais,servicos,disponibiliza,o,hotel,eurostars,porto,douro]),
verifica_sintaxe([quais,os,hoteis,parisienses,que,possuem,servico,de,babysitting]),
verifica_sintaxe([quais,os,hoteis,que,possuem,servico,de,babysitting]),
\+verifica_sintaxe([quais,os,parisienses,que,possuem,servico,de,babysitting]),
verifica_sintaxe([quais,os,hoteis,de,faro,que,possuem,categoria,inferior,a,4,e,quartos,com,vista,de,mar]),
verifica_sintaxe([quantos,hoteis,tem,wifi,e,babysitting,e,piscina]),
\+verifica_sintaxe([quanta,hoteis,tem,wifi,e,babysitting,e,piscina]),
verifica_sintaxe([e,com,wifi]),
verifica_sintaxe([quais,os,hoteis,com,rating,inferior,a,8]),
\+verifica_sintaxe([qual,os,hoteis,com,rating,inferior,a,8]),
verifica_sintaxe([quantos,sao,os,hoteis,do,porto]).

nome(s-m,hotel,_Prep) --> [hotel].
nome(p-m,hotel,_Prep) --> [hoteis].
nome(s-m,porto,Prep) --> [porto],(Prep = no;Prep = do).
nome(s-f,lisboa,Prep) --> [lisboa],(Prep = em;Prep = de).
nome(s-f,coimbra,Prep) --> [coimbra],(Prep = em;Prep = de).
nome(s-m,faro,Prep) --> [faro],(Prep = em;Prep = de).
nome(s-m,castelo-branco,Prep) --> [castelo,branco],(Prep = em;Prep = de).
nome(s-f,ponta-delgada,Prep) --> [ponta,delgada],(Prep = em;Prep = de).
nome(s-f,sesimbra,Prep) --> [sesimbra],(Prep = em;Prep = de).
nome(s-m,monte-gordo,Prep) --> [monte,gordo],(Prep = em;Prep = de).
nome(s-f,costa-da-caparica,Prep) --> [costa,da,caparica],(Prep = na;Prep = da).
nome(s-f,albufeira,Prep) --> [albufeira](Prep = em;Prep = de).
nome(s-f,braga,Prep) --> [braga](Prep = em;Prep = de).
nome(s-f,vilamoura,Prep) --> [vilamoura](Prep = em;Prep = de).
nome(s-f,figueira-da-foz,Prep) --> [figueira,da,foz](Prep = na;Prep = da).
nome(s-f,categoria,_Prep) --> [categoria].
nome(s-f,estrela,_Prep) --> [estrela].
nome(p-f,estrela,_Prep) --> [estrelas].
nome(s-m,servico,_Prep) --> [servico].
nome(p-m,servico,_Prep) --> [servicos].
nome(s-m,quarto,_Prep) --> [quarto].
nome(p-m,quarto,_Prep) --> [quartos].
nome(s-f,vista-mar,_Prep) --> [vista,de,mar].
nome(s-f,vista-mar,_Prep) --> [vista,para,o,mar].
nome(s-m,mar,_Prep) --> [mar].
nome(s-_,wifi,_Prep) --> [wifi].
nome(s-f,piscina,_Prep) --> [piscina].
nome(p-f,piscina,_Prep) --> [piscinas].
nome(s-m,babysitting,_Prep) --> [baby-sitting].
nome(s-m,babysitting,_Prep) --> [babysitting].
nome(s-m,restaurante,_Prep) --> [restaurante].
nome(s-m,piso-fumar,_Prep) --> [piso,para,fumar].
nome(s-m,piso-fumar,_Prep) --> [piso,para,fumadores].
nome(s-m,estacionamento,_Prep) --> [estacionamento].
nome(s-f,noite,_Prep) --> [noite].
nome(p-f,noite,_Prep) --> [noites].
nome(s-m,rating,_Prep) --> [rating].
nome(s-m,hotel-borges-chiado,_Prep) --> [hotel,borges,chiado].
nome(s-m,hotel-borges-chiado,_Prep) --> [borges,chiado].
nome(s-m,turim-terreiro-do-paco,_Prep) --> [turim,terreiro,do,paco].
nome(s-m,turim-terreiro-do-paco,_Prep) --> [turim].
nome(s-m,tryp-colina-do-castelo,_Prep) --> [tryp,colina,do,castelo].
nome(s-m,tryp-colina-do-castelo,_Prep) --> [colina,do,castelo].
nome(s-m,pedras-do-mar-resort-and-spa,_Prep) --> [pedras,do,mar,resort,and,spa].
nome(s-m,pedras-do-mar-resort-and-spa,_Prep) --> [pedras,do,mar].
nome(s-m,santa-cruz,_Prep) --> [santa,cruz].
nome(s-m,hotel-do-mar,_Prep) --> [hotel,do,mar].
nome(s-m,yellow-praia-monte-gordo,_Prep) --> [yellow,praia,monte,gordo].
nome(s-m,yellow-praia-monte-gordo,_Prep) --> [yellow,monte,gordo].
nome(s-m,tryp-lisboa-caparica-mar,_Prep) --> [tryp,lisboa,caparica,mar].
nome(s-m,tryp-lisboa-caparica-mar,_Prep) --> [tryp,caparica,mar].
nome(s-m,alfamar-beach-and-sport-resort,_Prep) --> [alfamar,beach,and,sport,resort].
nome(s-m,alfamar-beach-and-sport-resort,_Prep) --> [alfamar,resort].
nome(s-m,melia-braga-hotel,_Prep) --> [melia,braga,hotel].
nome(s-m,melia-braga-hotel,_Prep) --> [melia,hotel].
nome(s-m,the-lince-azores-great-hotel,_Prep) --> [the,lince,azores,great,hotel].
nome(s-m,the-lince-azores-great-hotel,_Prep) --> [the,lince,great,hotel].
nome(s-m,crowne-plaza-vilamoura,_Prep) --> [crowne,plaza,vilamoura].
nome(s-m,marques-de-pombal,_Prep) --> [marques,de,pombal].
nome(s-m,eurostars-porto-douro,_Prep) --> [eurostars,porto,douro].
nome(s-m,eurostars-oasis-plaza,_Prep) --> [eurostars,oasis,plaza].
nome(s-f,manel,_Prep) --> [manel].
nome(s-f,estadia,_Prep) --> [estadia].

preposicao(s-m,do) --> [do].
preposicao(p-m,dos) --> [dos].
preposicao(p-f,das) --> [das].
preposicao(s-f,da) --> [da].
preposicao(s-m,no) --> [no].
preposicao(p-m,nos) --> [nos].
preposicao(s-f,na) --> [na].
preposicao(p-f,nas) --> [nas].
preposicao(_-_,de) --> [de].
preposicao(_-_,em) --> [em].
preposicao(_-_,com) --> [com].
preposicao(_-_,para) --> [para].

digito(s-_) --> [1].
digito(p-_) --> [2].
digito(p-_) --> [3].
digito(p-_) --> [4].
digito(p-_) --> [5].
digito(p-_) --> [6].
digito(p-_) --> [7].
digito(p-_) --> [8].
digito(p-_) --> [9].
digito(p-_) --> [0].
numero_extenso(s-m) --> [um].
numero_extenso(s-f) --> [uma].
numero_extenso(p-m) --> [dois].
numero_extenso(p-f) --> [duas].
numero_extenso(p-_) --> [tres].
numero_extenso(p-_) --> [quatro].
numero_extenso(p-_) --> [cinco].
numero(X-Y) --> numero_extenso(X-Y);digito(X-Y).

comparador(s-_) --> [superior].
comparador(p-_) --> [superiores].
comparador(s-_) --> [inferior].
comparador(p-_) --> [inferiores].
comparador(s-_) --> [igual].
comparador(p-_) --> [iguais].

adjetivo(s-_) --> [parisiense].
adjetivo(p-_) --> [parisienses].
adjetivo(s-_) --> [portugues].
adjetivo(p-_) --> [portugueses].

pronome(p-m) --> [quantos].
pronome(s-m) --> [quanto].
pronome(p-f) --> [quantas].
pronome(s-f) --> [quanta].
pronome(p-_) --> [quais].
pronome(s-_) --> [qual].
pronome(_-_) --> [que].
verbo(s,ser,_S) --> [e].
verbo(p,ser,_S) --> [sao].
verbo(s,disponibilizar,_S) --> [disponibiliza].
verbo(p,disponibilizar,_S) --> [disponibilizam].
verbo(s,possuir,_S) --> [possui].
verbo(p,possuir,_S) --> [possuem].
verbo(s,ficar,_S) --> [fica].
verbo(p,ficar,_S) --> [ficam].
verbo(s,ter,_S) --> [tem].
verbo(p,ter,_S) --> [tem].
determinante(s-m) --> [o].
determinante(p-m) --> [os].
determinante(p-f) --> [as].
determinante(s-f) --> [a].
determinante(s-m) --> [um].
determinante(s-m) --> [uns].
determinante(s-f) --> [uma].
determinante(p-f) --> [umas].
conjuncao(_-_) --> [e].

% testes semanticos
possuir(X,"rating") :- hotel(X,_,_,_,_).
possuir(X,"servicos") :- hotel(X,_,_,_,_).
possuir(X,"categoria") :- hotel(X,_,_,_,_).
possuir(X,"quartos") :- hotel(X,_,_,_,_).
possuir(X,"estrelas") :- hotel(X,_,_,_,_).
disponibilizar(X,"servicos") :- hotel(X,_,_,_,_).
com(X,"rating") :- hotel(X,_,_,_,_).
com(X, "estrelas") :- hotel(X,_,_,_,_).
com(X, "categoria") :- hotel(X,_,_,_,_).
com(X, "servicos") :- hotel(X,_,_,_,_).
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
ficar(X, Y) :- hotel(X,_,_,_,_), local(Y).
ser("restaurante,servico").
ser("vista de mar,servico").
ser("wifi,servico").
ser("piscina,servico").
ser("baby-sitting,servico").
ser("piso para fumadores,servico").
ser("pisos para fumadores,servico").
ser("estacionamento,servico").
ser(X, "hotel") :- hotel(X,_,_,_,_).
ser(X,"numero") :- integer(X).
comparador("superior").
comparador("inferior").
comparador("igual").
comparavel("estrelas", Y) :- caracteristica(Y).
comparavel("rating", Y) :- caracteristica(Y).
ter(X,"rating") :- hotel(X,_,_,_,_).
ter(X,"servico") :- hotel(X,_,_,_,_).
ter(X, Y) :- hotel(X,_,_,_,_), ser(Y,"servico").

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
