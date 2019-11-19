%% Pr�ctica 6: Sistemas diferenciales
%% Integrantes
%
% Silverio Jim�nez Cesar Antonio
%
% Hernandez Lugardo Luis Enrique
%
%% Objetivos:
% * Conocer comandos para obtener las funciones de respuesta de un sistema
% * Graficar las expresiones de respuesta
% 
%%
%% Introducci�n
% En esta practica se mostrar� como un programa resuelve sistemas
% diferenciales de orden n mediante la transformada de Laplace y Fourier, el
% programa despliega la funci�n de trasnferencia, la respuesta al impulso,
% la respuesta a entrada cero, la respuesta a estado cero, la respuesta
% total con condiciones iniciales y las gr�ficas correspondientes

%% FUNCION 
% $$ y^2+y^1+y =x $$
%
% Condiciones Iniciales 
% 
% $$ \\ y^1(0)=-1 \\ $$
%
% $$   \\y(0)=1 \\  $$
%
% $$ \\ x(t)=exp(-t)u(t) $$
%
% 
%

%% PUNTO 1 
%
% Muestra la funci�n de transferencia del sistema
%
%
% $$ \frac{1}{S^2+S+1} $$
n=[1];
d=[1 1 1];
G=tf(n,d)
pole(G);
step(G);
%% PUNTO 2 
%
% Se muestra la respuesta al impulso del sistema
%
%
syms t
transFourierImpulse([1 1 1],[1],dirac(t),10)

%% PUNTO 3 
%
%
%  Se muestra la respuesta a entrada cero del sistema
%
%
syms t
transLaplaceCero([1 1 1],[1],[1 -1],[0],0*t,10)


%% PUNTO  4
%
%
%  Se muestra la respuesta a estado cero del sistema
%
%
syms t
transLaplaceCeroState([1 1 1],[1],[0 0],[0],exp(-t)*heaviside(t),10)

%% PUNTO  5
%
%
%  Se muestra la respuesta total del sistema
%
%
syms t
transLaplaceCeroState([1 1 1],[1],[1 -1],[0],exp(-t)*heaviside(t),10)

%% PUNTO 6
%
% Se muestra la respuesta total al escal�n unitario con condiciones iniciales
% cero
%
transLaplaceCeroState([1 1 1],[1],[0 0],[0],heaviside(t),10)

%% PUNTO 7
%
% Se muestra las respuestas simb�licas y gr�ficas en un subplot
%
sistemas( [1 1 1],[1],[1 -1],[0],exp(-t)*heaviside(t),10 )


