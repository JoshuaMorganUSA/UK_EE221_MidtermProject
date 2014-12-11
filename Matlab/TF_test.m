tf = xlsread('tf_gain.xls');
close all
j = sqrt(-1);


freq_min = 10
freq_max = 20000

f = 10:1:20000;
s = j .* f * 2 * pi;

W01 = 1884.965;
A1 = 3.426414;
BW1 = 3769.904;
%Define transfer function
H1 = (A1 * s * BW1)./(W01^2 + s * BW1 + s.^2);

W02 = 19981;
A2 = 0.936781;
BW2 = 9424.759;
%Define transfer function
H2 = (A2 * s * BW2)./(W02^2 + s * BW2 + s.^2);

W03 = 38460.3;
A3 = 0.883583;
BW3 = 6152.577;
%Define transfer function
H3 = (A3 * s * BW3)./(W03^2 + s * BW3 + s.^2);

W04 = 85149.47;
A4 = 5.334702;
BW4 = 14992.04;
%Define transfer function
H4 = (A4 * s * BW4)./(W04^2 + s * BW4 + s.^2);

Spice = xlsread('Spice_TOH.xls');

H5 = H1 + H2 + H3 + H4;

figure(1);
semilogx(tf(1,:), tf(2,:), 'k*-', 'LineWidth', 2);
hold on
grid
semilogx(f, 20*log10(abs(H1)),'r-');
semilogx(f, 20*log10(abs(H2)),'r-');
semilogx(f, 20*log10(abs(H3)),'r-');
semilogx(f, 20*log10(abs(H4)),'r-');
semilogx(f, 20*log10(abs(H5)),'r-', 'LineWidth', 2);
semilogx(Spice(1,:), Spice(2,:), 'm-*', 'LineWidth', 3);


mean_bias_error = 0;
for i = 1:length(Spice)
   
    ind = find(f <= Spice(1, i), 1, 'last');
    mat_val = 20*log10(abs(H5(ind)));
    spi_val = Spice(2,i);
    
    mean_bias_error = mean_bias_error + (abs(spi_val) - abs(mat_val));
    
    
    
end

mean_bias_error = mean_bias_error/length(Spice);

total_rms_err = 0;

final_error = [];

for i = 1:length(Spice)
   
    ind = find(f <= Spice(1, i), 1, 'last');
    mat_val = 20*log10(abs(H5(ind)));
    spi_val = Spice(2,i);
    
    rms_err = ((abs(spi_val) - abs(mat_val) - mean_bias_error))^2;
    total_rms_err = total_rms_err + rms_err;
    
    bias_error = abs(spi_val) - abs(mat_val);
    
    
    disp(strcat(num2str(Spice(1, i)),':      ', num2str(bias_error),',      ',  num2str(rms_err)));
    final_error = [final_error; [Spice(1,i), bias_error, rms_err]];
    
    
    
end

total_rms_err = sqrt(total_rms_err/length(Spice));
xlswrite('Matlab vs Spice', final_error);


disp(strcat('Bias: ', num2str(mean_bias_error)));
disp(strcat('RMS: ', num2str(total_rms_err)));
