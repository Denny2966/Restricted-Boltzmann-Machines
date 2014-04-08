function [ xd, hk ] = Gibbs_sampler( WP, WB, WC, S )
%GIBBS_SAMPLER Summary of this function goes here
%   Detailed explanation goes here
K = size(WB, 2);
D = size(WC, 2);
hk0 = rand(1, K);
hk0(hk0<0.5) = 0;
hk0(hk0>=0.5) = 1;

hk = zeros(S, K);
xd = zeros(S, D);

for i = 1:S
    if i == 1
        deno = 1+exp(WC + (WP*hk0')');
    else
%        disp(size(WP))
%        disp(size(hk{i-1}))
%        disp(max(WC+(WP*hk{i-1}')'))
        deno = 1+exp(WC + (WP*hk(i-1, :)')');
    end
    p0 = 1.0 ./ deno;
    
    xs = rand(1, D);
    xs(xs<p0) = 0;
    xs(xs>=p0) = 1;
    xd(i, :) = xs;
    
%    disp(max(WB+(WP'*xs')'))
    deno_h = 1+exp(WB + (WP'*xs')');
    p0_h = 1 ./ deno_h;
    
    xs_h = rand(1, K);
    xs_h(xs_h < p0_h) = 0;
    xs_h(xs_h >= p0_h) = 1;
    
    hk(i, :) = xs_h;
%    disp('hk')
%    disp(i)
%    disp(size(hk{i}))
end

