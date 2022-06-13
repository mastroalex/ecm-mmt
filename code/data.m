function [med,cell]=data(flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%signal_type={'bead','viable','necrotic','apoptotic intact','apoptotic permeable'};
% double shell
eps0 = 8.854e-12;
med.sgm= 1.6;
med.eps= 80*eps0;

switch flag
    case 'bead'
        cell.shell='single';
        mem.thickness=10e-9; %[m]
        cell.radius=3e-6; %[m]
        mem.sgm=1e10; %[S/m]
        mem.eps= 12.8*eps0; 
        int.sgm=2.7e-3; %[S/m]
        int.eps=2.5*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.volfrac=0.1;
    case 'viable'
        cell.shell='single';
        mem.thickness=10e-9; %[m]
        cell.radius=9e-6; %[m]
        mem.sgm=0; %[S/m]
        mem.eps= 12.8*eps0; 
        int.sgm=0.6; %[S/m]
        int.eps=60*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.volfrac=0.1;
    case 'necrotic'
        cell.shell='single';
        mem.thickness=10e-9; %[m]
        cell.radius=9e-6; %[m]
        mem.sgm=1e-3; %[S/m]
        mem.eps= 12.8*eps0; 
        int.sgm=0.6; %[S/m]
        int.eps=60*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.volfrac=0.1;
     case 'apoptotic intact'
        cell.shell='single';
        mem.thickness=10e-9; %[m]
        cell.radius=3e-6; %[m]
        mem.sgm=0; %[S/m]
        mem.eps= 12.8*eps0; 
        int.sgm=0.6; %[S/m]
        int.eps=60*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.volfrac=0.1;
    case 'apoptotic permeable'
        cell.shell='single';
        mem.thickness=10e-9; %[m]
        cell.radius=3e-6; %[m]
        mem.sgm=1e-3; %[S/m]
        mem.eps= 12.8*eps0; 
        int.sgm=0.6; %[S/m]
        int.eps=60*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.volfrac=0.1;
    case 'double'
        cell.shell='double';
        mem.thickness=80*1e-10; %[m]
        cell.radius=6.5*1e-6; %[m]
        int.radius=cell.radius;
        mem.sgm=8e-7*1e-1; %[S/m]
        mem.eps= 9*eps0; 
        int.sgm=0.6; %[S/m]
        int.eps=60*eps0;
        cell.int=int;
        cell.mem=mem;
        cell.np.radius=4.67*1e-6;
        cell.ne.thickness=400*1e-10;
        cell.np.sgm=10*1e-1;
        cell.np.eps=77*eps0;
        cell.ne.sgm=4e-3*1e-1;
        cell.ne.eps=40*eps0;
        cell.cyt.sgm=10*1e-1;
        cell.cyt.eps=77*eps0;
        med.sgm= 1;
        med.eps= 77*eps0;
        cell.volfrac=0.1;
        cell.nuc.volfrac=(cell.np.radius/cell.radius)^3;
end


end