
%
% Ecole Centrale de Lyon
% STItc2 - Traitement du Signal
% 
% TP Parole : Compression/decompression de la parole par filtre generateur
% sonsnonvoises.m : analyse, modelisation et synthese de sons non voises
%


clear all;
close all;
clc;


% parametres %
%------------%

nus = 22050;    % frequence d'echantillonnage (Hz)
Ts = 1/nus;     % periode d'echantillonnage (sec)

ecoute = 1;     % option pour ecouter les sons (=0 pour pas d'ecoute)


% 1) analyse du signal %
%----------------------%

load ch_corentin.mat   % mettre le nom de votre fichier

y = simout.signals.values(:);   % recuperation des echantillons du signal
N = 2*floor(length(y)/2);       % N = nombre d'echantillons (multiple de 2)
t = [0:N-1]*Ts;                 % vecteur des temps
y = y(1:N);                     % troncature du signal à N echantillons
y = y/max(abs(y));              % normalisation en amplitude du signal

% question 24
% analyse temporelle du signal

figure Name Signal_d_entrée
plot(t,y);
axis tight;
ylim([-1.2 1.2]);
xlabel('temps (sec)');
ylabel('amplitude');
title('signal y')

if(ecoute)
sound(y,nus);
pause(N*Ts);
end

% question 25
% analyse spectrale du signal
Y=fftshift(Ts*fft(y));
F=linspace(-nus/2,nus/2,length(Y));

figure Name Transformée_de_Fourier
plot(F,Y)


% question 27
% autocorrelation et densite spectrale de puissance du signal y
figure Name Autocorrélation_de_y
Ry=xcorr(y,'biased');
t_Ry=[(-N+1):(N-1)]*Ts
plot(t_Ry,Ry)

%DSP
figure Name DSP_y
Sy=fftshift(fft(Ry))
pas=nus/(2*N-1)
F_Sy=[-nus/2:pas:nus/2-pas];
plot(F_Sy,abs(Sy))

% 2) Compression : modelisation par filtre générateur %
%-----------------------------------------------------%


% question 29
% identification, stabilité et reponse frequentielle du filtre générateur
figure Name Module_H
na=20;
[a,sigma2]=aryule(y,na);
[H,nu]=freqz([1],a,2*pi*F_Sy/nus);
plot(nu,abs(H))


% question 30
% vérification de la relation entre DSP du signal y et réponse
% fréquentielle du filtre générateur
figure Name Test_formule
plot(F_Sy,abs(Sy));
hold on
plot(F_Sy,6*abs(H).^2*sigma2);


% 3) Decompression : synthese artificielle %
%------------------------------------------%
n=1000;
x=sqrt(sigma2)*randn(n,1);
var(x)
figure Name ysint
sys=tf([1],a)
ysint=conv(H,x)
plot(linspace(0,3,length(ysint)),ysint)

% question 31
% synthese du signal non voisé




