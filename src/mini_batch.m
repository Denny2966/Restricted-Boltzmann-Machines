function [ WP, WB, WC ] = mini_batch( data, T, B, C, K, alpha, lambda )
%MINI_BATCH Summary of this function goes here
%   Detailed explanation goes here
    hck = rand(C, K);
    D = size(data, 2);
    WB = normrnd(0, 0.01, 1, K);
    WC = normrnd(0, 0.01, 1, D);
    WP = normrnd(0, 0.01, D, K);
    data_size = size(data, 1);
    NB = data_size / B;
    
    for i = 1:T
        t0 = clock;
        for b = 1:B
            disp(b)
            t1 = clock;
            gWC = zeros(1, D);
            gWB = zeros(1, K);
            gWP = zeros(D, K); 
            
            batch_index = 1+(b-1)*NB:b*NB;
            xd_b = data(batch_index, :);
            
            for n = 1:NB
                xd_tmp = xd_b(n, :);
                gWC = xd_tmp + gWC;
                pk0 = 1.0 ./ (1 + exp(gWB + (gWP'*xd_tmp')'));
                pk1 = 1 -  pk0;
                
                gWB = gWB + pk1;                
                gWP = gWP + repmat(xd_tmp', 1, K) .* repmat(pk1, D, 1);
            end
            
            gWC2 = zeros(1, D);
            gWB2 = zeros(1, K);
            gWP2 = zeros(D, K);
            
            for c = 1:C
                pk0_x = 1.0 ./ (1+exp(gWC2 + (gWP2*hck(c, :)')'));
                xc_bar = ones(1, D);
                xc_bar(rand(1, D) < pk0_x) = 0;
                pk0_h = 1.0 ./ (1 + exp(gWB2 + (gWP2'*xc_bar')'));
                hck(c, :) = ones(1, K);
                hck(c, rand(1, K) < pk0_h) = 0;
                
                gWC2 = gWC2 + xc_bar;
                pk1_h = 1 -  pk0_h;
                
                gWB2 = gWB2 + pk1_h;                
                gWP2 = gWP2 + repmat(xc_bar', 1, K) .* repmat(pk1_h, D, 1);
            end
            
            WC = WC + alpha * (gWC/NB - gWC2/C - lambda * WC);
            WB = WB + alpha * (gWB/NB - gWB2/C - lambda * WB);
            WP = WP + alpha * (gWP/NB - gWP2/C - lambda * WP);
            disp(etime(clock, t1))
        end
        disp('New iteration:')
        disp(i)
        disp('One iteration time is:')
        disp(etime(clock, t0))
        
    end
end