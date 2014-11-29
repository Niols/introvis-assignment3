% Benchmark

load two_clusters.mat;

for i = 1:100
  _ = meanshift (data, 2);
endfor
