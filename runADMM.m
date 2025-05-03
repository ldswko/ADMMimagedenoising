x = double(imread('ima-noisy.pgm'))/255; 
myepsilon=10^(-2);

for t=5:5:40
    idx = t/5;                                  
    [y_star, k_star(idx)] = ADMM(x, t, myepsilon);
    norm_star(idx) = norm(y_star(:), 2);
    
    if (t == 20)
        denoised = y_star;
        imshow(denoised);                       
        imwrite(denoised*255, 'denoised.pgm');   
    end 

disp(table((5:5:40)', k_star.', norm_star.', ...
    'VariableNames',{'t','kStar','normY'}))

end
