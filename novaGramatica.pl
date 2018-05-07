% Sujeito,Acao,Local,Rating,ComparadorRating,Estrelas,ComparadorEstrelas,ArrayServicos,

hotel(hotel-borges-chiado,lisboa,6.8,3,[[wifi]]).
hotel(turim-terreiro-do-paco,lisboa,8.7,1,[[]]).
hotel(tryp-colina-do-castelo,castelo-branco,8.4,4,[[restaurante]]).
hotel(pedras-do-mar-resort-and-spa,ponta-delgada,8.6,5,[[piscina]]).
hotel(santa-cruz,coimbra,7.0,1,[[piscina]]).
hotel(hotel-do-mar,sesimbra,7.8,4,[[wifi]]).
hotel(yellow-praia-monte-gordo,monte-gordo,4.7,4,[[piscina],[pisos-para-fumadores]]).
hotel(tryp-lisboa-caparica-mar,costa-da-caparica,7.2,4,[[wifi]]).
hotel(alfamar-beach-and-sport-resort,albufeira,7.2,4,[[wifi]]).
hotel(melia-braga-hotel,braga,3.4,4,[[]]).
hotel(the-lince-azores-great-hotel,ponta-delgada,7.9,4,[[piscina]]).
hotel(crowne-plaza-vilamoura,vilamoura,8.5,5,[[wifi],[piscina]]).
hotel(marques-de-pombal,lisboa,4.5,4,[[wifi]]).
hotel(eurostars-porto-douro,porto,8.7,4,[[baby-sitting],[restaurante],[estacionamento]]).
hotel(eurostars-oasis-plaza,figueira-da-foz,8.8,4,[[wifi],[piscina],[pisos-para-fumadores],[restaurante],[baby-sitting],[estacionamento],[vista-de-mar]]).


frase --> frase_conjuntiva(_-_).
frase(S,Output) --> {remove_modificados},frase_declarativa(S,Output).
frase --> frase_interrogativa(_-_).

frase_declarativa(S,OutputSV) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV).
frase_declarativa(S,OutputUOMC) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV), um_ou_mais_conjuncoes(N,S,OutputSV,OutputUOMC).

% sintagma nominal
 %sem "com"  
sn(N,S,Input,Output) --> determinante(N-G,_),sujeito(N-G,S,Input,Output).
sujeito(N-G,S,_,_) --> nome(N-G,S,_).
sujeito(N-G,S,_,_) --> nome(_-_,hotel,_), nome(N-G,S,_).
 %com "com"  
sujeito(N-G,S,Input,Output) --> nome(N-G,S,_),s_n_preposicional(N-G,Input,Output).
sujeito(N-G,S,Input,Output) --> nome(_-_,hotel,_), nome(N-G,S,_),s_n_preposicional(N-G,Input,Output).

s_n_preposicional(X-Y,Input,Output) --> (preposicao(X-Y,Prep), nome(X-Y,Atr,Prep),{nome_atributo(Atr),once(append(Input,[atributo-Atr],Output))}) ;
 (preposicao(X-Y,Prep),numero(Z-P,N),nome(Z-P,estrela,Prep),{once(append(Input,[estrelas-igual-N],Output)),!}) ; 
 (preposicao(Z-P,Prep), comparacao(Z-P,Prep,Input,Output)).

