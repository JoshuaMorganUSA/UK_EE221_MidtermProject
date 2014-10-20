close all

%File names
client_file = 'client_TOH.xls';
normal_file = 'normal_TOH.xls';



%Read in data;
client_TOH = xlsread(client_file);
normal_TOH = xlsread(normal_file);

%Assume have same frequency points
normal_vs_client = [normal_TOH(1,:); normal_TOH(2,:); client_TOH(2,:)]

%concatenate Differences
normal_vs_client = [normal_vs_client; normal_TOH(2,:) - client_TOH(2,:)];

%plot data

f1 = figure(1);
%Plot Normal
semilogx(normal_vs_client(1,:), normal_vs_client(2,:), 'b*-', 'LineWidth', 2);
hold on
%Plot Client
semilogx(normal_vs_client(1,:), normal_vs_client(3,:), 'r*-', 'LineWidth', 2);
%Plot difference
semilogx(normal_vs_client(1,:), normal_vs_client(4,:), 'k*-', 'LineWidth', 2);
grid
title('Normal & Client TOH');
xlabel('Frequency (Hz)');
ylabel('Threshold of Hearing (dB)');
legend('Normal TOH', 'Client TOH', 'Normal minus Client TOH');


%save plot
saveas(f1, 'normal-vs-client_TOH.jpg');

%save data
delete('normal-vs-client_TOH')
xlswrite('normal-vs-client_TOH', normal_vs_client);

