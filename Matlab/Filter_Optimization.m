%This script will 'brute-force' optimize the filter parameters for the
%active filter being constructed. The initial design utilizes 4 band-pass
%filters to match the desired transfer function.

%Written by Joshua P. Morgan
%11/2014


%clean up workspace
close all
j = sqrt(-1);


%These are the optimization parameters. Being greeedy here will make for
%long run time.

%All of these parameters are in Hz when appropriate
freq_range_min = 50;
freq_range_max = 20000;
freq_range_step = 1; 

%Center frequency parameters (Hz)
%min, guess, max

fc = [  [300,   500,    600];...
        [3000,  3500,   4000];...
        [5000,  6000,   7000];...
        [12000, 14000,  16000]];
    
%Gain parameters (dB)
%min, guess, max

G = [   [3.75,  7.5,    11.25];...
        [-1,    0,      1];...
        [-3,    -1.5,   0];...
        [7,     12,     19]];

%BW parameters (Hz)
%min, guess, max
BWf = [  [200,   400,    600];...
        [500,   1000,   1500];...
        [500,   1000,   1500];...
        [1000,  3000,   5000]];
    
       
    
    
%Center frequency parameters in rad/s
wc = fc * 2 * pi;

%Log gain G converted to linear gain A
A = 10.^(G/20);

%BW converted to rad/s
BWw = BWf * 2 * pi;





%Build test freq array
f = [freq_range_min:freq_range_step:freq_range_max];

%Build 's' array. 
s = f * 2 * pi * j; 

%Get ideal transfer function from file
tf_ideal_raw = xlsread('tf_gain_noBounds.xls');

%Build tf_ideal vector with sample at every sample point
%Should probably preallocate for speed but can deal with later
tf_ideal = [];
for(i = tf_ideal_raw(1,1):freq_range_step:tf_ideal_raw(1, end))
    
   tf_ideal = [tf_ideal,[i; interp1(tf_ideal_raw(1,:), tf_ideal_raw(2,:), i)]];
   
end





function f = myFunction

end


% %Build sample value arrays
% %BPF1
% bpf1_fc = bpf1_fc_min : bpf1_fc_step : bpf1_fc_max;
% bpf1_A = bpf1_A_min : bpf1_A_step : bpf1_A_max;
% bpf1_BW = bpf1_BW_min : bpf1_BW_step : bpf1_BW_max;
% 
% %BPF2
% bpf2_fc = bpf2_fc_min : bpf2_fc_step : bpf2_fc_max;
% bpf2_A = bpf2_A_min : bpf2_A_step : bpf2_A_max;
% bpf2_BW = bpf2_BW_min : bpf2_BW_step : bpf2_BW_max;
% 
% %BPF3
% bpf3_fc = bpf3_fc_min : bpf3_fc_step : bpf3_fc_max;
% bpf3_A = bpf3_A_min : bpf3_A_step : bpf3_A_max;
% bpf3_BW = bpf3_BW_min : bpf3_BW_step : bpf3_BW_max;
% 
% %BPF4
% bpf4_fc = bpf4_fc_min : bpf4_fc_step : bpf4_fc_max;
% bpf4_A = bpf4_A_min : bpf4_A_step : bpf4_A_max;
% bpf4_BW = bpf4_BW_min : bpf4_BW_step : bpf4_BW_max;
% 

