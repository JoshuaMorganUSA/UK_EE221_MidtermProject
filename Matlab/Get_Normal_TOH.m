close all

cal_freq = 3500;
cal_dblevel = -4;

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
   
    %Automatically enter the cal data so user can't mess it up
    if(normal_TOH(1, i) == cal_freq)
        str_num = cal_dblevel;
        
    else
        str = input(strcat(num2str(normal_TOH(1, i)), ': '),  's');
        str_num = str2double(str);

        %Confirm user   1) Entered something
        %               2) Entered a number

        while(isempty(str) || isnan(str_num))

            disp('You must enter a number');
            str = input(strcat(num2str(normal_TOH(1, i)), ': '),  's');
            str_num = str2double(str);
        end
    end
    
    
    normal_TOH(2,i) = str_num;
    
end


%Plot
f1 = figure(1);
semilogx(normal_TOH(1,:), normal_TOH(2,:), 'b*-', 'LineWidth', 2);
grid
title('Normal TOH Curve')
xlabel('Frequency (Hz)')
ylabel('Threshold of Hearing (dB)')


%Save Figure
saveas(f1, 'normal_TOH.jpg');

%Save data
delete('normal_TOH.xls');
xlswrite('normal_TOH', normal_TOH);




