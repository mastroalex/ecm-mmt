function [signal, fCM, cell,eps_mix]=equivalentCircuitModel(med,cell,f)
omega = 2*pi*f;
med.epstilde=epstilde(med,omega);
cell=MMT(cell,omega); % this add epstidel field to cell
fCM=ClausiusMossotti(cell, med);
signal=(cell.radius)^3*fCM;
eps_mix=fcm_mix(fCM,med.epstilde,cell.volfrac);
end