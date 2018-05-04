% base de dados

%hotel(Nome,Local,Rating,Estrela,Servicos)
hotel("Hotel Borges Chiado","Lisboa",6.8,3,["wifi"]).
hotel("Turim Terreiro Do Paco","Lisboa",8.7,1,[]).
hotel("TRYP Colina do Castelo","Castelo Branco",8.4,4,["restaurante"]).
hotel("Pedras do Mar Resort and Spa","Ponta Delgada",8.6,5,["piscina"]).
hotel("Santa Cruz","Coimbra",7.0,1,["piscina"]).
hotel("Hotel Do Mar","Sesimbra",7.8,4,["wifi"]).
hotel("Yellow Praia Monte Gordo","Monte Gordo",4.7,4,["piscina","pisos para fumadores"]).
hotel("TRYP Lisboa Caparica Mar","Costa da Caparica",7.2,4,["wifi"]).
hotel("Alfamar Beach and Sport Resort","Albufeira",7.2,4,["wifi"]).
hotel("Melia Braga Hotel","Braga",3.4,4,[]).
hotel("The Lince Azores Great Hotel","Ponta Delgada",7.9,4,["piscina"]).
hotel("Crowne Plaza Vilamoura","Vilamoura",8.5,5,["wifi","piscina"]).
hotel("Marques de Pombal","Lisboa",4.5,4,["wifi"]).
hotel("Eurostars Porto Douro","Porto",8.7,4,["baby-sitting","restaurante","estacionamento"]).
hotel("Eurostars Oasis Plaza","Figueira da Foz",8.8,4,["wifi","piscina","pisos para fumadores","restaurante","baby-sitting","estacionamento","vista de mar"]).

frase --> frase_declarativa(_-_).
frase --> frase_interrogativa(_-_).
frase --> frase_conjuntiva(_-_).
frase_interrogativa(X-Y) --> forma_frase_interrogativa(X-Y).
frase_interrogativa(X-Y) --> forma_frase_interrogativa(X-Y), uma_ou_mais_conjucoes(_-_).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), sintagma_verbal_interrogativo(X-Y), sintagma_nominal_interrogativo(_-_).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), (nome(X-Y);(nome(X-Y),comparacao(X-Y))), sintagma_verbal_interrogativo(_-_).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), quantificador(X-Y), nome(X-Y), adjetivo(X-Y), pronome(X-Y), sintagma_verbal(X-Y).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), quantificador(X-Y),nome(X-Y), pronome(X-Y), sintagma_verbal(X-Y).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), quantificador(X-Y), nome(X-Y), preposicao(Z-P), nome(Z-P), pronome(X-Y), sintagma_verbal(X-Y).
forma_frase_interrogativa(X-Y) --> pronome(X-Y), quantificador(X-Y), nome(X-Y), preposicao(Z-P), nome(Z-P), comparacao(_-_).
frase_declarativa(X-Y) --> sintagma_nominal(X-Y), sintagma_verbal(X-Y).
frase_declarativa(X-Y) --> sintagma_nominal(X-Y), sintagma_verbal(X-Y), uma_ou_mais_conjucoes(_-_).
frase_conjuntiva(X-Y) --> conjuncao(X-Y), sintagma_nominal_preposicional(X-Y).
sintagma_nominal(s-m) --> ["o"],["hotel"],adjetivo(s-m),nome(s-m).
sintagma_nominal(X-Y) --> (quantificador(X-Y),nome(X-Y), adjetivo(X-Y)).
sintagma_nominal(X-Y) --> (quantificador(X-Y),numero(Z-P),nome(Z-P));(quantificador(X-Y),numero(_-_));(quantificador(X-Y),nome(X-Y)).
sintagma_nominal(X-Y) --> sintagma_nominal_preposicional(X-Y).
sintagma_nominal(X-Y) --> nome(X-Y);(nome(X-Y),comparacao(X-Y));(numero(X-Y),nome(X-Y)).
sintagma_nominal(X-Y) --> nome_com_preposicao(X-Y).
nome_com_preposicao(X-Y) --> nome(X-Y), preposicao(Z-P), nome(Z-P).
nome_com_preposicao(X-Y) --> nome(X-Y), preposicao(Z-P), nome_com_preposicao(Z-P).
sintagma_nominal_preposicional(X-Y) --> (preposicao(X-Y), nome(X-Y)) ; (preposicao(X-Y),numero(Z-P),nome(Z-P)) ; (preposicao(Z-P), nome(Z-P), comparacao(Z-P)).
sintagma_nominal_interrogativo(X-Y) --> sintagma_nominal_preposicional(X-Y).
sintagma_nominal_interrogativo(X-Y) --> sintagma_nominal_preposicional(X-Y), sintagma_nominal_interrogativo(_-_).
comparacao(X-Y) --> comparador(X-Y),sintagma_nominal(X-Y).
sintagma_verbal(X-Y) --> verbo(X-Y).
sintagma_verbal(X-Y) --> verbo(X-Y), sintagma_nominal(_-_).
sintagma_verbal(X-Y) --> verbo(X-Y), nome(_-_), uma_ou_mais_conjucoes(_-_).
sintagma_verbal_interrogativo(X-Y) --> verbo(X-Y), sintagma_nominal(X-Y).
uma_ou_mais_conjucoes(X-Y) --> conjuncao(X-Y), sintagma_nominal(X-Y).
uma_ou_mais_conjucoes(X-Y) --> conjuncao(X-Y), sintagma_nominal(X-Y), uma_ou_mais_conjucoes(_-_).
uma_ou_mais_conjucoes(X-Y) --> conjuncao(X-Y), sintagma_verbal(X-Y).
uma_ou_mais_conjucoes(X-Y) --> conjuncao(X-Y), sintagma_verbal(X-Y), uma_ou_mais_conjucoes(X-Y).

