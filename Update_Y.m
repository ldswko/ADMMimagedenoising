function [y_p1] = Update_Y(y,lambda_down_k,lambda_right_k,d_down_k,d_right_k,x,t)
[M,N] = size(x);

y_p1 = y;

numSweeps = 15;
    for sweep = 1:numSweeps
        for i = 1:M
            for j = 1:N
                nb = 0;

                if i>1
                    y_im1_j = y_p1(i-1,j); nb = nb+1;
                else
                    y_im1_j = 0;
                end
                if i<M
                    y_ip1_j = y_p1(i+1,j); nb = nb+1;
                else
                    y_ip1_j = 0;
                end
                if j>1
                    y_i_jm1 = y_p1(i,j-1); nb = nb+1;
                else
                    y_i_jm1 = 0;
                end
                if j<N
                    y_i_jp1 = y_p1(i,j+1); nb = nb+1;
                else
                    y_i_jp1 = 0;
                end

                if j<N
                    dr_i_j   = d_right_k(i,j);
                else
                    dr_i_j = 0;
                end
                if i<M
                    dd_i_j   = d_down_k(i,j);
                else
                    dd_i_j = 0;
                end
                if j>1
                    dr_i_jm1 = d_right_k(i,j-1);
                else
                    dr_i_jm1 = 0;
                end
                if i>1
                    dd_im1_j = d_down_k(i-1,j);
                else
                    dd_im1_j = 0;
                end

                if j<N
                    lr_i_j   = lambda_right_k(i,j);
                else
                    lr_i_j = 0;
                end
                if i<M
                    ld_i_j   = lambda_down_k(i,j);
                else
                    ld_i_j = 0;
                end
                if j>1
                    lr_i_jm1 = lambda_right_k(i,j-1);
                else
                    lr_i_jm1 = 0;
                end
                if i>1
                    ld_im1_j = lambda_down_k(i-1,j);
                else
                    ld_im1_j = 0;
                end

                tmp_y = y_im1_j + y_ip1_j + y_i_jm1 + y_i_jp1;
                tmp_d =  dr_i_jm1 - dr_i_j + dd_im1_j - dd_i_j;
                tmp_l =  lr_i_jm1 - lr_i_j + ld_im1_j - ld_i_j;

                numerator   = t*x(i,j) + tmp_y + (tmp_l + tmp_d);
                denominator = t + nb;
                y_p1(i,j)   = numerator / denominator;
            end
        end
    end
end