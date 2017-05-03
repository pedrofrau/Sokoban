/************************************************************************************************************************/
/* PEDRO FRAU - SEMINARIO DE COMPUTACION LOGICA - MASTER EN INTELIGENCIA ARTIFICIAL - UNIVERSIDAD POLITECNICA DE MADRID */
/************************************************************************************************************************/
                                                                                                                      
/***************************************************************************************************************************/
/* El problema: Sokoban.                                                                                                   */
/***************************************************************************************************************************/
/* Disponemos de un mapa como el que sigue que contiene un personaje (sokoban) representado por una S y dos cajas C que    */
/* deben ser llevadas a dos puntos concretos del mapa representadospor un punto (·).                                       */
/* Para ejecutar el programa usar (por ejemplo): solve_problem(P,S).                                                       */
/***************************************************************************************************************************/
/* #####                                                                                                                   */
/* #   #                                                                                                                   */
/* # CC#                                                                                                                   */
/* #S··#                                                                                                                   */
/* #####                                                                                                                   */
/***************************************************************************************************************************/
/* Las reglas del juego son las siguientes:                                                                                */
/* - Las cajas solo se pueden empujar, no se puede tirar de ellas.                                                         */
/* - Solo se puede empujar una caja a la vez.                                                                              */
/***************************************************************************************************************************/

                                                                                                                      
/***************************************************************************************************************************/
/* Representacion del estado                                                                                               */
/***************************************************************************************************************************/
/* p(posicion_sokoban, posicion_caja1, posicion_caja2)                                                                     */
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Representacion de los movimientos                                                                                       */
/***************************************************************************************************************************/
/* m(casillasMovimientoSokoban_x, ...Sokoban_y,casillasMovimientoCaja1_x, ...Caja1_y,casillasMovimientoCaja2_x, ...Caja2_y)*/
/* Para mas claridad en la ejecucion añadimos direccion textual: m(_,_,_,_,_,_, direccion)                                 */
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Representacion de posiciones                                                                                            */
/***************************************************************************************************************************/
/* loc(posicion_x, posicion_y)                                                                                             */
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Representacion de posiciones                                                                                            */
/***************************************************************************************************************************/
/* loc(posicion_x, posicion_y)                                                                                             */
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Predicado de movimiento                                                                                                 */
/***************************************************************************************************************************/
/* movimiento(estado, movimiento_del_ente)                                                                                 */
/***************************************************************************************************************************/



/***************************************************************************************************************************/
/* Actualizacion de estados                                                                                                */
/***************************************************************************************************************************/
/* actualizar(estado, movimiento, nuevo_estado)                                                                            */
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Definimos un estado inicial como viene definido en el mapa mas arriba, y un estado final en que las dos cajas estan     */
/* correctamente posicionadas.                                                                                             */
/***************************************************************************************************************************/
estado_inicial(problema_sokoban, p(loc(0,0), loc(1,1), loc(2,1))).
estado_final(problema_sokoban, p(_, loc(1,0), loc(2,0))).
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* Definimos los posibles movimientos de cada ente en funcion de la posicion del sokoban. Los movimientos vienen definidos */
/* por un estado y un numero de casillas que se mueve cada ente del mapa.                                                  */
/***************************************************************************************************************************/
movimiento(p(L, _,_), m(0,1,0,0,0,0, arriba_sokoban_1casilla)) :-
	L = loc(0,1); L = loc(0,0); L = loc(1,1); L = loc(2,1).
movimiento(p(L, _,_), m(0,1,0,1,0,0, arriba_sokoban_caja1)) :-
	L = loc(1,0).
movimiento(p(L, _,_), m(0,1,0,0,0,1, arriba_sokoban_caja2)) :-
	L = loc(2,0).
movimiento(p(L, _,_), m(0,2,0,0,0,0, arriba_sokoban_2casillas)) :-
	L = loc(0,0).
movimiento(p(L, _,_), m(1,0,0,0,0,0, derecha_sokoban_1casilla)) :-
	L = loc(0,2); L = loc(1,2); L = loc(0,0); L = loc(1,0).
movimiento(p(L, _,_), m(2,0,0,0,0,0, derecha_sokoban_2casillas)) :-
	L = loc(0,2); L = loc(0,0).
movimiento(p(L, _, _), m(0,-1, 0,-1,0,0, abajo_sokoban_caja1)) :-
	L = loc(1,2).
movimiento(p(L, _, _), m(0,-1, 0,0,0,-1, abajo_sokoban_caja2)) :-
	L = loc(2,2).
