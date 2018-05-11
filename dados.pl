hotel(hotel-borges-chiado,lisboa,6.8,3,[wifi]).
hotel(turim-terreiro-do-paco,lisboa,8.7,1,[]).
hotel(tryp-colina-do-castelo,castelo-branco,8.4,4,[restaurante]).
hotel(pedras-do-mar-resort-and-spa,ponta-delgada,8.6,5,[piscina]).
hotel(santa-cruz,coimbra,7.0,1,[piscina]).
hotel(hotel-do-mar,sesimbra,7.8,4,[wifi]).
hotel(yellow-praia-monte-gordo,monte-gordo,4.7,4,[piscina,pisos-para-fumadores]).
hotel(tryp-lisboa-caparica-mar,costa-da-caparica,7.2,4,[wifi]).
hotel(alfamar-beach-and-sport-resort,albufeira,7.2,4,[wifi]).
hotel(melia-braga-hotel,braga,3.4,4,[]).
hotel(the-lince-azores-great-hotel,ponta-delgada,7.9,4,[piscina]).
hotel(crowne-plaza-vilamoura,vilamoura,8.5,5,[wifi,piscina]).
hotel(marques-de-pombal,lisboa,4.5,4,[wifi]).
hotel(eurostars-porto-douro,porto,8.7,4,[baby-sitting,restaurante,estacionamento]).
hotel(eurostars-oasis-plaza,figueira-da-foz,8.8,4,[wifi,piscina,pisos-para-fumadores,restaurante,baby-sitting,estacionamento,vista-de-mar]).


converte_hotel_nome(hotel-borges-chiado,'Hotel Borges Chiado').
converte_hotel_nome(turim-terreiro-do-paco,'Hotel Turim Terreiro do Paco').
converte_hotel_nome(tryp-colina-do-castelo,'Hotel Tryp Colina do Castelo').
converte_hotel_nome(pedras-do-mar-resort-and-spa,'Hotel Pedras do Mar resort and spa').
converte_hotel_nome(santa-cruz,'Hotel Santa Cruz').
converte_hotel_nome(hotel-do-mar,'Hotel do Mar').
converte_hotel_nome(yellow-praia-monte-gordo,'Hotel Yellow Praia Monte Gordo').
converte_hotel_nome(tryp-lisboa-caparica-mar,'Hotel Tryp Lisboa Caparica Mar').
converte_hotel_nome(alfamar-beach-and-sport-resort,'Hotel Alfamar Beach and Sport Resort').
converte_hotel_nome(melia-braga-hotel,'Hotel Melia Braga').
converte_hotel_nome(the-lince-azores-great-hotel,'The Linze Azores Great Hotel').
converte_hotel_nome(crowne-plaza-vilamoura,'Hotel Crowne Plaza Vilamoura').
converte_hotel_nome(marques-de-pombal,'Hotel Marques do Pombal').
converte_hotel_nome(eurostars-porto-douro,'Hotel Eurostars Porto Douro').
converte_hotel_nome(eurostars-oasis-plaza,'Hotel Eurostars Oasis Plaza').

converte_servico_nome(wifi,'wifi').
converte_servico_nome(restaurante,'restaurante').
converte_servico_nome(piscina,'piscina').
converte_servico_nome(pisos-para-fumadores,'pisos para fumadores').
converte_servico_nome(baby-sitting,'babysitting').
converte_servico_nome(estacionamento,'estacionamento').
converte_servico_nome(vista-de-mar,'vista de mar').

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
  nome(s-m,vista-mar,com) --> [quarto,com,vista,de,mar].
  nome(p-m,vista-mar,com) --> [quartos,com,vista,de,mar].
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
  nome(s-m,rating,Prep) --> [rating],{Prep=com;Prep=do}.
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

  nome(s-m,hotel-borges-chiado,_Prep) --> [hotel,borges,chiado].
  nome(s-m,turim-terreiro-do-paco,_Prep) --> [hotel,turim,terreiro,do,paco].
  nome(s-m,turim-terreiro-do-paco,_Prep) --> [hotel,turim].
  nome(s-m,tryp-colina-do-castelo,_Prep) --> [hotel,tryp,colina,do,castelo].
  nome(s-m,tryp-colina-do-castelo,_Prep) --> [hotel,colina,do,castelo].
  nome(s-m,pedras-do-mar-resort-and-spa,_Prep) --> [hotel,pedras,do,mar,resort,and,spa].
  nome(s-m,pedras-do-mar-resort-and-spa,_Prep) --> [hotel,pedras,do,mar].
  nome(s-m,santa-cruz,_Prep) --> [hotel,santa,cruz].
  nome(s-m,yellow-praia-monte-gordo,_Prep) --> [hotel,yellow,praia,monte,gordo].
  nome(s-m,yellow-praia-monte-gordo,_Prep) --> [hotel,yellow,monte,gordo].
  nome(s-m,tryp-lisboa-caparica-mar,_Prep) --> [hotel,tryp,lisboa,caparica,mar].
  nome(s-m,tryp-lisboa-caparica-mar,_Prep) --> [hotel,tryp,caparica,mar].
  nome(s-m,alfamar-beach-and-sport-resort,_Prep) --> [hotel,alfamar,beach,and,sport,resort].
  nome(s-m,alfamar-beach-and-sport-resort,_Prep) --> [hotel,alfamar,resort].
  nome(s-m,melia-braga-hotel,_Prep) --> [hotel,melia,braga,hotel].
  nome(s-m,melia-braga-hotel,_Prep) --> [hotel,melia,hotel].
  nome(s-m,the-lince-azores-great-hotel,_Prep) --> [hotel,the,lince,azores,great,hotel].
  nome(s-m,the-lince-azores-great-hotel,_Prep) --> [hotel,the,lince,great,hotel].
  nome(s-m,crowne-plaza-vilamoura,_Prep) --> [hotel,crowne,plaza,vilamoura].
  nome(s-m,marques-de-pombal,_Prep) --> [hotel,marques,de,pombal].
  nome(s-m,eurostars-oasis-plaza,_Prep) --> [hotel,eurostars,oasis,plaza].
  nome(s-m,eurostars-porto-douro,_Prep) --> [hotel,eurostars,porto,douro].
  nome(s-f,manel,_Prep) --> [manel].
  nome(s-f,estadia,_Prep) --> [estadia].

