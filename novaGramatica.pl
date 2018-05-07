% Sujeito,Acao,Local,Rating,ComparadorRating,Estrelas,ComparadorEstrelas,ArrayServicos,
:- consult('dados.pl').

frase --> frase_conjuntiva(_-_).
frase(S,Output) --> {remove_modificados},frase_declarativa(S,Output).


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
  (preposicao(Z-P,Prep), comparacao(Z-P,Prep,Input,Output));
  (demonstrativo(Z-P,Prep), nome(Z-P,Lugar,Prep),{nome_lugar(Lugar),once(append(Input,[lugar-Lugar],Output))}).
%  (demonstrativo(Z-P,Dem),nome(N1-G1,Lugar,_),{nome_lugar(Lugar),demonstrativo_nome(Dem,Lugar)})

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


frase_interrogativa(Q,S,Output) --> si(N,Q,S), sv(N,S,[],Output).
si(N,Q,S) --> pronome_i(N-G,Q) , sni(N-G,S).
si(N,Q,_) --> pronome_i(N-_,Q).
sni(N-G,S) --> determinante(N-G,_),nome_composto(N-G,S,_),[que].
sni(N-G,S) --> nome_composto(N-G,S,_).

% nome_composto(N-G,S)
% svi()

remove_modificados:-
  retractall(lugar(_)),retractall(rating(_,_)),retractall(estrelas(_,_)).



verifica_sintaxe(X) :-frase(_,_,X,[]).

t_nova_gramat :-
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
verifica_sintaxe([quais,os,hoteis,que,possuem,servico,de,babysitting]),
verifica_sintaxe([quais,os,hoteis,de,faro,que,possuem,categoria,inferior,a,4,e,quartos,com,vista,de,mar]),
verifica_sintaxe([quantos,hoteis,tem,wifi,e,babysitting,e,piscina]),
\+verifica_sintaxe([quanta,hoteis,tem,wifi,e,babysitting,e,piscina]),
verifica_sintaxe([e,com,wifi]),
verifica_sintaxe([quais,os,hoteis,com,rating,inferior,a,8]),
\+verifica_sintaxe([qual,os,hoteis,com,rating,inferior,a,8]),
verifica_sintaxe([quantos,sao,os,hoteis,do,porto]).
