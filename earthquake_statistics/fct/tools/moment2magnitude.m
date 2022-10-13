function Mw = moment2magnitude(M0)

% Mw = 2/3 log10(M0) - 10.73, with M0 in [dyne-cm] (Stein and Wysession, p.266)
% Mw = 2/3 log10(M0) - 6.063, with M0 in [Nm]    

% Kanamori (1977): Mw = 2/3*(log10(M0) - 16.1), with M0 in [dyne-cm]
%                     = 2/3* log10(M0) - 10.7333 
%                     = 2/3* log10(M0) - 6.0666 with M0 in [Nm]

Mw = 2/3*log10(M0) - 6.0666; % [Nm]

% E.g. Chile 1960 had M0 = 2.4e30 [dyne-cm] = 2.4e23 [Nm]
% Mw_nm = 2/3*log10(2.4e23) -  6.0666;
% Mw_dc = 2/3*log10(2.4e30) - 10.7333;