nome_lugar(Lugar):-
  local(Lugar).

sujeito_atributo(servico).

nome_atributo(vista-mar).
nome_atributo(wifi).
nome_atributo(piscina).
nome_atributo(babysitting).
nome_atributo(piso-fumar).
nome_atributo(estacionamento).

perguntavel(hotel).
perguntavel(rating).
perguntavel(categoria).
perguntavel(estrela).
perguntavel(servico).
 
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

demonstrativo(s-m,do) --> [do].
  demonstrativo(p-m,dos) --> [dos].
  demonstrativo(p-f,das) --> [das].
  demonstrativo(s-f,da) --> [da].
  demonstrativo(_-_,de) --> [de].

demonstrativo_nome(do,porto).
demonstrativo_nome(do,porto).
demonstrativo_nome(do,porto).
demonstrativo_nome(do,porto).
demonstrativo_nome(do,porto).


preposicao_lugar(Prep):-
  (Prep=no;Prep=nos;Prep=na;Prep=nas;Prep=em).


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

adv_quantidade(_-_,maior) --> [mais,de].
adv_quantidade(_-_,menor) --> [menos,de].

adjetivo(s-_) --> [parisiense].
  adjetivo(p-_) --> [parisienses].
  adjetivo(s-_) --> [portugues].
  adjetivo(p-_) --> [portugueses].

pronome_i(p-m,quantos) --> [quantos].
  pronome_i(s-m,quanto) --> [quanto].
  pronome_i(p-f,quantas) --> [quantas].
  pronome_i(p-_,quais) --> [quais].
  pronome_i(s-_,qual) --> [qual].
  pronome_i(_-_,que) --> [que].

pronome_i2tipo(quantos,qt).
  pronome_i2tipo(quanto,qt).
  pronome_i2tipo(quantas,qt).
  pronome_i2tipo(quais,ql).
  pronome_i2tipo(qual,ql).
  pronome_i2tipo(que,ql).

verbo(s,ser,S,d) --> [e],{hotel(S)}.
verbo(s,ser,S,i) --> [e],{hotel(S);perguntavel(S)}.
verbo(p,ser,S,d) --> [sao],{hotel(S)}.
verbo(p,ser,S,i) --> [sao],{hotel(S);perguntavel(S)}.
verbo(s,ficar,S,d) --> [fica],{hotel(S)}.
verbo(s,ficar,S,i) --> [fica],{hotel(S);S=hotel}.
verbo(p,ficar,S,d) --> [ficam],{hotel(S)}.
verbo(p,ficar,S,i) --> [ficam],{hotel(S);S=hotel}.
verbo(s,disponibilizar,S,d) --> [disponibiliza],{hotel(S)}.
verbo(s,disponibilizar,S,i) --> [disponibiliza],{hotel(S);S=hotel;S=servico}.
verbo(p,disponibilizar,S,d) --> [disponibilizam],{hotel(S)}.
verbo(p,disponibilizar,S,i) --> [disponibilizam],{hotel(S);S=hotel;S=servico}.
verbo(s,possuir,S,d) --> [possui],{hotel(S)}.
verbo(s,possuir,S,i) --> [possui],{hotel(S);perguntavel(S)}.
verbo(p,possuir,S,d) --> [possuem],{hotel(S)}.
verbo(p,possuir,S,i) --> [possuem],{hotel(S);perguntavel(S)}.
verbo(s,ter,S,d) --> [tem],{hotel(S)}.
verbo(s,ter,S,i) --> [tem],{hotel(S);perguntavel(S)}.
verbo(p,ter,S,d) --> [tem],{hotel(S)}.
verbo(p,ter,S,i) --> [tem],{hotel(S);perguntavel(S)}.
verbo(p,existir,S,d) --> [existem],{hotel(S)}.
verbo(p,existir,S,i) --> [existem],{hotel(S);S=hotel}.
verbo(s,existir,S,d) --> [existe],{hotel(S)}.
verbo(s,existir,S,i) --> [existe],{hotel(S);S=hotel}.
verbo(_,existir,S,d) --> [ha],{hotel(S)}.
verbo(_,existir,S,i) --> [ha],{hotel(S);S=hotel}.

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
