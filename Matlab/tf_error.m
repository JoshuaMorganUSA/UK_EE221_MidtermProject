function error = tf_error(x, s, tf_ideal)

tf_sum = bpf2tf(x, s);

f = s / (2 * pi * j);
error = std(tf_ideal(2,:) - 20*log10(abs((tf_sum(find(f <= tf_ideal(1,1), 1, 'last'):find(f >= tf_ideal(1,end), 1, 'first'))))));




end