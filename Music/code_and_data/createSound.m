amp=2;
fs=8192; % sampling frequency
duration=1;0:10:end
freq=256;
values= 0:1/fs:duration;
a=amp*sin(2*pi*freq*values);