comparacao(_-_,Prep,Input,Output) --> nome(Z-P,categoria,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(X-Y,Valor),nome(X-Y,estrela,Prep),{once(append(Input,[estrelas-Comparador-Valor],Output)),!}.
comparacao(_-_,Prep,Input,Output) --> nome(Z-P,categoria,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(_-_,Valor),{once(append(Input,[estrelas-Comparador-Valor],Output))}.
comparacao(_-_,Prep,Input,Output) --> nome(Z-P,rating,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(_-_,Valor),{once(append(Input,[rating-Comparador-Valor],Output))}.

sv(N,S,Input,Output) --> verbo(N,Verbo,S), {verbo_lugar(Verbo)}, {!}, preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S), {verbo_REC(Verbo)},comparacao(_-_,_,Input,Output).
sv(N,S,Input,Output) --> verbo(N,Verbo,S), {verbo_REC(Verbo)},numero(Z-P,Valor),nome(Z-P,estrela,_),{once(append(Input,[estrelas-igual-Valor],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S), {verbo_atributo(Verbo)},nome(N-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S), {verbo_atributo(Verbo)},nome(N-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).

um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,Output).
um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,OutputSV),um_ou_mais_conjuncoes(N,S,OutputSV,Output).

um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).


remove_modificados:-
  retractall(lugar(_)),retractall(rating(_,_)),retractall(estrelas(_,_)).



verifica_sintaxe(X) :-frase(_,_,X,[]).

stringToAtom([],Aux,Aux).
stringToAtom([X|Resto],Aux,Fim):-name(Atom, X),stringToAtom(Resto,[Atom|Aux],Fim).

t_nova_gramat :-
  verifica_sintaxe([o,hotel,eurostars,porto,douro,com,4,estrelas,fica,em,faro]),
  verifica_sintaxe([o,hotel,eurostars,porto,douro,com,categoria,superior,a,3,estrelas,fica,em,faro]),
  verifica_sintaxe([o,hotel,eurostars,porto,douro,com,categoria,superior,a,3,fica,em,faro]),
  verifica_sintaxe([o,hotel,eurostars,porto,douro,com,rating,superior,a,3,fica,em,faro]),
  verifica_sintaxe([o,hotel,the,lince,azores,great,hotel,e,em,ponta,delgada]),
  verifica_sintaxe([o,hotel,the,lince,azores,great,hotel,tem,wifi,e,piscina,e,e,na,figueira,da,foz,e,tem,estacionamento]),
  verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
  verifica_sintaxe([o,hotel,the,lince,azores,great,hotel,tem,wifi,e,piscina,e,e,na,figueira,da,foz]),
  \+verifica_sintaxe([a,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
  \+verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,1,estrelas]),
  verifica_sintaxe([o,yellow,praia,monte,gordo,tem,wifi,e,fica,em,monte,gordo]).

testes_declarativas :-
verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
verifica_sintaxe([o,hotel,the,lince,azores,great,hotel,tem,wifi,e,piscina,e,e,na,figueira,da,foz]),
\+verifica_sintaxe([a,hotel,eurostars,porto,douro,fica,em,faro,e,possui,4,estrelas]),
\+verifica_sintaxe([o,hotel,eurostars,porto,douro,fica,em,faro,e,possui,1,estrelas]),
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
  nome(s-m,eurostars-porto-douro,_Prep) --> [eurostars,porto,douro].
  nome(p-m,hotel,_Prep) --> [hoteis].
  nome(s-m,porto,Prep) --> [porto],{(Prep = no;Prep = do)}.
  nome(s-f,lisboa,Prep) --> [lisboa],{(Prep = em;Prep = de)}.
  nome(s-f,coimbra,Prep) --> [coimbra],{(Prep = em;Prep = de)}.
  nome(s-m,faro,Prep) --> [faro],{(Prep = em;Prep = de)}.
  nome(s-m,castelo-branco,Prep) --> [castelo,branco],{(Prep = em;Prep = de)}.
  nome(s-f,ponta-delgada,Prep) --> [ponta,delgada],{(Prep = em;Prep = de)}.
  nome(s-f,sesimbra,Prep) --> [sesimbra],{(Prep = em;Prep = de)}.
  nome(s-m,monte-gordo,Prep) --> [monte,gordo],{(Prep = em;Prep = de)}.
  nome(s-f,costa-da-caparica,Prep) --> [costa,da,caparica],{(Prep = na;Prep = da)}.
  nome(s-f,albufeira,Prep) --> [albufeira],{(Prep = em;Prep = de)}.
  nome(s-f,braga,Prep) --> [braga],{(Prep = em;Prep = de)}.
  nome(s-f,vilamoura,Prep) --> [vilamoura],{(Prep = em;Prep = de)}.
  nome(s-f,figueira-da-foz,Prep) --> [figueira,da,foz],{(Prep = na;Prep = da)}.
  nome(s-f,categoria,Prep) --> [categoria],{Prep = de;Prep=com}.
  nome(s-f,estrela,Prep) --> [estrela],{Prep = de;Prep = com}.
  nome(p-f,estrela,Prep) --> [estrelas],{Prep = de;Prep = com}.
  nome(s-m,servico,_Prep) --> [servico].
  nome(p-m,servico,_Prep) --> [servicos].
  nome(s-m,vista-mar,com) --> [quarto,com,vista,para,o,mar].
  nome(p-m,vista-mar,com) --> [quartos,com,vista,para,o,mar].
  nome(s-f,vista-mar,com) --> [vista,de,mar].
  nome(s-f,vista-mar,com) --> [vista,para,o,mar].
  nome(s-_,wifi,com) --> [wifi].
  nome(s-f,piscina,com) --> [piscina].
  nome(p-f,piscina,com) --> [piscinas].
  nome(s-m,babysitting,com) --> [baby-sitting].
  nome(s-m,babysitting,com) --> [babysitting].
  nome(s-m,restaurante,com) --> [restaurante].
  nome(p-m,piso-fumar,com) --> [pisos,para,fumar].
  nome(s-m,piso-fumar,com) --> [piso,para,fumar].
  nome(p-m,piso-fumar,com) --> [pisos,para,fumadores].
  nome(s-m,piso-fumar,com) --> [piso,para,fumadores].
  nome(s-m,estacionamento,com) --> [estacionamento].
  nome(s-m,estacionamento,com) --> [parque].
  nome(s-m,estacionamento,com) --> [parque,de,estacionamento].
  nome(s-m,rating,com) --> [rating].
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

preposicao_lugar(Prep):-
  (Prep=no;Prep=nos;Prep=na;Prep=nas;Prep=em).

nome_lugar(Lugar):-
  local(Lugar).

nome_atributo(vista-mar).
nome_atributo(wifi).
nome_atributo(piscina).
nome_atributo(babysitting).
nome_atributo(piso-fumar).
nome_atributo(estacionamento).

digito(s-_,1) --> [1].
  digito(p-_,2) --> [2].
  digito(p-_,3) --> [3].
  digito(p-_,4) --> [4].
  digito(p-_,5) --> [5].
  digito(p-_,6) --> [6].
  digito(p-_,7) --> [7].
  digito(p-_,8) --> [8].
  digito(p-_,9) --> [9].
  digito(p-_,10) --> [10].
  digito(p-_,0) --> [0].
numero_extenso(s-m,1) --> [um].
  numero_extenso(s-f,1) --> [uma].
  numero_extenso(p-m,2) --> [dois].
  numero_extenso(p-f,2) --> [duas].
  numero_extenso(p-_,3) --> [tres].
  numero_extenso(p-_,4) --> [quatro].
  numero_extenso(p-_,5) --> [cinco].
  numero_extenso(p-_,6) --> [seis].
  numero_extenso(p-_,7) --> [sete].
  numero_extenso(p-_,8) --> [oito].
  numero_extenso(p-_,9) --> [nove].
  numero_extenso(p-_,10) --> [dez].
numero(X-Y,N) --> numero_extenso(X-Y,N);digito(X-Y,N).

comparador(s-_,maior) --> [superior].
  comparador(p-_,maior) --> [superiores].
  comparador(s-_,menor) --> [inferior].
  comparador(p-_,menor) --> [inferiores].
  comparador(s-_,igual) --> [igual].
  comparador(p-_,igual) --> [iguais].



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

verbo(s,ser,S) --> [e],{hotel(S)}.
verbo(p,ser,S) --> [sao],{hotel(S)}.
verbo(s,ficar,S) --> [fica],{hotel(S)}.
verbo(p,ficar,S) --> [ficam],{hotel(S)}.
verbo(s,disponibilizar,S) --> [disponibiliza],{hotel(S)}.
verbo(p,disponibilizar,S) --> [disponibilizam],{hotel(S)}.
verbo(s,possuir,S) --> [possui],{hotel(S)}.
verbo(p,possuir,S) --> [possuem],{hotel(S)}.
verbo(s,ter,S) --> [tem],{hotel(S)}.
verbo(p,ter,S) --> [tem],{hotel(S)}.

verbo_lugar(ser).
verbo_lugar(ficar).

verbo_atributo(disponibilizar).
verbo_atributo(possuir).
verbo_atributo(ter).

% rating estrelas e categoria
verbo_REC(possuir).
verbo_REC(ter).


determinante(s-m,o) --> [o].
determinante(p-m,os) --> [os].
determinante(p-f,as) --> [as].
determinante(s-f,a) --> [a].
determinante(s-m,um) --> [um].
determinante(s-m,uns) --> [uns].
determinante(s-f,uma) --> [uma].
determinante(p-f,umas) --> [umas].
conjuncao(_-_) --> [e].

% testes semanticos
hotel(Hotel) :-
  hotel(Hotel,_,_,_,_).

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
local(porto).
local(lisboa).
local(coimbra).
local(faro).
local(castelo-branco).
local(ponta-delgada).
local(sesimbra).
local(monte-gordo).
local(costa-da-caparica).
local(albufeira).
local(braga).
local(vilamoura).
local(figueira-da-foz).
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
