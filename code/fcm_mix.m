function eps_mix=fcm_mix(fCM,eps_med,vol_frac)
multiply=(1+2*vol_frac*fCM)./(1-vol_frac.*fCM);
eps_mix=eps_med.*(multiply);
end