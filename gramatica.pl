:- consult('dados.pl').

frase(_,Output,Resposta) --> frase_conjuntiva(Output),nothing,{!,tipo_questao(Q),responde_c(Output,Q,Resposta)}.
frase(S,Output,Resposta) --> {remove_modificados},frase_interrogativa(Q,S,Output),nothing,{!,assert(tipo_questao(Q)),assert(sujeito_questao(S)),responde_i(Output,S,Q,Resposta)}.
frase(S,Output,Resposta) --> {remove_modificados},frase_declarativa(S,Output),nothing,
  {!,verifica_output(Output),insere_restricoes(Output),assert(nome_hotel(S)),assert(tipo_questao(d)),findall(Nome,responde(Nome),Hoteis),length(Hoteis,N),if_then_else(N>=1,Resposta='Sim! :)',Resposta='Nao :(')}.

responde_c(Array,d,Resposta) :-
  verifica_output(Array),retira_duplicado(Array),insere_restricoes(Array),
  findall(Nome,responde(Nome),Hoteis),length(Hoteis,N),if_then_else(N>=1,Resposta='Sim! :)',Resposta='Nao :(').

responde_c(Array,Q,Resposta) :-
    retira_duplicado(Array),sujeito_questao(S),responde_i(Array,S,Q,Resposta).

retira_duplicado([]).
retira_duplicado([lugar-Lugar|R]):-
  if_then(lugar(_),(retractall(lugar(_)),assert(lugar(Lugar)))),
  retira_duplicado(R).

retira_duplicado([rating-Comparador-Valor|R]):-
  if_then(lugar(_),(retractall(rating(_,_)),assert(rating(Comparador,Valor)))),
  retira_duplicado(R).

retira_duplicado([estrelas-Comparador-Valor|R]):-
  if_then(lugar(_),(retractall(estrelas(_,_)),assert(estrelas(Comparador,Valor)))),
  retira_duplicado(R).

retira_duplicado([hotel-Hotel|R]):-
  if_then(nome_hotel(_),(retractall(nome_hotel(_)),assert(nome_hotel(Hotel)))),
  retira_duplicado(R).

retira_duplicado([_|R]):-
  retira_duplicado(R).

responde_i(Array,hotel,Q,Resposta) :-
  verifica_output(Array),insere_restricoes(Array),findall(Nome,responde(Nome),Hoteis),length(Hoteis,N),if_then_else(N>=1,resposta_tipo_hotel(Hoteis,Q,Resposta),(Resposta='Nao temos resultados para a sua questao :(')).
responde_i(Array,rating,_,Resposta) :-
  verifica_output(Array),insere_restricoes(Array),findall(Nome,responde(Nome),Hoteis),
  nth0(0,Hoteis,Hotel),
  hotel(Hotel,_,Rating,_,_),
  number_chars(Rating, Chars),
  atom_chars(T, Chars),
  atom_concat('O hotel tem o rating de: ',T,Resposta).

responde_i(Array,estrela,_,Resposta) :-
  verifica_output(Array),insere_restricoes(Array),findall(Nome,responde(Nome),Hoteis),
  nth0(0,Hoteis,Hotel),
  hotel(Hotel,_,_,Estrelas,_),
  number_chars(Estrelas, Chars),
  atom_chars(T, Chars),
  atom_concat('O hotel tem ',T,Aux),
  if_then_else(Estrelas > 1, atom_concat(Aux,' estrelas ',Resposta),atom_concat(Aux,' estrela ',Resposta)).

responde_i(Array,servico,Q,Resposta):-
  verifica_output(Array),insere_restricoes(Array),findall(Nome,responde(Nome),Hoteis),
  nth0(0,Hoteis,Hotel),
  hotel(Hotel,_,_,_,Servicos),
  resposta_tipo_servicos(Servicos,Q,Resposta).

