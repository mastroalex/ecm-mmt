eps0=8.854e-12;

n_f=60;
f_in=1e-2;
f_fin=1e2;
f=logspace(log10(f_in),log10(f_fin),n_f);
omega=2*pi*f;


r_cell=6.5*1e-6;
r_np=4.67*1e-6;

d_mem=80*1e-10;
d_ne=400*1e-10;

sig_np=10*1e-1;
eps_np=77*eps0;

sig_ne=4e-3*1e-1;
eps_ne=40*eps0;

sig_cyt=10*1e-1;
eps_cyt=77*eps0;

sig_mem=8e-7*1e-1;
eps_mem=9*eps0;

sig_med=1;
eps_med=77*eps0;

volfrac=0.1;

cell_frac=(r_np/r_cell)^3;

epstilde_np=eps_np + sig_np./(1i*omega);
epstilde_ne=eps_ne + sig_ne./(1i*omega);
epstilde_cyt=eps_cyt + sig_cyt./(1i*omega);
epstilde_mem=eps_mem + sig_mem./(1i*omega);
epstilde_med=eps_med + sig_med./(1i*omega);

chi_nuc=(epstilde_ne./d_ne)./(epstilde_np./r_np);
epstilde_nuc=epstilde_np.* (chi_nuc)./(1+chi_nuc);

fcm_nuc=(epstilde_nuc-epstilde_cyt)./(epstilde_nuc+2*epstilde_cyt);
epstilde_int=epstilde_cyt.*((1+2*cell_frac.*fcm_nuc)./(1-cell_frac.*fcm_nuc));

chi=(epstilde_mem./d_mem)./(epstilde_int./r_cell);
epstilde_cell=epstilde_int.*((chi)./(1+chi));

fcm_mix=(epstilde_cell-epstilde_med)./(epstilde_cell+2.*epstilde_med);

epstilde_mix=epstilde_med.*((1+2*volfrac.*fcm_mix)./(1-volfrac.*fcm_mix));


figure;
yyaxis left
plot(f, real(epstilde_mix),'-ob');
ylabel('eps_{mix}','Color','b')
hold on
set(gca,'Xscale','log');
yyaxis right
plot(f, imag(epstilde_mix),'-or');
ylabel('sgm_{mix}','Color','r')