verifica_sintaxe(X) :- split_string(X," "," ",L), frase(L,[]).

testes_interrogativas :-
verifica_sintaxe("quais sao os hoteis de categoria superior a 3 estrelas em lisboa"),
\+verifica_sintaxe("quais sao as hoteis de categoria superior a 3 estrelas em lisboa"),
verifica_sintaxe("e em coimbra"),
verifica_sintaxe("que servicos disponibiliza o hotel eurostars porto douro"),
\+verifica_sintaxe("que servicos disponibilizam o hotel eurostars porto douro"),
verifica_sintaxe("quais servicos disponibiliza o hotel eurostars porto douro"),
verifica_sintaxe("quais os hoteis parisienses que possuem servico de babysitting"),
verifica_sintaxe("quais os hoteis que possuem servico de babysitting"),
\+verifica_sintaxe("quais os parisienses que possuem servico de babysitting"),
verifica_sintaxe("quais os hoteis de faro que possuem categoria inferior a 4 e quartos com vista de mar"),
verifica_sintaxe("quantos hoteis tem wifi e babysitting e piscina"),
\+verifica_sintaxe("quanta hoteis tem wifi e babysitting e piscina"),
verifica_sintaxe("e com wifi"),
verifica_sintaxe("quais os hoteis com rating inferior a 8"),
\+verifica_sintaxe("qual os hoteis com rating inferior a 8"),
verifica_sintaxe("quantos sao os hoteis do porto").

testes_declarativas :-
verifica_sintaxe("o hotel eurostars porto douro fica em faro e possui 4 estrelas"),
\+verifica_sintaxe("a hotel eurostars porto douro fica em faro e possui 4 estrelas"),
\+verifica_sintaxe("o hotel eurostars porto douro fica em faro e possui 1 estrelas"),
verifica_sintaxe("o hotel the lince azores great hotel e em ponta delgada"),
verifica_sintaxe("o yellow praia monte gordo tem wifi e fica em monte gordo"),
verifica_sintaxe("o hotel portugues eurostars oasis plaza tem piscina e quartos com wifi").

nome(s-m) --> ["hotel"].
nome(p-m) --> ["hoteis"].
nome(s-m) --> ["porto"].
nome(s-f) --> ["lisboa"].
nome(s-f) --> ["coimbra"].
nome(s-m) --> ["faro"].
nome(s-m) --> ["castelo","branco"].
nome(s-f) --> ["ponta","delgada"].
nome(s-f) --> ["sesimbra"].
nome(s-m) --> ["monte", "gordo"].
nome(s-f) --> ["costa","da","caparica"].
nome(s-f) --> ["albufeira"].
nome(s-f) --> ["braga"].
nome(s-f) --> ["vilamoura"].
nome(s-f) --> ["figueira","da","foz"].
nome(s-f) --> ["categoria"].
nome(s-f) --> ["estrela"].
nome(p-f) --> ["estrelas"].
nome(s-m) --> ["servico"].
nome(p-m) --> ["servicos"].
nome(s-m) --> ["quarto"].
nome(p-m) --> ["quartos"].
nome(s-f) --> ["vista"].
nome(s-m) --> ["mar"].
nome(s-_) --> ["wifi"].
nome(s-f) --> ["piscina"].
nome(p-f) --> ["piscinas"].
nome(s-m) --> ["baby-sitting"].
nome(s-m) --> ["babysitting"].
nome(s-m) --> ["restaurante"].
nome(s-m) --> ["piso"].
nome(p-m) --> ["pisos"].
nome(p-m) --> ["fumadores"].
nome(s-m) --> ["estacionamento"].
nome(s-f) --> ["noite"].
nome(p-f) --> ["noites"].
nome(s-m) --> ["rating"].
nome(s-m) --> ["hotel","borges","chiado"].
nome(s-m) --> ["turim","terreiro","do","paco"].
nome(s-m) --> ["tryp","colina","do","castelo"].
nome(s-m) --> ["pedras","do","mar","resort","and","spa"].
nome(s-m) --> ["santa","cruz"].
nome(s-m) --> ["hotel","do","mar"].
nome(s-m) --> ["yellow","praia","monte","gordo"].
nome(s-m) --> ["tryp","lisboa","caparica","mar"].
nome(s-m) --> ["alfamar","beach","and","sport","resort"].
nome(s-m) --> ["melia","braga","hotel"].
nome(s-m) --> ["the","lince","azores","great","hotel"].
nome(s-m) --> ["crowne","plaza","vilamoura"].
nome(s-m) --> ["marques","de","pombal"].
nome(s-m) --> ["eurostars","porto","douro"].
nome(s-m) --> ["eurostars","oasis","plaza"].
nome(s-m) --> ["hotel","turim","terreiro","do","paco"].
nome(s-m) --> ["hotel","tryp","colina","do","castelo"].
nome(s-m) --> ["hotel","pedras","do","mar","resort","and","spa"].
nome(s-m) --> ["hotel","santa","cruz"].
nome(s-m) --> ["hotel","hotel","do","mar"].
nome(s-m) --> ["hotel","yellow","praia","monte","gordo"].
nome(s-m) --> ["hotel","tryp","lisboa","caparica","mar"].
nome(s-m) --> ["hotel","alfamar","beach","and","sport","resort"].
nome(s-m) --> ["hotel","melia","braga","hotel"].
nome(s-m) --> ["hotel","the","lince","azores","great","hotel"].
nome(s-m) --> ["hotel","crowne","plaza","vilamoura"].
nome(s-m) --> ["hotel","marques","de","pombal"].
nome(s-m) --> ["hotel","eurostars","porto","douro"].
nome(s-m) --> ["hotel","eurostars","oasis","plaza"].
nome(s-f) --> ["manel"].
nome(s-f) --> ["estadia"].

