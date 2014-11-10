tf = xlsread('tf_gain.xls');
close all

f0 = 500;
Q = f0/400
dB = 7.5



A = 10^(dB/20)

freq_min = 10
freq_max = 20000

w0 = f0*2*pi;


f = [freq_min:1:freq_max];
s = f * 2 * pi * i;
B = w0/Q

H = (A * s * B)./(w0^2 + s * B + s.^2);


figure(1);
semilogx(tf(1,:), tf(2,:), 'k*-', 'LineWidth', 2);
hold on
grid
semilogx(f, 20*log10(abs(H)),'r-');