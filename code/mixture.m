function epstilde=mixture(mem,int)
chi=(mem.epstilde./mem.thickness)./(int.epstilde./int.radius);
epstilde=int.epstilde.*(chi/(1+chi));
end