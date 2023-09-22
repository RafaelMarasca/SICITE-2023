function [P] = pool_frequency(N,Fs) 

    K = 1:N/2+1;
    coef_K = f_coef(K,Fs,N);
    
    P = zeros(128,N/2+1);
    
    for p = 0:127
        f_lower = f_pitch(p-0.5);
        f_higher = f_pitch(p+0.5);
        P(p+1,:) = (coef_K < f_higher & coef_K >= f_lower);
    end

end