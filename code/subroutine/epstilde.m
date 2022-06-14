function epsitilde_value=epstilde(structure,omega)
    %eps_med + sig_med./(omega*1i);
    epsitilde_value=structure.eps+structure.sgm./(omega*1i);
end