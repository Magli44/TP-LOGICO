%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%PrimeraParte

%1
saleCon(Persona1, Persona2):-
  pareja(Persona1, Persona2).
saleCon(Persona1, Persona2):-
  pareja(Persona2, Persona1).

%2
pareja(bernardo, bianca).
pareja(bernardo, charo).

%3
trabajaPara(Jefe, bernardo):-
  trabajaPara(marsellus, Jefe),
  Jefe \= jules.

trabajaPara(Jefe, george):-
  saleCon(bernardo, Jefe).

%4
esFiel(Persona):-
  saleCon(Persona, Pareja0),
  not((saleCon(Persona, Pareja1), Pareja0 \= Pareja1)).

%5
acataOrden(Empleado,Jefe):-
  trabajaPara(Jefe,Empleado).
acataOrden(Empleado,Jefaso):-
  trabajaPara(Jefe,Empleado),
  trabajaPara(Jefaso,Jefe).

%SegundaParte
%personaje(Nombre, Ocupacion).
personaje(pumkin, ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent, mafioso(maton)).
personaje(jules, mafioso(maton)).
personaje(marsellus, mafioso(capo)).
personaje(winston, mafioso(resuelveProblemas)).
personaje(mia, actriz([foxForceFive])).
personaje(butch, boxeador).
personaje(bernardo, mafioso(cerebro)).
personaje(bianca, actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie, vender([auto])).

%encargo(Solicitante, Encargado, Tarea).
encargo(marsellus, vincent, cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%1
esPeligroso(Persona):-
  personaje(Persona, mafioso(maton)).
esPeligroso(Persona):-
  personaje(Persona, ladron(_)).
esPeligroso(Persona):-
  jefePeligroso(Persona).

jefePeligroso(Persona):-
  trabajaPara(Jefe, Persona),
  esPeligroso(Jefe).


%2
sanCayetano(Persona):-
  sonAmigos(Persona, _),
  forall(sonAmigos(Persona, Amigo),encargo(Persona, Amigo, _)).

sonAmigos(Persona, Amigo):-
  trabajaPara(Amigo, Persona).
sonAmigos(Persona, Amigo):-
  trabajaPara(Persona, Amigo).
sonAmigos(Persona, Amigo):-
  amigo(Persona, Amigo).
sonAmigos(Persona, Amigo):-
  amigo(Amigo, Persona).


%3
nivelDeRespeto(vincent, 15).

nivelDeRespeto(Personaje, Nivel):-
  personaje(Personaje, actriz(_)),
  findall(Pelicula, personaje(Personaje, actriz(Pelicula)), Peliculas),
  length(Peliculas, CantidadDePeliculas),
  Nivel is CantidadDePeliculas / 10.

nivelDeRespeto(Personaje, 10):-
  personaje(Personaje, mafioso(resuelveProblemas)).

nivelDeRespeto(Personaje, 20):-
  personaje(Personaje, mafioso(capo)).

%4
respetabilidad(Respetables, NoRespetables):-
  findall(PersonajeR, esRespetable(PersonajeR), ListaRespetables),
  length(ListaRespetables,Respetables),
  findall(PersonajeN, noEsRespetable(PersonajeN), ListaNoRespetables),
  length(ListaNoRespetables,NoRespetables).

esRespetable(Personaje):-
  nivelDeRespeto(Personaje, Nivel),
  Nivel > 9.

noEsRespetable(Personaje):-
    nivelDeRespeto(Personaje, Nivel),
    Nivel =< 9.
noEsRespetable(Personaje):-
    personaje(Personaje,_),
    not(nivelDeRespeto(Personaje,_)).
%5
masAtareado(Personaje):-
  personaje(Personaje, _),
  forall(personaje(Otro,_),tieneMayorCantidadDeEncargos(Personaje, Otro)).

tieneMayorCantidadDeEncargos(Personaje, Otro):-
  cantidadEncargos(Personaje, CantidadDeEncargos),
  cantidadEncargos(Otro, OtraCantidadDeEncargos),
  CantidadDeEncargos >= OtraCantidadDeEncargos.

cantidadEncargos(Personaje,Encargos):-
  personaje(Personaje, _),
  findall(Tarea,encargo(_,Personaje,Tarea),Tareas),
  length(Tareas,Encargos).

  %Probando
