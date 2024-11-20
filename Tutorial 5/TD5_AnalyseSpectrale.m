
clear all;
close all;
clc;


% Paramètres
%------------------------------------------------------------%

% Parametres du signal continu
a  = 0.1;
b  = 1;
nu0 = 2.1;

% Parametres de la mesure
Ts = 0.05;  % Période d'échantillonnage (sec)
N  = 1000 ;   % Nombre d'échantillons mesurés
Ta = N*Ts;  % Temps d'acquisition (sec)
nus = 1/Ts; % Fréquence d'échantillonnage (Hz)


% Analyse temporelle
%------------------------------------------------------------%

% Calcul du signal analogique x
t = 0:Ts/100:Ta;
x = b*exp(-a*t).*sin(2*pi*nu0*t);

% Calcul des N échantillons du signal mesuré xk
tk = 0:Ts:(N-1)*Ts;
xk = b*exp(-a*tk).*sin(2*pi*nu0*tk);

figure,
plot(t, x); hold on;
plot(tk, xk, '.','MarkerSize',10); hold off;
grid on;
xlabel('temps (sec)');
ylabel('amplitude');
title('signal continu x et sa mesure discrete x_k');

%return

% Analyse fréquentielle
%------------------------------------------------------------%

% Calcul de la TFD Xn de xk
Xn = fft(xk);

figure 
plot(abs(Xn), '.','MarkerSize',10,'Color','#D95319');
grid on;
xlabel('indice n');
ylabel('|X_n|');
title('TFD des échantillons x_k');

%return

% Calcul du spectre X de x
nu = -nus/2 : 1/Ta/100 : nus/2;
X = b/2*(1./(a+1i*2*pi*(nu-nu0))+1./(a+1i*2*pi*(nu+nu0)));

% Calcul du spectre X de x à partir de Xn
Xest = Ts*[Xn(N/2+1:N),Xn(1:N/2)];
nun = 1/(N*Ts).*(-N/2:N/2-1);

figure
plot(nu, abs(X)); hold on;
plot(nun, abs(Xest), '.','MarkerSize',10); hold off
grid on;
xlabel('fréquence (Hz)');
ylabel('|X(\nu)|');
title('Spectre X du signal continu et son estimation discrete');


