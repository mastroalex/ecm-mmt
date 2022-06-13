function cell=MMT(cell,omega)
% epstilde_mem = eps_mem + sig_mem./(omega*1i);
% epstilde_int = eps_int + sig_int./(omega*1i);
% chi = (epstilde_mem./d_mem)./(epstilde_int./r_cell);
% epstilde_cell = epstilde_int.*(chi./(1+chi));

    if isequal(cell.shell,'single')
        cell.int.epstilde=epstilde(cell.int,omega);
        cell.mem.epstilde=epstilde(cell.mem,omega);
        chi=(cell.mem.epstilde./cell.mem.thickness)./(cell.int.epstilde./cell.radius);
        cell.epstilde=cell.int.epstilde.*(chi./(1+chi));
    elseif isequal(cell.shell,'double')
        cell.np.epstilde=epstilde(cell.np,omega);
        cell.ne.epstilde=epstilde(cell.ne,omega);
        cell.cyt.epstilde=epstilde(cell.cyt,omega);
        cell.mem.epstilde=epstilde(cell.mem,omega);
        % first homogenization
        cell.nuc.epstilde=mixture(cell.ne,cell.np);
        % MMT
        cell.int.fcm=ClausiusMossotti(cell.nuc,cell.cyt);
        cell.int.epstilde=fcm_mix(cell.int.fcm,cell.cyt.epstilde,cell.nuc.volfrac);
        % second homogenization
        cell.epstilde=mixture(cell.mem,cell.int);
    end
    
end