movimiento(p(L, _, _), m(0,-1, 0,0,0,0, abajo_sokoban_1casilla)) :-
	L = loc(0,1); L = loc(0,2).
movimiento(p(L, _, _), m(0,-2,0,0,0,0, abajo_sokoban_2casillas)) :-
	L = loc(0,2).
movimiento(p(L, _, _), m(-1,0,0,0,0,0, izquierda_sokoban_1casilla)) :-
	L = loc(2,2); L = loc(1,2); L = loc(2,0); L = loc(1,0).
movimiento(p(L, _, _), m(-2,0,0,0,0,0, izquierda_sokoban_2casillas)) :-
	L = loc(2,2); L = loc(2,0).
/*************************************************************************************************************************/	


/*************************************************************************************************************************/
/* Declaramos los pasos de actualizacion de estados cada indice se actualiza sumando el numero de casillas que se mueve  */
/* el ente en esa direccion                                                                                              */
/*************************************************************************************************************************/ 
actualizar(p(loc(XA,YA), loc(XB,YB), loc(XC,YC)), m(X,Y, X1,Y1,X2,Y2,_),p(loc(XD,YD),loc(XE,YE),loc(XF,YF))):-
	XD is XA + X,
	YD is YA + Y,
	XE is XB + X1,
	YE is YB + Y1,
	XF is XC + X2,
	YF is YC + Y2.
/**************************************************************************************************************************/


/**************************************************************************************************************************/
/* Se hace una comprobación de la legalidad de cada estado                                                                */	
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/* Las cajas pueden estar en el objetivo y el sokoban sobre la segunda caja                                               */
/**************************************************************************************************************************/	
legal(p(loc(2,1),loc(1,0),loc(2,0))):-
	!.
/**************************************************************************************************************************/
/* Las cajas pueden estar en el objetivo y el sokoban sobre la primera caja                                               */
/**************************************************************************************************************************/
legal(p(loc(1,1),loc(1,0),loc(2,0))):-
	!.
/**************************************************************************************************************************/
/* Las cajas pueden estar en su posicion inicial y el sokoban en su posicion inicial                                      */
/**************************************************************************************************************************/
legal(p(loc(0,0),loc(1,1),loc(2,1))):-
	!.
/**************************************************************************************************************************/
/* ...                                                                                                                    */
/**************************************************************************************************************************/
legal(p(loc(0,1),loc(1,1),loc(2,1))):-
	!.
legal(p(loc(0,2),loc(1,1),loc(2,1))):-
	!.
legal(p(loc(1,2),loc(1,1),loc(2,1))):-
	!.
legal(p(loc(2,2),loc(1,1),loc(2,1))):-
	!.
legal(p(loc(2,1),loc(1,1),loc(2,0))):-
	!.
legal(p(loc(2,2),loc(1,1),loc(2,0))):-
	!.
legal(p(loc(1,2),loc(1,1),loc(2,0))):-
	!.
legal(p(loc(1,1),loc(1,0),loc(2,1))):-
	!.
legal(p(loc(1,2),loc(1,0),loc(2,1))):-
	!.
legal(p(loc(2,2),loc(1,0),loc(2,1))):-
	!.
/***************************************************************************************************************************/


/***************************************************************************************************************************/
/* APLICAMOS EL FRAMEWORK DE RESOLUCION DE PROBLEMAS                                                                       */
/***************************************************************************************************************************/	
/************************************************************************************/
/* A reusable depth-first problem solving framework.                                */
/************************************************************************************/

/* The problem is solved is the current state is the final state.                   */
solve_dfs(Problem, State, History, []) :-
	estado_final(Problem, State).
/* To perform a state transition we follow the steps below:                         */
/* - We choose a move that can be applied from our current state.                   */
/* - We create the new state which results from performing the chosen move.         */
/* - We check whether the new state is legal (i.e. meets the imposed constraints.   */
/* - Next we check whether the newly produced state was previously visited. If so   */
/*   then we discard such a move, since we're most probably in a loop!              */
/* - If all the above conditions are fulfilled, then we consolidate the chosen move */
/*   and then we continue searching for the solution. Note that we have stored the  */
/*   newly created state for loop checking!                                         */
solve_dfs(Problem, State, History, [Move|Moves]) :-
	movimiento(State, Move),
	actualizar(State, Move, NewState),
	legal(NewState),
	\+ member(NewState, History),
	solve_dfs(Problem, NewState, [NewState|History], Moves).

/*************************************************************************************/
/* Solving the problem.                                                              */
/*************************************************************************************/
solve_problem(Problem, Solution) :-
	estado_inicial(Problem, Initial),
	solve_dfs(Problem, Initial, [Initial], Solution).
	
