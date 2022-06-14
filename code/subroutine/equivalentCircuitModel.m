function [signal, fCM, cell,epstilde_mix]=equivalentCircuitModel(med,cell,f)
% this routine
omega = 2*pi*f;
% compute complex permettivity
med.epstilde=epstilde(med,omega);
% compute complex permettivity
% homogenization of the cell properties with MMT
% this add .epstilde field to cell structure
cell=MMT(cell,omega); 
% compute ClausiusMossotti factor
fCM=ClausiusMossotti(cell, med);
% compute signal
signal=(cell.radius)^3*fCM;
%compute eps_star_mix
epstilde_mix=eps_mix(fCM,med.epstilde,cell.volfrac);
end