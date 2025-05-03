
function [y_k,niter] = ADMM(x,t, myepsilon)
  k=0;  
  [M,N] = size(x); 
  y_k = x; 
  d_k = zeros(M,N); 
  l_k = zeros(M,N); 
  lambda_down_k = zeros(M-1, N); 
  lambda_right_k = zeros(M,N-1); 
  d_down_k = zeros(M-1,N); 
  d_right_k = zeros(M,N-1); 

  shall_continue = true;
  while shall_continue == true
    k = k + 1;
    y_old = y_k;

        [d_down_kp1, d_right_kp1] = ...
            Update_D(lambda_down_k, lambda_right_k, y_k);

        y_k = Update_Y( y_k, ...
                        lambda_down_k, lambda_right_k, ...
                        d_down_kp1,   d_right_kp1, ...
                        x, t );

        [lambda_down_kp1, lambda_right_kp1] = ...
            Update_Lambda(lambda_down_k, lambda_right_k, ...
                          d_down_kp1,   d_right_kp1, ...
                          y_k);

        if norm(y_k(:) - y_old(:), 2) <= myepsilon
            shall_continue = false;
        end
      
        d_down_k      = d_down_kp1;
        d_right_k     = d_right_kp1;
        lambda_down_k  = lambda_down_kp1;
        lambda_right_k = lambda_right_kp1;
  end

  niter = k; 

end

