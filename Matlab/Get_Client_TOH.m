close all

%Config
cal_freq = 3500;
cal_dblevel = -4;
dbstep = 2;

client_counts_file = 'client_counts.xls';



%Get data from raw file
client_counts = xlsread(client_counts_file);

%Create new array of TOH data
client_TOH = client_counts(1, 1:2:end); %Get only freq row
client_TOH = [client_TOH; mean(client_counts(2:end, 1:2:end))];


%find index of cal frequency
cal_index = find(client_TOH(1,:) == cal_freq);

%Convert to dB
client_TOH(2,:) = dbstep * (client_TOH(2, cal_index) - client_TOH(2,:)) + cal_dblevel;

%Plot
f1 = figure(1);
title('Client TOH Curve')
xlabel('Frequency (Hz)')
ylabel('Threshold of Hearing (dB)')
semilogx(client_TOH(1,:), client_TOH(2,:), 'r*-', 'LineWidth', 2);
grid

%Save Figure
saveas(f1, 'client_TOH.jpg');

%Save data
xlswrite('client_TOH', client_TOH);


