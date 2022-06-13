function epstilde_cell = epstilde_cell(eps_mem, sig_mem, eps_int, sig_int, d_mem, r_cell, omega)
epstilde_mem = eps_mem + sig_mem./(omega*1i);
epstilde_int = eps_int + sig_int./(omega*1i);
chi = (epstilde_mem./d_mem)./(epstilde_int./r_cell);
epstilde_cell = epstilde_int.*(chi./(1+chi));
end