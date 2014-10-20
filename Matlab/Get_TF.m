close all

lower_bound_freq = 50;
lower_bound_db = 3;
upper_bound_freq = 20000;
upper_bound_db = 3;

%Read in normal_vs_client
normal_vs_client = xlsread('normal-vs-client_TOH.xls');

tf = [normal_vs_client(1,:); normal_vs_client(4,:)];
%tf = [[lower_bound_freq; lower_bound_db], tf, [upper_bound_freq; upper_bound_db]];

f1 = figure(1)
semilogx(tf(1,:), tf(2,:), 'k-', 'LineWidth', 2);
title('Ideal Transfer Function');
xlabel('Frequency (Hz)')
ylabel('Required Gain (dB)');
grid;

%save figure
saveas(f1, 'tf_gain.jpg');

%save data
delete('tf_gain.xls');
xlswrite('tf_gain', tf);


