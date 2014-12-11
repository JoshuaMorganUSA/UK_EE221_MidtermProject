%TF Plotter
%Written by: Joshua P. Morgan
%11/2014
close all
j = sqrt(-1);

%Set up freq ranges
freq_min = 1
freq_max = 20000

%Set up freq and s vectors
f = [freq_min:1:freq_max];
s = f * 2 * pi * j;

W01 = 1884.965;
A1 = 3.426414;
BW1 = 3769.904;
%Define transfer function
H = (A1 * s * BW1)./(W01^2 + s * BW1 + s.^2);

%Plot TF
figure(1);
semilogx(f, 20*log10(abs(H)),'k-', 'LineWidth', 2);
xlabel('Frequency (Hz)')
ylabel('io/vi (dB)')
grid