resposta_tipo_servicos(Servicos,qt,Resposta):-
  length(Servicos,Tamanho),
  number_chars(Tamanho, Chars),
  atom_chars(T, Chars),
  atom_concat('O hotel tem ',T,RAux),
  if_then_else(Tamanho > 1, atom_concat(RAux,' servicos ',Resposta),atom_concat(RAux,' servico ',Resposta)).

resposta_tipo_servicos(Servicos,ql,Resposta):-
  percorre_servicos(Servicos,[],RespostaAux),
  length(Servicos,Tamanho),
  if_then_else(Tamanho<1,Resposta='O hotel nao tem servicos',(
  array_para_string(RespostaAux,' ',RespostaAux2),
  if_then_else(Tamanho > 1,atom_concat('Encontrei os seguintes servicos: ',RespostaAux2,Resposta),
    atom_concat('Encontrei o seguinte servico: ',RespostaAux2,Resposta))
  )).

percorre_servicos([],Resposta,Resposta).
percorre_servicos([S|Resto],RespostaAux,Resposta):-
  converte_servico_nome(S,Nome),
  percorre_servicos(Resto,[Nome|RespostaAux],Resposta).


resposta_tipo_hotel(Hoteis,qt,Resposta):-
  length(Hoteis,Tamanho),
  number_chars(Tamanho, Chars),
  atom_chars(T, Chars),
  atom_concat('Encontrei ',T,RAux),
  if_then_else(Tamanho > 1, atom_concat(RAux,' hoteis ',Resposta),atom_concat(RAux,' hotel ',Resposta)).

resposta_tipo_hotel(Hoteis,ql,Resposta):-
  percorre_hoteis(Hoteis,[],RespostaAux),
  length(Hoteis,Tamanho),
  array_para_string(RespostaAux,' ',RespostaAux2),
  if_then_else(Tamanho > 1,atom_concat('Encontrei os seguintes hoteis: ',RespostaAux2,Resposta),
    atom_concat('Encontrei o seguinte hotel: ',RespostaAux2,Resposta)).

array_para_string([H],Aux,Resposta):-
  atom_concat(H,Aux,Resposta).

array_para_string([H|Resto],Aux,Resposta):-
  atom_concat(Aux,' , ',Aux2),
  atom_concat(Aux2,H,Final),
  array_para_string(Resto,Final,Resposta).



percorre_hoteis([],Resposta,Resposta).
percorre_hoteis([H|Resto],RespostaAux,Resposta):-
  converte_hotel_nome(H,Nome),
  percorre_hoteis(Resto,[Nome|RespostaAux],Resposta).

responde(Nome) :-
  hotel(Nome,Lugar,Rating,Estrelas,Atributos),
  once((if_then(nome_hotel(_),nome_hotel(Nome)),
  if_then(lugar(_),lugar(Lugar)),
  if_then(rating(_,_),(rating(Comparador,Valor),restringe_valor(Rating,Comparador,Valor))),
  if_then(estrelas(_,_),(estrelas(Comparador,Valor),restringe_valor(Estrelas,Comparador,Valor))),
  if_then(atributo(_),restringe_atributos(Atributos)))).  

restringe_atributos(Atributos) :-
  findall(A,atributo(A),L),
  verifica_atributos(L,Atributos).

verifica_atributos([],_).
verifica_atributos([Elem|R],B):-
  member(Elem,B),
  verifica_atributos(R,B).


restringe_valor(Variavel,maior,Valor) :-
  Variavel > Valor.

restringe_valor(Variavel,menor,Valor) :-
  Variavel < Valor.

restringe_valor(Variavel,igual,Variavel).

verifica_output(Array) :-
  findall(_,(member(lugar-_,Array)),Lugares),
  findall(_,(member(estrelas-_-_,Array)),Estrelas),
  findall(_,(member(rating-_-_,Array)),Rating),
  length(Lugares,NLugares),
  length(Estrelas,NEstrelas),
  length(Rating,NRating),
  NLugares =< 1,
  NEstrelas =< 1,
  NRating =< 1.

insere_restricoes([]).
insere_restricoes([lugar-Lugar|R]) :-
  assert(lugar(Lugar)),
  insere_restricoes(R).

