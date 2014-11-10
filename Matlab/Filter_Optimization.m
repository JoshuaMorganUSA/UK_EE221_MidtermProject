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

%End bounds (<3dB @ 50Hz, 20 kHz)
end_bounds = [50, 20000; 3, 3];

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

x0 = [];
lowerBound = [];
upperBound = [];
for i = 1:size(wc,1)
   	lowerBound = [lowerBound, wc(i, 1), A(i, 1), BWw(i, 1)];
    x0 = [x0, wc(i, 2), A(i, 2), BWw(i,2)];
    upperBound = [upperBound, wc(i, 3), A(i, 3), BWw(i, 3)];

end;


%Builds 'f' array
f = freq_range_min : freq_range_step : freq_range_max;

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

options = optimset('fmincon');
options.MaxFunEvals = 10000;

%Actually do optimization
bpf_opt =  fmincon(@(x)tf_error(x,s,tf_ideal),x0,[],[],[],[],lowerBound, upperBound, [], options);

%Get transfer function of optimized filter
tf_opt = bpf2tf(bpf_opt, s);

%Convert to dB
tf_opt_db = 20 * log10(abs(tf_opt));

figure(1);
semilogx(tf_ideal(1,:), tf_ideal(2,:), 'b-', 'LineWidth', 2);
hold on
semilogx(f, tf_opt_db, 'r-', 'LineWidth', 2);
grid;

%plot bound lines. end points of transfer function must be below this
%point. 
semilogx(end_bounds(1,:), end_bounds(2,:), 'm--', 'LineWidth', 1.5);


%plot points on tf_opt_db line that correspond to end_bounds
bound_points = [end_bounds(1,:); tf_opt_db(find(f <= end_bounds(1, 1), 1, 'last')), tf_opt_db(find(f >= end_bounds(1, 2), 1, 'first'))];
semilogx(bound_points(1,:), bound_points(2,:), 'ro', 'LineWidth', 2, 'MarkerSize', 7);


