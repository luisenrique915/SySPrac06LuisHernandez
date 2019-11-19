function sistemas(a,b,ciy,cix,xi,t0)
% a coeficientes de las derivadas de la salida menor a mayor [a_0, ..., a_n]
% b coeficientes de las derivadas de la entrada menor a mayor [b_0, ..., b_m]
% ciy condiciones iniciales de la salida de  menor a mayor [y(0), y(0)^(n-1)]
% cix condiciones iniciales de la entrada de menor a meyor [x(0), x^(m-1)(0)]
% xi función de entrada en terminos de la variable simbolica t previamente
% declarada en el command window
% t0 tiempo final para graficar la solucion, la derivada, y la segunda 
% derivada 
% ejemplo: resolver y^(3)+y^(2)+2y^(1)+2y=3x^(2)-x^(1)+2x con y^(2)(0)=1 y^(1)=3
% y(0)=2, x(0)=0 x^(1)=1, x(t)=exp(-t)cos(t)u(t), para 10 segundos, se resuleve como
% syms t
% laplace2016a([2 2 1 1],[2 -1 3],[2 3 1],[0 1],exp(-t)*cos(t)*heaviside(t),10)
close all
tam=size(a);
tami=size(b);
syms y(t) Y(s) x(t) X(s) Yy fp;
syms yimp ys0 yi0 yun;
syms edd edi 

%Obtenemos la respuesta al impulso 

edd=0;
edi=0;

ciy0 = zeros(1, size(ciy, 2) ) ;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy0(k));
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
   for k=1:i-1
       edi=edi-b(i)*(s^(i-1-k)*cix(k));
   end
end


edi=subs(edi,X(s), 1);

edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;
edd=solve(eq1, Yy);

%Función de transferencia del sistema
G(s) = edd;
mensaje('Función de transferencia del sistema')
pretty( G(s) )

%Respuesta al impulso
yimp=ilaplace(edd);
mensaje('Respuesta al impulso del sistema')
pretty( yimp )


% Obtenemos la respuesta a entrada 0

edd=0;
edi=0;

cix0 = zeros(1, size(cix, 2) ) ;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy(k));
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
   for k=1:i-1
       edi=edi-b(i)*(s^(i-1-k)*cix0(k));
   end
end

edi=subs(edi,X(s), 0);
edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;
edd=solve(eq1, Yy);

% Respuesta a entrada cero
yi0=ilaplace(edd);

mensaje('Respuesta a entrada cero del sistema')
pretty( yi0 )

% Obtenemos la respuesta a estado 0

edd=0;
edi=0;

ciy0 = zeros(1, size(ciy, 2) ) ;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy0(k));
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
   for k=1:i-1
       edi=edi-b(i)*(s^(i-1-k)*cix(k));
   end
end


edi=subs(edi,X(s), laplace(xi));

edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;
edd=solve(eq1, Yy);

%Respuesta a estado 0
ys0=ilaplace(edd);
mensaje('Respuesta a estado cero del sistema')
pretty( ys0 )

%Respuesta total
y(t) = yi0 + ys0;
mensaje('Respuesta total del sistema')
pretty( y(t) )

%Obtenemos la respuesta al escalón con condiciones iniciales 0

edd=0;
edi=0;

ciy0 = zeros(1, size(ciy, 2) ) ;
cix0 = zeros(1, size(cix, 2) ) ;

for i=1:tam(2)
   edd=edd+a(i)*s^(i-1)*Y(s);
   for k=1:i-1
       edd=edd-a(i)*(s^(i-1-k)*ciy0(k));
   end
end

for i=1:tami(2)
   edi=edi+b(i)*s^(i-1)*X(s);
   for k=1:i-1
       edi=edi-b(i)*(s^(i-1-k)*cix0(k));
   end
end


edi=subs(edi,X(s), laplace(heaviside(t)));

edd=collect(edd,Y(s));
edd=subs(edd,Y(s),Yy);
eq1=edd==edi;
edd=solve(eq1, Yy);

%Respuesta a estado 0
yun=ilaplace(edd);
mensaje('Respuesta al escalón unitario del sistema')
pretty( yun )


%Imprimos las graficas
hFig = figure;
set(hFig, 'Position', [0 0 900 900])
axes1 = axes('Parent',hFig,'FontWeight','bold','FontSize',16);
tiempo=0:0.01:t0;

%Entrada
subplot(3,2,1)
fplot(xi,[0, t0],'b','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Entrada del sistema','FontWeight','bold','FontSize',16)
grid on

%Respuesta al impulso
subplot(3,2,2)
fplot(yimp,[0,t0],'r','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Respuesta al impulso','FontWeight','bold','FontSize',16)
grid on

%Respuesta entrada cero
subplot(3,2,3)
fplot(yi0,[0,t0],'r','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Respuesta a la entrada cero','FontWeight','bold','FontSize',16)
grid on

%Respuesta estado cero
subplot(3,2,4)
fplot(ys0,[0,t0],'r','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Respuesta al estado cero','FontWeight','bold','FontSize',16)
grid on

%Salida
subplot(3,2,5)
fplot(y(t),[0,t0],'r','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Respuesta total','FontWeight','bold','FontSize',16)
grid on

%Respuesta al escalón
subplot(3,2,6)
fplot(yun,[0,t0],'r','LineWidth',2)
xlabel('tiempo','FontWeight','bold','FontSize',16)
title('Respuesta al escalón unitario','FontWeight','bold','FontSize',16)
grid on


end

function mensaje(texto)
disp( ' ')
disp(texto)
disp( ' ')
end