function mix_plot(figure_num,eps_mix,frequency_span,omega,color)
% plot
eps0 = 8.854e-12;
% normalization factor for eps
scale=eps0*100;
% recall figs
figure_num();
yyaxis left
if not(isempty(color))
    % plot for perturbations with color variations
    plot(frequency_span, real(eps_mix)/scale,'-o','Color',color{1},'MarkerSize',4);
else
    % standard plot
    plot(frequency_span, real(eps_mix)/scale,'-ob');
end
ylabel('eps_{mix}/100','Color','b')
hold on
set(gca,'Xscale','log');
yyaxis right
if not(isempty(color))
    % plot for perturbations with color variations
    plot(frequency_span, -imag(eps_mix).*omega,'-o','Color',color{2},'MarkerSize',4);
else
    % standard plot
    plot(frequency_span, -imag(eps_mix).*omega,'-or');
end
ylabel('sgm_{mix} [S/m]','Color','r')
xlabel('frequency [Hz]')
grid on
end