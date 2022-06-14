function eps_mix=eps_mix(fCM,epstilde_med,vol_frac)
% compute MMT homogenization
multiply=(1+2*vol_frac.*fCM)./(1-vol_frac.*fCM);
eps_mix=epstilde_med.*(multiply);
end

