function exp_vector = map_exponential(uni_vector, lambda)
 
check = (uni_vector >= 0) & (uni_vector < 1); 

for i = 1:length(check)
    if(check(i) == 1)
        check_2(i) = uni_vector(i); 
    end
    if(check(i) == 0)
        disp('This data point has been skipped'); 
    end
    
end

for j = 1:length(check_2)
    exp_vector(j) = (-1/lambda) * log(1 - check_2(j)); 
end

end