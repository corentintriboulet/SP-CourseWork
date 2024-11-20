%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ecole Centrale de Lyon
% STItc2 - Traitement du Signal
% Programme d'illustration pour la modulation/d�modulation d'amplitude
% Synth�se du filtre de Butterworth 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc;

% param�tres des signaux
nu0 = 1;   % Fr�quence du signal x (Hz) 
num = 10;  % Frequence porteuse (Hz)

% Synth�se d'un filtre passe-bas de butterworth d'ordre n : F(s) = B(s)/A(s)
n = ;    % Ordre du filtre, A completer
nuc = ;  % Frequence de coupure du filtre (Hz), A completer
[B,A] = butter(n,2*pi*nuc,'s'); 

% R�ponse fr�quentielle du filtre
nu = -4*num:10^(-3):4*num;  % vecteur des fr�quences
H = freqs(B,A,2*pi*nu);

figure,
subplot(211),
plot(nu,abs(H)); % Affiche le module du spectre pour les frequences nu
grid on;
ylim([0 1.2]*max(abs(H)));
xlabel('frequences \nu (Hz)');
ylabel('module');
title(['filtre passe-bas (butterworth), n = ',num2str(n),', \nu_c = ',num2str(nuc)]);
subplot(212),
plot(nu,angle(H)); % Affiche l'argument du spectre pour les frequences nu
grid on;
ylim([-3.5 3.5]);
xlabel('frequences \nu (Hz)');
ylabel('phase (rad)');