insere_restricoes([atributo-Atributo|R]) :-
  assert(atributo(Atributo)),
  insere_restricoes(R).

insere_restricoes([hotel-Hotel|R]) :-
  assert(nome_hotel(Hotel)),
  insere_restricoes(R).

insere_restricoes([estrelas-Comparador-Estrelas|R]) :-
  assert(estrelas(Comparador,Estrelas)),
  insere_restricoes(R).

insere_restricoes([rating-Comparador-Rating|R]) :-
  assert(rating(Comparador,Rating)),
  insere_restricoes(R).


frase_declarativa(S,OutputSV) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV).
frase_declarativa(S,OutputUOMC) --> sn(N,S,[],OutputSN), sv(N,S,OutputSN,OutputSV), um_ou_mais_conjuncoes(N,S,OutputSV,OutputUOMC).

% sintagma nominal
 %sem "com"  
sn(N,S,Input,Output) --> determinante(N-G,_),sujeito(N-G,S,Input,Output).

sujeito(N-G,S,_,_) --> nome(N-G,S,_).
 %com "com"  
sujeito(N-G,S,Input,Output) --> nome(N-G,S,_),s_n_preposicional(N-G,Input,Output,d).

s_n_preposicional(X-Y,Input,Output,Tipo) --> (preposicao(X-Y,Prep), nome(X-Y,Atr,Prep),{nome_atributo(Atr),once(append(Input,[atributo-Atr],Output))}) ;
  (preposicao(X-Y,Prep),numero(Z-P,N),nome(Z-P,estrela,Prep),{once(append(Input,[estrelas-igual-N],Output)),!}) ; 
  (preposicao(Z-P,Prep), comparacao(Z-P,Prep,Input,Output));
  (preposicao(Z-P,Prep), adv_quantidade(Z-P,Comparador),numero(Z-P,N),nome(Z-P,estrela,Prep),{once(append(Input,[estrelas-Comparador-N],Output)),!});
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
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_atributo(Verbo)},nome(_-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
sv(N,S,Input,Output) --> verbo(N,Verbo,S,d), {verbo_atributo(Verbo)},nome(_-_,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).

um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,Output).
um_ou_mais_conjuncoes(N,S,Input,Output) --> conjuncao(N-S), sv(N,S,Input,OutputSV),um_ou_mais_conjuncoes(N,S,OutputSV,Output).

um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],Output))}.
um_ou_mais_atributos(_-_,Input,Output) --> conjuncao(X-Y),nome(X-Y,Atr,_),{nome_atributo(Atr)},{once(append(Input,[atributo-Atr],OutputAtr))},um_ou_mais_atributos(_-_,OutputAtr,Output).



frase_interrogativa(Q,S,Output) --> si(_,Q,S,Output), {perguntavel(S)}.
frase_interrogativa(Q,S,Output) --> si(_,Q,S,OutputSI), {perguntavel(S)}, svi(_,S,OutputSI,Output).
frase_interrogativa(Q,S,Output) --> si(_,Q,S,OutputSI), {perguntavel(S)}, svi(_,S,OutputSI,OutputSVI), um_ou_mais_conjuncoes_i(_,S,OutputSVI,Output).

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
svi(N,S,Input,Output) --> verbo(N,Verbo,S,i), {verbo_REC(Verbo)},adv_quantidade(Z-P,Comparador),numero(Z-P,Valor),nome(Z-P,estrela,_),{once(append(Input,[estrelas-Comparador-Valor],Output))}.
svi(N,S,A,A) --> verbo(N,existir,S,i).
svi(N,S,Input,Output) --> verbo(N,existir,S,i),preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],Output))}.
svi(N,S,Input,Output) --> verbo(N,existir,S,i),preposicao(N1-G1,Prep),
  {preposicao_lugar(Prep)},nome(N1-G1,Lugar,Prep),{nome_lugar(Lugar)},{once(append(Input,[lugar-Lugar],OutputLugar))},um_ou_mais_s_n_preposicional(_-_,OutputLugar,Output).
