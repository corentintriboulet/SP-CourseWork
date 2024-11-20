
clear all;
close all;
clc;

Ts = 1/2;

% question 1
% Représentation de réalisations temporelles du signal aléatoire bruit
N = 1000;
bk  = randn(N,1);    % vecteur de N échantillons "pseudo"aléatoires 
                     % suivant une loi gausienne, moyenne 0, variance 1
figure(1), plot( (0:(N-1))*Ts, bk, 'xb' );
ylim([-5 5]);

% question 2
% Représentation des échantillons de l'autocorrélation du bruit
Rbk = xcorr(bk, 'biased');
figure(2), plot( (-N+1):(N-1), Rbk, 'ob' );

% Représentation de le la moyenne des échantillons de l'autocorrélation 
% du bruit
M = 1000;
Rbkiter = zeros(2*N-1,1);	
for i = 1:M,
   bk      = randn(N,1);
   Rbkiter = Rbkiter + xcorr(bk, 'biased');
end
RbkM = 1/M * Rbkiter;
figure(3), plot( (-N+1):(N-1), RbkM, 'ob' );



% question 3
% calcul et représentation de la DSP 
% à partir de l'autocorrélation d'une réalisation
Sbk = fft(Rbk); % à changer
figure(4), plot( (0:(N-1))/(2*N-1)/Ts, abs(Sbk(1:(N))), 'ob' );
axis([0 1/2/Ts 0 10])
% à partir de la moyenne des autocorrélations de M réalisations
SbkM = fft(RbkM); % à changer
figure(5), plot( (0:(N-1))/(2*N-1)/Ts, abs(SbkM(1:(N))), 'ob' );
axis([0 1/2/Ts 0 10])

return

% question 4
% représentation des réponses bruit/fréquentielle de Fd
% Parametre de la fonction de transfert discrete
a  = 0.1;
w0 = 0.6;

yk = filter(1, [1, -2*exp(-a*Ts)*cos(w0*Ts), exp(-2*a*Ts) ], bk);
figure(6), plot(yk, 'xb' );

[H, F] = freqz(1, [1, -2*exp(-a*Ts)*cos(w0*Ts), exp(-2*a*Ts) ], 1000, 1/Ts);
figure(7), plot(F, abs(H).^2);

% représentation de la DSP de la sortie de Fd pour entrée
% bruit blanc

Ryk = xcorr(yk, 'biased');
Sy = fft(Ryk);
figure(8), plot( (0:(N-1))/(2*N-1)/Ts, abs(Sy(1:(N))), 'ob' );




