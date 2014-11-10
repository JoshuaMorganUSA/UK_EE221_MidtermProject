function tf_sum = bpf2tf(bpf, s)
wc = bpf(1:3:end);
A = bpf(2:3:end);
BW = bpf(3:3:end);

tf = [];
for i = 1:size(wc, 2)
    tf = [tf;(A(i) * s * BW(i))./(wc(i)^2 + s * BW(i) + s.^2)];     
    
end

tf_sum = sum(tf, 1);

end