svi(N,S,Input,Output) --> verbo(N,existir,S,i),um_ou_mais_s_n_preposicional(_-_,Input,Output).


um_ou_mais_s_n_preposicional(_-_,Input,Output) --> s_n_preposicional(_-_,Input,Output,i).
um_ou_mais_s_n_preposicional(_-_,Input,Output) --> s_n_preposicional(_-_,Input,Output1,i),um_ou_mais_s_n_preposicional(_-_,Output1,Output).

um_ou_mais_conjuncoes_i(N,S,Input,Output) --> conjuncao(N-S), svi(N,S,Input,Output).
um_ou_mais_conjuncoes_i(N,S,Input,Output) --> conjuncao(N-S), svi(N,S,Input,OutputSV),um_ou_mais_conjuncoes_i(N,S,OutputSV,Output).

frase_conjuntiva(Output) --> conjuncao(_-_),um_ou_mais_s_n_preposicional(_-_,[],Output).
frase_conjuntiva(Output) --> conjuncao(_-_),determinante(N-Y,_),nome(N-Y,Hotel,_),{hotel(Hotel),once(append([],[hotel-Hotel],Output))}.
frase_conjuntiva([]) --> conjuncao(_-_),pronome_i(N-G,Pronome), {pronome_i2tipo(Pronome,Q)},nome(N-G,Perguntavel,_),{perguntavel(Perguntavel),retractall(tipo_questao(_)),assert(tipo_questao(Q)),retractall(sujeito_questao(_)),assert(sujeito_questao(Perguntavel))}.
frase_conjuntiva([]) --> conjuncao(_-_),pronome_i(N-G,Pronome), {pronome_i2tipo(Pronome,Q)},nome(N-G,Perguntavel,_),verbo(_,Verbo,Perguntavel,i),{verbo_atributo(Verbo),perguntavel(Perguntavel),retractall(tipo_questao(_)),assert(tipo_questao(Q)),retractall(sujeito_questao(_)),assert(sujeito_questao(Perguntavel))}.
% nothing --> [].

remove_modificados:-
  retractall(lugar(_)),retractall(rating(_,_)),retractall(estrelas(_,_)),
  retractall(atributo(_)),retractall(nome_hotel(_)),retractall(tipo_questao(_)),retractall(sujeito_questao(_)).



verifica_sintaxe(X) :-frase(_,_,_,X,[]).

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
  verifica_sintaxe([quais,os,hoteis,de,faro,que,possuem,categoria,inferior,a,4,e,tem,quartos,com,vista,de,mar]),
  verifica_sintaxe([quantos,hoteis,tem,wifi,e,babysitting,e,piscina]),
  verifica_sintaxe([quais,os,hoteis,com,rating,inferior,a,8]),
  \+verifica_sintaxe([qual,os,hoteis,com,rating,inferior,a,8]),
  verifica_sintaxe([quantos,sao,os,hoteis,do,porto]),
  verifica_sintaxe([que,rating,tem,o,eurostars,oasis,plaza]).


t_nova_gramat_d :-
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

testes_conjuntivas :-
  verifica_sintaxe([quantos,sao,os,hoteis,do,porto]),
  verifica_sintaxe([e,com,wifi]),
  verifica_sintaxe([e,em,coimbra]),
  verifica_sintaxe([e,em,coimbra,com,wifi]),
  verifica_sintaxe([e,com,mais,de,3,estrelas]),
  verifica_sintaxe([quantas,estrelas,tem,o,eurostars,oasis,plaza]),
  verifica_sintaxe([e,o,turim]),
  verifica_sintaxe([e,quanto,rating]),
  verifica_sintaxe([e,quantos,servicos,tem]),
  verifica_sintaxe([e,quais,servicos]).
  
if_then_else(Condition, Action1, _) :- Condition, !, Action1.  
if_then_else(_, _, Action2) :- Action2.

if_then(Condition, Action1) :- if_then_else(Condition,Action1,true).  

nothing(A,[]):-A=[].