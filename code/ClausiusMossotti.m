function fcm = ClausiusMossotti(particle, mean)
fcm = (particle.epstilde-mean.epstilde)./(particle.epstilde+2.*mean.epstilde);
end