digito(s-_) --> ["1"].
digito(p-_) --> ["2"].
digito(p-_) --> ["3"].
digito(p-_) --> ["4"].
digito(p-_) --> ["5"].
digito(p-_) --> ["6"].
digito(p-_) --> ["7"].
digito(p-_) --> ["8"].
digito(p-_) --> ["9"].
digito(p-_) --> ["0"].
numero_extenso(s-m) --> ["um"].
numero_extenso(s-f) --> ["uma"].
numero_extenso(p-m) --> ["dois"].
numero_extenso(p-f) --> ["duas"].
numero_extenso(p-_) --> ["tres"].
numero_extenso(p-_) --> ["quatro"].
numero_extenso(p-_) --> ["cinco"].
numero(X-Y) --> numero_extenso(X-Y) ; digito(X-Y).

comparador(s-_) --> ["superior"].
comparador(p-_) --> ["superiores"].
comparador(s-_) --> ["inferior"].
comparador(p-_) --> ["inferiores"].
comparador(s-_) --> ["igual"].
comparador(p-_) --> ["iguais"].

adjetivo(s-_) --> ["parisiense"].
adjetivo(p-_) --> ["parisienses"].
adjetivo(s-_) --> ["portugues"].
adjetivo(p-_) --> ["portugueses"].

pronome(p-m) --> ["quantos"].
pronome(s-m) --> ["quanto"].
pronome(p-f) --> ["quantas"].
pronome(s-f) --> ["quanta"].
pronome(p-_) --> ["quais"].
pronome(s-_) --> ["qual"].
pronome(_-_) --> ["que"].
verbo(s-_) --> ["e"].
verbo(p-_) --> ["sao"].
verbo(s-_) --> ["disponibiliza"].
verbo(p-_) --> ["disponibilizam"].
verbo(s-_) --> ["possui"].
verbo(p-_) --> ["possuem"].
verbo(s-_) --> ["fica"].
verbo(p-_) --> ["ficam"].
verbo(s-_) --> ["tem"].
verbo(p-_) --> ["tem"].
quantificador(s-m) --> ["o"].
quantificador(p-m) --> ["os"].
quantificador(p-f) --> ["as"].
quantificador(s-f) --> ["a"].
quantificador(s-m) --> ["um"].
quantificador(p-m) --> ["uns"].
quantificador(s-f) --> ["uma"].
quantificador(p-f) --> ["umas"].
preposicao(s-m) --> ["Do"].
preposicao(s-m) --> ["do"].
preposicao(p-m) --> ["dos"].
preposicao(p-f) --> ["das"].
preposicao(s-f) --> ["da"].
preposicao(s-m) --> ["no"].
preposicao(p-m) --> ["nos"].
preposicao(s-f) --> ["na"].
preposicao(p-f) --> ["nas"].
preposicao(_-_) --> ["de"].
preposicao(_-_) --> ["em"].
preposicao(_-_) --> ["com"].
preposicao(_-_) --> ["em"].
preposicao(_-_) --> ["para"].
conjuncao(_-_) --> ["e"].
pontuacao --> ["?"].

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
ser("restaurante","servico").
ser("vista de mar","servico").
ser("wifi","servico").
ser("piscina","servico").
ser("baby-sitting","servico").
ser("piso para fumadores","servico").
ser("pisos para fumadores","servico").
ser("estacionamento","servico").
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
