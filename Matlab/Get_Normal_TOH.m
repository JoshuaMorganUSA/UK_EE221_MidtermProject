close all

%Use Client File for freqs
infile = 'client_TOH.xls';

%get in data
indata = xlsread(infile);

%Create normal_TOH
normal_TOH = indata(1,:);   %Get freqs
normal_TOH = [normal_TOH; zeros(1, length(normal_TOH))]
%Get dB from user
disp('Enter the dB level from the normal TOH curve for each frequency.');

for i = 1:length(normal_TOH)
   
    str = input(strcat(num2str(normal_TOH(1, i)), ': '),  's');
    str_num = str2double(str);
    
    %Confirm user   1) Entered something
    %               2) Entered a number
    
    while(isempty(str) || isnan(str_num))
       
        disp('You must enter a number');
        str = input(strcat(num2str(normal_TOH(1, i)), ': '),  's');
        str_num = str2double(str);
    end
    
    
    normal_TOH(2,i) = str_num;
    
end


%Plot
f1 = figure(1);
title('Normal TOH Curve')
xlabel('Frequency (Hz)')
ylabel('Threshold of Hearing (dB)')
semilogx(normal_TOH(1,:), normal_TOH(2,:), 'b*-', 'LineWidth', 2);
grid

%Save Figure
saveas(f1, 'normal_TOH.jpg');

%Save data
xlswrite('normal_TOH', normal_TOH);




