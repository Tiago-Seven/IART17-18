% Sujeito,Acao,Local,Rating,ComparadorRating,Estrelas,ComparadorEstrelas,ArrayServicos,
:- consult('dados.pl').

frase --> frase_conjuntiva(_-_).
frase(S,Output) --> {remove_modificados},frase_interrogativa(_,S,Output).
frase(S,Output) --> {remove_modificados},frase_declarativa(S,Output).



frase_declarativa(S,OutputSV) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV).
frase_declarativa(S,OutputUOMC) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV), um_ou_mais_conjuncoes(N,S,OutputSV,OutputUOMC).

% sintagma nominal
 %sem "com"  
sn(N,S,Input,Output) --> determinante(N-G,_),sujeito(N-G,S,Input,Output).
sujeito(N-G,S,_,_) --> nome(N-G,S,_).
sujeito(N-G,S,_,_) --> nome(_-_,hotel,_), nome(N-G,S,_).
 %com "com"  
sujeito(N-G,S,Input,Output) --> nome(N-G,S,_),s_n_preposicional(N-G,Input,Output,d).

s_n_preposicional(X-Y,Input,Output,Tipo) --> (preposicao(X-Y,Prep), nome(X-Y,Atr,Prep),{nome_atributo(Atr),once(append(Input,[atributo-Atr],Output))}) ;
  (preposicao(X-Y,Prep),numero(Z-P,N),nome(Z-P,estrela,Prep),{once(append(Input,[estrelas-igual-N],Output)),!}) ; 
  (preposicao(Z-P,Prep), comparacao(Z-P,Prep,Input,Output));
  (demonstrativo(Z-P,Prep), nome(Z-P,Lugar,Prep),{nome_lugar(Lugar),once(append(Input,[lugar-Lugar],Output))});
  ({Tipo=i},preposicao(Z-P,Prep),nome(Z-P,Lugar,Prep),{nome_lugar(Lugar),once(append(Input,[lugar-Lugar],Output))});
  ({Tipo=i},preposicao(Z-P,Prep),nome(Z-P,Hotel,Prep),{hotel(Hotel),once(append(Input,[hotel-Hotel],Output))}).
%  (demonstrativo(Z-P,Dem),nome(N1-G1,Lugar,_),{nome_lugar(Lugar),demonstrativo_nome(Dem,Lugar)})

comparacao(_-_,Prep,Input,Output) --> nome(Z-P,categoria,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(X-Y,Valor),nome(X-Y,estrela,Prep),{once(append(Input,[estrelas-Comparador-Valor],Output)),!}.
comparacao(_-_,Prep,Input,Output) --> nome(Z-P,categoria,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(_-_,Valor),{once(append(Input,[estrelas-Comparador-Valor],Output))}.
comparacao(_-_,Prep,Input,Output) --> nome(Z-P,rating,Prep), comparador(Z-P,Comparador),determinante(_-_,a),numero(_-_,Valor),{once(append(Input,[rating-Comparador-Valor],Output))}.

sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_lugar(Verbo)}, {!}, preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_REC(Verbo)},comparacao(_-_,_,Input,Output).
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_REC(Verbo)},numero(Z-P,Valor),nome(Z-P,estrela,_),{once(append(Input,[estrelas-igual-Valor],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_atributo(Verbo)},nome(N-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_atributo(Verbo)},nome(N-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).

um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,Output).
um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,OutputSV),um_ou_mais_conjuncoes(N,S,OutputSV,Output).

um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).



frase_interrogativa(Q,S,Output) --> si(_,Q,S,Output), {perguntavel(S)}.
frase_interrogativa(Q,S,Output) --> si(_,Q,S,OutputSI), {perguntavel(S)} ,svi(_,S,OutputSI,Output).

si(N,Q,S,Output) --> pronome_i(N-G,Pronome), {pronome_i2tipo(Pronome,Q)} , sni(N-G,S,Output).
si(N,Q,_,_) --> pronome_i(N-_,Pronome), {pronome_i2tipo(Pronome,Q)}.
si(N,Q,S,Output) --> pronome_i(N-G,Pronome), {pronome_i2tipo(Pronome,Q)} ,verbo(N,ser,S,i), {Pronome \= que}, sni(N-G,S,Output).
si(N,Q,S,_) --> pronome_i(N-_,Pronome), {pronome_i2tipo(Pronome,Q)},verbo(N,ser,S,i),{Pronome \= que}.

sni(N-G,S,Output) --> determinante(N-G,_),nome_composto(N-G,S,Output),[que] ,\+ nothing.
sni(N-G,S,Output) --> determinante(N-G,_),nome_composto(N-G,S,Output), nothing.
sni(N-G,S,Output) --> nome_composto(N-G,S,Output).

nome_composto(N-G,S,_) --> nome(N-G,S,_).
nome_composto(N-G,S,Output) --> nome(N-G,S,_),um_ou_mais_s_n_preposicional(_-_,[],Output).

svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_lugar(Verbo)}, {!}, preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],Output))}.
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_REC(Verbo)},comparacao(_-_,_,Input,Output).
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_REC(Verbo)},numero(Z-P,Valor),nome(Z-P,estrela,_),{once(append(Input,[estrelas-igual-Valor],Output))}.
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_REC(Verbo)}, determinante(N-Y,_),nome(N-Y,Hotel,_),{hotel(Hotel),once(append(Input,[hotel-Hotel],Output))}.
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_REC(Verbo)}, determinante(N-Y,_),nome(N-Y,Hotel,_),{hotel(Hotel),once(append(Input,[hotel-Hotel],OutputHotel))},um_ou_mais_s_n_preposicional(_-_,OutputHotel,Output).
svi(_,S,Input,Output) --> verbo(_,Verbo,S,i), {verbo_atributo(Verbo)},nome(_-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
svi(_,S,Input,Output) --> verbo(_,Verbo,S,i), {verbo_atributo(Verbo)},nome(_-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_atributo(Verbo),sujeito_atributo(S)},determinante(N-Y,_),nome(N-Y,Hotel,_),{hotel(Hotel),once(append(Input,[hotel-Hotel],Output))}.
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_atributo(Verbo),sujeito_atributo(S)},determinante(N-Y,_),nome(N-Y,Hotel,_),{hotel(Hotel),once(append(Input,[hotel-Hotel],OutputHotel))},um_ou_mais_s_n_preposicional(_-_,OutputHotel,Output).
svi(N,S,A,A) --> verbo(N,existir,S,i).
svi(N,S,Input,Output) --> verbo(N,existir,S,i),preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],Output))}.
svi(N,S,Input,Output) --> verbo(N,existir,S,i),preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],OutputLugar))},um_ou_mais_s_n_preposicional(_-_,OutputLugar,Output).
svi(N,S,Input,Output) --> verbo(N,existir,S,i),um_ou_mais_s_n_preposicional(_-_,Input,Output).


um_ou_mais_s_n_preposicional(_-_,Input,Output) --> s_n_preposicional(_-_,Input,Output,i).
um_ou_mais_s_n_preposicional(_-_,Input,Output) --> s_n_preposicional(_-_,Input,Output1,i),um_ou_mais_s_n_preposicional(_-_,Output1,Output).

% nothing --> [].

remove_modificados:-
  retractall(lugar(_)),retractall(rating(_,_)),retractall(estrelas(_,_)).



verifica_sintaxe(X) :-frase(_,_,X,[]).

% TODO ver cenas compatives por exemplo hotel/rating mas nao servico/atributo
t_nova_gramat_i:-
  verifica_sintaxe([quais,sao,os,hoteis,do,porto]),
  verifica_sintaxe([que,hoteis,ha,no,porto,com,5,estrelas]),
  verifica_sintaxe([quantos,hoteis,ha,no,porto,com,5,estrelas]),
  verifica_sintaxe([quais,sao,os,hoteis,do,porto,com,5,estrelas]),
  verifica_sintaxe([quais,os,hoteis,com,rating,inferior,a,8]),
  verifica_sintaxe([quais,os,hoteis,que,possuem,rating,inferior,a,8]),
  verifica_sintaxe([quais,os,hoteis,que,tem,rating,inferior,a,8]),
  verifica_sintaxe([quais,sao,os,hoteis,que,ficam,no,porto]),
  verifica_sintaxe([qual,e,o,rating,do,eurostars,oasis,plaza]),
  verifica_sintaxe([quais,sao,os,hoteis,de,categoria,superior,a,3,estrelas,em,lisboa]),
  \+verifica_sintaxe([quais,sao,as,hoteis,de,categoria,superior,a,3,estrelas,em,lisboa]),
  verifica_sintaxe([que,servicos,disponibiliza,o,hotel,eurostars,porto,douro]),
  \+verifica_sintaxe([que,servicos,disponibilizam,o,hotel,eurostars,porto,douro]),
  verifica_sintaxe([quais,servicos,disponibiliza,o,eurostars,porto,douro]),
  verifica_sintaxe([que,rating,tem,o,eurostars,oasis,plaza]).


t_nova_gramat_d :-
  verifica_sintaxe([o,hotel,eurostars,porto,douro,com,4,estrelas,fica,em,faro]),
  verifica_sintaxe([o,hotel,eurostars,porto,douro,de,faro,fica,em,faro]),
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

testes_interrogativas:-
  verifica_sintaxe([quais,os,hoteis,que,possuem,servico,de,babysitting]),
  verifica_sintaxe([quais,os,hoteis,de,faro,que,possuem,categoria,inferior,a,4,e,quartos,com,vista,de,mar]),
  verifica_sintaxe([quantos,hoteis,tem,wifi,e,babysitting,e,piscina]),
  verifica_sintaxe([quais,os,hoteis,com,rating,inferior,a,8]),
  \+verifica_sintaxe([qual,os,hoteis,com,rating,inferior,a,8]),
  verifica_sintaxe([quantos,sao,os,hoteis,do,porto]).

testes_conjuntivas :-
  verifica_sintaxe([e,em,coimbra]),
  verifica_sintaxe([e,com,wifi]).

if_then_else(Condition, Action1, _) :- Condition, !, Action1.  
if_then_else(_, _, Action2) :- Action2.

nothing(A,[]):-A=[].