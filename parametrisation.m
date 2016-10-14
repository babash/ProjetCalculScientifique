function [sequence]=parametrisation(nomfichier)

Tw = 25;           % analysis frame duration (ms)
Ts = 10;           % analysis frame shift (ms)
alpha = 0.97;      % preemphasis coefficient
R = [ 300 3700 ];  % frequency range to consider
M = 20;            % number of filterbank channels 
C = 13;            % number of cepstral coefficients
L = 22;            % cepstral sine lifter parameter

% hamming window (see Eq. (5.2) on p.73 of [1])
hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));

% Read speech samples, sampling rate and precision from file
[ speech, fs] = audioread(nomfichier);

% Feature extraction (feature vectors as columns)
[ MFCCs, FBEs, frames ] = ...
    mfcc( speech, fs, Tw, Ts, alpha, hamming, R, M, C, L );

% % Plot cepstrum over time
% figure('Position', [30 100 800 200], 'PaperPositionMode', 'auto', ... 
%         'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
%         
% imagesc( [1:size(MFCCs,2)], [0:C-1], MFCCs ); 
% axis( 'xy' );
% xlabel( 'Frame index' ); 
% ylabel( 'Cepstrum index' );
% title( 'Mel frequency cepstrum' );

sequence = MFCCs(2:13,:) ; % on supprime le parametre 1 car il est relatif � l'energie du signal

% Soustraction du vecteur moyen
%moyenne = mean(sequence');
%for i=1:size(sequence,2)
%  sequence_m(1:12,i) = sequence(1:12,i) - moyenne' ;
%end

% % Soustraction du dernier vecteur
% for i=1:size(sequence,2)
%   sequence_m(1:12,i) = sequence(1:12,i) - sequence(1:12,end) ;
% end

% on ne fait rien pour débruiter
sequence_m = sequence;

% figure('Position', [30 100 800 200], 'PaperPositionMode', 'auto', ... 
%         'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
%         
% imagesc( [1:size(sequence_m,2)], [1:C-1], sequence_m ); 
% axis( 'xy' );
% xlabel( 'Frame index' ); 
% ylabel( 'Cepstrum index' );
% title( 'Mel frequency cepstrum (mean cepstral soustraction)' );

% retrait du silence en d�but et fin
ratio=0.7;
%for i=1:size(sequence_m,2)
%  energie(i)=log(sqrt(sum(sequence_m(:,i).^2)));
%end
energie=MFCCs(1,:);
% figure
% plot(energie)
energiecoupure=ratio*max(energie);
indicedeb=1;
while (energie(indicedeb)<energiecoupure)
  indicedeb = indicedeb+1;
endwhile
indicefin=length(energie);
while (energie(indicefin)<energiecoupure)
  indicefin = indicefin-1;
endwhile

sequence = sequence_m(:,indicedeb:indicefin);
endfunction
