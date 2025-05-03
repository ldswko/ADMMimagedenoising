function [d_down_kp1, d_right_kp1] = Update_D(lambda_down_k, lambda_right_k, y_k)
[M,N] = size(y_k); 

d_down_kp1 = zeros(M-1, N);

for i = 1:(M-1)
    for j = 1:N
        z = y_k(i+1, j) - y_k(i, j) - lambda_down_k(i, j);
        d_down_kp1(i, j) = Prox_Absolute_Value(z);
    end
end

d_right_kp1 = zeros(M, N-1);
    for i = 1:M
        for j = 1:(N-1)
            z = y_k(i, j+1) - y_k(i, j) - lambda_right_k(i, j);
            d_right_kp1(i, j) = Prox_Absolute_Value(z);
        end
    end

end
