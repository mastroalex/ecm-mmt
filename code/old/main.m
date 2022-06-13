clear all;
close all;
clc; 
%%
r_cell = 3e-6;
d_mem = 10e-9;
eps0 = 8.854e-12;
sig_med = 1.6;
eps_med = 80*eps0;
sig_mem = 0;
eps_mem = 12.8*eps0;
sig_int = 0.6;
eps_int = 60*eps0;
n_f = 50;
f_in = 1e5;
f_fin = 1e7;
passo = (f_fin-f_in)/n_f;
f = logspace(log10(f_in),log10(f_fin),n_f);
omega = 2*pi*f;

%%
% epstilde_mem = eps_mem + sig_mem./(omega*1i);
% epstilde_int = eps_int + sig_int./(omega*1i);
epstilde_med = eps_med + sig_med./(omega*1i);
%chi = (epstilde_mem./d_mem)./(epstilde_int./r_cell);
%epstilde_cell = epstilde_int.*(chi./(1+chi));
epstilde_cell = epstilde_cell(eps_mem, sig_mem, eps_int, sig_int, d_mem, r_cell, omega);
%fcm = (epstilde_cell-epstilde_med)./(epstilde_cell+2*epstilde_med);
fcm = fcm (epstilde_cell, epstilde_med);
%%
subfigure(1,2,1);
plot(f, real(fcm));
set(gca,'Xscale','log');
subfigure(1,2,2);
plot(f, imag(fcm));
set(gca,'Xscale','log');

%%

figure;
plot(f, real(epstilde_cell));
set(gca,'Xscale','log');
figure;
plot(f, imag(epstilde_cell));
set(gca,'Xscale','log');

