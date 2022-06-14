% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Mastrofini Alessandro
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Medical Engineering - University of Rome Tor Vergata
% Physiological Systems Modeling and Simulation
% F. Caselli, MSSF A.Y. 2021/2022
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% ECM - MMT - Cytometers
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

clear all;
close all;
clc;
%%
signal_type={'bead','viable','necrotic','apoptotic intact','apoptotic permeable'};

n_f = 50;
f_in = 1e5;
f_fin = 1e7;
frequency_span= logspace(log10(f_in),log10(f_fin),n_f);

for i=1:length(signal_type)
    [med,cell]=data(signal_type{i});
    [signal{i}, ~]=equivalentCircuitModel(med,cell,frequency_span);
    clear med
    clear cell
end

%%



% signal=equivalentCircuitModel('test',frequency_span);
%%

signal_diam=figure();
hold on
for i=1:length(signal_type)
    plot(frequency_span, 10e6*(abs(signal{i})).^(1/3));
    ylabel('\Re [f_{CM}]')
    set(gca,'Xscale','log');
    ylabel('Electric diam [{\mu}m]')
    xlabel('Frequency [Hz]')
end
legend(signal_type);

signal_phase=figure();
hold on
for i=1:length(signal_type)
    plot(frequency_span, angle(signal{i}));
    set(gca,'Xscale','log');
    ylabel('Phase [rad]')
    xlabel('Frequency [Hz]')
end
legend(signal_type);


%%

n_f = 60;
f_in = 1e-2;
f_fin = 1e2;
frequency_span= logspace(log10(f_in),log10(f_fin),n_f);
omega = 2*pi*frequency_span;

[med,cell]=data('double');

[signal_double, fCM,cell,eps_mix]=equivalentCircuitModel(med,cell,frequency_span);

figure;
yyaxis left
plot(frequency_span, real(eps_mix),'-ob');
ylabel('eps_{mix}','Color','b')
hold on
set(gca,'Xscale','log');
yyaxis right
plot(frequency_span, imag(eps_mix),'-or');
ylabel('sgm_{mix}','Color','r')


cell.cyt.sgm=10e-3;

[signal_double, fCM,cell,eps_mix]=equivalentCircuitModel(med,cell,frequency_span);

hold on;
yyaxis left
plot(frequency_span, real(eps_mix),'-ob');
ylabel('eps_{mix}','Color','b')
hold on
set(gca,'Xscale','log');
yyaxis right
plot(frequency_span, imag(eps_mix),'-or');
ylabel('sgm_{mix}','Color','r')

