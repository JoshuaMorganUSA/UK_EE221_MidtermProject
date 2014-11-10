tf = xlsread('tf_gain_noBounds.xls');
close all

f0 = 14000;
Q = f0/3000
dB = 12

f02 = 500;
Q2 = f02/500
dB2 = 7

A = 10^(dB/20)
A2 = 10^(dB2/20)
freq_min = 10
freq_max = 20000

w0 = f0*2*pi;
w02 = f02*2*pi;

f = [freq_min:1:freq_max];
s = f * 2 * pi * i;
B = w0/Q;
B2 = w02/Q2;
tstart = tic
H = (A * s * B)./(w0^2 + s * B + s.^2);
elapsed = toc(tstart)
H2 = (A2 * s * B2)./(w02^2 + s * B2 + s.^2);

figure(1);
semilogx(tf(1,:), tf(2,:), 'k*-', 'LineWidth', 2);
hold on
grid
semilogx(f, 20*log10(abs(H2)),'r-');