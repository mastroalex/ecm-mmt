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
addpath('subroutine\') % load subroutine path
%% Test cell properties
signal_type={'bead','viable','necrotic','apoptotic intact','apoptotic permeable'};
% set frequency range of analysis
n_f = 50; % numbers of step
f_in = 1e5; % starting point
f_fin = 1e7; % end point
frequency_span= logspace(log10(f_in),log10(f_fin),n_f);

% compute signal for different flag (cell typologies)
for i=1:length(signal_type)
    % load material properties
    [med,cell]=data(signal_type{i});
    [signal{i}, ~]=equivalentCircuitModel(med,cell,frequency_span);
    clear med
    clear cell
end

% plot electric diam = (|signal|)^(1/3)
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

% plot signal phase
signal_phase=figure();
hold on
for i=1:length(signal_type)
    plot(frequency_span, angle(signal{i}));
    set(gca,'Xscale','log');
    ylabel('Phase [rad]')
    xlabel('Frequency [Hz]')
end
legend(signal_type);

% exportgraphics(figure(1),'figs/diam.pdf','BackgroundColor','none','ContentType','vector');
% exportgraphics(figure(2),'figs/phase.pdf','BackgroundColor','none','ContentType','vector');
%% Plot epstilde_mix


clear all
close all
n_f = 60;
f_in = 1e-2*1e6;
f_fin = 1e2*1e6;
frequency_span= logspace(log10(f_in),log10(f_fin),n_f);
omega = 2*pi*frequency_span;
[med,cell]=data('double');

[signal_double, fCM,cell,epstilde_mix]=equivalentCircuitModel(med,cell,frequency_span);

epstilde_mix_plot=figure();
mix_plot(epstilde_mix_plot,epstilde_mix,frequency_span,omega,'')

% exportgraphics(figure(epstilde_mix_plot),'figs/epstilde_mix_plot.pdf','BackgroundColor','none','ContentType','vector');

%% Test perturbations
% load perturbation values
perturbation_values_data

% set different hue for blue and red colors
colorType1={[0.537, 0.474, 0.988],[0.352, 0.258, 1],[0.125, 0.039, 0.741],[0.188, 0.129, 0.611],[0.062, 0.023, 0.376]};
colorType2={[0.972, 0.525, 0.509],[0.960, 0.345, 0.317],[0.784, 0.105, 0.078],[0.611, 0.149, 0.129],[0.380, 0.015, 0]};

% start perturbations sequence

% % % % % eps mem
% load pertubation values 
pert=perturbation_values.eps.mem;
% string for reference
perturbation='{\epsilon}_{mem}'; 
real_value=cell.mem.eps/eps0;
% create figure and plot
eps_mem_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.mem.eps=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(eps_mem_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
eps_mem_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert/eps0,pert/eps0])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % eps cyt
% load pertubation values 
pert=perturbation_values.eps.cyt;
% string for reference
perturbation='{\epsilon}_{cyt}';
real_value=cell.cyt.eps/eps0;
% create figure and plot
eps_cyt_pert=figure();
cell_pert=cell;
for i=1:length(pert)
        % change perturbation properties
    cell_pert.cyt.eps=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(eps_cyt_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
eps_cyt_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert/eps0,pert/eps0])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % eps ne
% load pertubation values 
pert=perturbation_values.eps.ne;
% string for reference
perturbation='{\epsilon}_{ne}';
real_value=cell.ne.eps/eps0;
% create figure and plot
eps_ne_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.ne.eps=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(eps_ne_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
eps_ne_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert/eps0,pert/eps0])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % eps np
% load pertubation values 
pert=perturbation_values.eps.np;
% string for reference
perturbation='{\epsilon}_{np}';
real_value=cell.np.eps/eps0;
% create figure and plot
eps_np_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.np.eps=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(eps_np_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
eps_np_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert/eps0,pert/eps0])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % sgm mem
% load pertubation values 
pert=perturbation_values.sgm.mem;
% string for reference
perturbation='{\sigma}_{mem}'; 
real_value=cell.mem.sgm;
% create figure and plot
sgm_mem_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.mem.sgm=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(sgm_mem_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
sgm_mem_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert,pert])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % sgm cyt
% load pertubation values 
pert=perturbation_values.sgm.cyt;
% string for reference
perturbation='{\sigma}_{cyt}';
real_value=cell.cyt.sgm;
% create figure and plot
sgm_cyt_pert=figure();
cell_pert=cell;
for i=1:length(pert)
        % change perturbation properties
    cell_pert.cyt.sgm=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(sgm_cyt_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
sgm_cyt_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert,pert])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % sgm ne
% load pertubation values 
pert=perturbation_values.sgm.ne;
% string for reference
perturbation='{\sigma}_{ne}';
real_value=cell.ne.sgm;
% create figure and plot
sgm_ne_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.ne.sgm=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(sgm_ne_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% resize figs
sgm_ne_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert,pert])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

% % % % % sgm np
% load pertubation values 
pert=perturbation_values.sgm.np;
% string for reference
perturbation='{\sigma}_{np}';
real_value=cell.np.sgm;
% create figure and plot
sgm_np_pert=figure();
cell_pert=cell;
for i=1:length(pert)
    % change perturbation properties
    cell_pert.np.sgm=pert(i);
[~,~,cell_pert,epstile_mix_pert]=equivalentCircuitModel(med,cell_pert,frequency_span);
mix_plot(sgm_np_pert,epstile_mix_pert,frequency_span,omega,{colorType1{i},colorType2{i}})
clear epstile_mix_pert
end
% % % % % resize figs
sgm_np_pert.Position = [100 100 800 400];
lg=legend(strcat('='," ",string([pert,pert])),'Location','eastoutside');
lg.Title.String=strcat(perturbation,' = ',num2str(real_value),' [S/m]');
title(strcat('Pertubation over'," ",perturbation))

%%

exportgraphics(figure(eps_mem_pert),'figs/eps_mem_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(eps_cyt_pert),'figs/eps_cyt_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(eps_ne_pert),'figs/eps_ne_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(eps_np_pert),'figs/eps_np_pert.pdf','BackgroundColor','none','ContentType','vector');

exportgraphics(figure(sgm_mem_pert),'figs/sgm_mem_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(sgm_cyt_pert),'figs/sgm_cyt_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(sgm_ne_pert),'figs/sgm_ne_pert.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(sgm_np_pert),'figs/sgm_np_pert.pdf','BackgroundColor','none','ContentType','vector');


