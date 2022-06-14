function fcm = ClausiusMossotti(particle, mean)
% compute Clausius-Mossotti factor
fcm = (particle.epstilde-mean.epstilde)./(particle.epstilde+2.*mean.epstilde);
end