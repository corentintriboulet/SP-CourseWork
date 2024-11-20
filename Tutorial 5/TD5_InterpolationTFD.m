%----------------------------------------------------------------------%
%
% Ecole Centrale de Lyon
% STItc2 - Traitement du Signal
% Programme d'illustration pour l'interpolation par TFD
%
%----------------------------------------------------------------------%

clear all; close all; clc;

% Param�tres

Ts1 = 1/8;  % p�riode d'�chantillonnage de Nyquist (sec)
N = 64;     % nombre d'�chantillons stock�s
Ta = N*Ts1; % dur�e d'acquisition (sec)
M = 4;

% Signal continu x

a = 2;
nu0 = 0.5;
t = 0:10^(-3):Ta;
x = (t.^2).*exp(-a*t).*cos(2*pi*nu0*t);

% Signal �chantillonn� : x1k

t1k = [0:N-1]*Ts1;
x1k = t1k.^2.*exp(-a*t1k).*cos(2*pi*nu0*t1k);

% Interpolation par TFD : cr�ation de x2k
X1n=fft(x1k);
Ts2 = Ts1/M;
t2k = [0:M*N-1]*Ts2;
X2n = M*[X1n(1:N/2),zeros(1,(M-1)*N),X1n(N/2+1:N)];
x2k=ifft(X2n);
length(t2k)
length(x2k)

% Affichage du r�sultat

figure,
plot(t, x, 'b'); hold on;
plot(t1k, x1k, '*r'); hold on;
plot(t2k, x2k, 'ok'); hold on;
grid on;
legend('signal continu $x$','signal discret $x_1$','signal discret $x_2$','Interpreter','latex');
xlabel('temps t (sec)');
ylabel ('amplitude')



