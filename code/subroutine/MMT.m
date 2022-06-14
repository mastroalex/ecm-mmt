function cell=MMT(cell,omega)
% compute Maxwell Mitures theory to omogenize cell properties
% compute complex permettivity with epstilde()
% compute homogenization with mixture()
    if isequal(cell.shell,'single') % single shell model
        cell.int.epstilde=epstilde(cell.int,omega);
        cell.mem.epstilde=epstilde(cell.mem,omega);
        cell.epstilde=mixture(cell.mem,cell.int);
    elseif isequal(cell.shell,'double') % diuble shell model
        cell.np.epstilde=epstilde(cell.np,omega);
        cell.ne.epstilde=epstilde(cell.ne,omega);
        cell.cyt.epstilde=epstilde(cell.cyt,omega);
        cell.mem.epstilde=epstilde(cell.mem,omega);
        % first homogenization
        cell.nuc.epstilde=mixture(cell.ne,cell.np);
        % MMT
        cell.int.fcm=ClausiusMossotti(cell.nuc,cell.cyt); 
        %compute eps_star_mix
        cell.int.epstilde=eps_mix(cell.int.fcm,cell.cyt.epstilde,cell.nuc.volfrac);
        % second homogenization
        cell.epstilde=mixture(cell.mem,cell.int);
    end
    
end