
clear all;
close all;
clc;

% Parametre de l'équation de récurrence
Ts = 1/10;
a  = 1/10; 
b  = 1;
w0 = 0.6;

% Question 1
N = 1000;   
Ta = N*Ts;


% Calcul des valeurs du signal analogique
t = 0:Ts/10:Ta;
yt = b*exp(-a*t).*sin(w0*(t+Ts))./sin(w0*Ts);
% Calcul des N échantillons 
tk = 0:Ts:(N-1)*Ts;
yk(1) = b;
yk(2) = 2*b*exp(-a*Ts)*cos(w0*Ts);
for k = 3:N;
  yk(k) = 2*exp(-a*Ts)*cos(w0*Ts)*yk(k-1) - exp(-2*a*Ts)*yk(k-2);
end

% Tracé du signal analogique et du signal échantillonné.
figure,
plot(t, yt, '-b');
hold on
stem(tk, yk, 'or');
hold on


% Question 3
A = [1,-2*exp(-a*Ts)*cos(w0*Ts),exp(-2*a*Ts)];    % -> à changer
B = b;    % -> à changer

% Tracé de la réponse fréquentielle de F
[H, nu] = freqz(B, A, 1000, 1/Ts);
figure, plot(nu, abs(H), '-r');
hold on

% Tracé de la TFD de yk (d'après le corrigé de l'exo1 du TD5)
Yn = fft(yk);
stem((0:(N/2-1))/N/Ts, abs(Yn(1:N/2)) );


% Question 5
na = 23     % -> à changer
[Ayw] = aryule(yk, na)
[H, nu] = freqz(B, Ayw, 1000, 1/Ts);
plot(nu, abs(H),'b--');



% Question  6
load yk2data.mat
N = length(yk);

% Réponse impulsionnelle
figure
stem(tk, yk, 'r'); 

% Réponse fréquentielle
Yn = fft(yk);
figure 
stem( (0:(N/2-1))/N/Ts, abs(Yn(1:N/2)) );
hold on


% Identification de F
na = 3% -> à changer
[A2yw] = aryule(yk, na)
[H, nu] = freqz(B, A2yw, 1000, 1/Ts);
plot(nu, abs(H));

