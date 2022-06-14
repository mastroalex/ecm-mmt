function epstilde=mixture(mem,int)
% computer homogenization
chi=(mem.epstilde./mem.thickness)./(int.epstilde./int.radius);
epstilde=int.epstilde.*(chi)./(1+chi);
end