clear; clc;
A = readtable("matlab_part2_1991.csv");
save('matlab_part2.mat', 'A')
%%
%loading data
clc;
load ("matlab_part2.mat")
%paremeters
%%
start_yr = 1970;
end_yr = 1990;


%individual stock var
stock_symbols_refrences = A{:,3};

individual_stock_return = A{:,5};
individual_stock_market_cap= A{:,4};
stock_year_data = A{:,1};
stock_month_data = A{:,2};
post_ranking_beta = A{:,18};
size_average = A{:,19}; %check!!!


% Market var
market_reutrns = A{:,7};
risk_free = A{:,6};

%%


% do we have the sort we want coming out of stata?????


counter=0;
betas_matrix_out_of_for = [];
size_matrix_out_of_for =[];
both_matrix_out_of_for =[];
output_avg =[];
real_output =[];
    for i =1:length(stock_symbols_refrences)-1
    current_stock = stock_symbols_refrences(i);
    next_stock =stock_symbols_refrences(i+1);

    if current_stock == next_stock
        
        counter = counter+1;
    else
        if counter >2
        beta = post_ranking_beta(i-counter:i);
        size = size_average(i-counter:i);
        cross_sectional = mean(individual_stock_return(i-counter:i)); 
        reg_size_i= regress(individual,size)';
        reg_beta_i = regress(individual,beta)';
        both_reg_i = regress(individual,[beta size])';
        betas_matrix_out_of_for = [betas_matrix_out_of_for reg_beta_i];
        size_matrix_out_of_for =  [size_matrix_out_of_for reg_size_i];
        both_matrix_out_of_for =  [both_matrix_out_of_for; both_reg_i];
        counter = 0;
        end 
    end

    end
%%
    both = mean(both_matrix_out_of_for)*100;
    fprintf("both cofficent on beta %4.5f percent and on size %4.5f\n",both(1),both(2))
    size_avg = mean(size_matrix_out_of_for)*100;
    fprintf("size only %4.3f percent\n",size_avg)
    beta_avg = mean(betas_matrix_out_of_for)*100;
    fprintf("beta only %4.3f percent\n",beta_avg)
    size_std= std( size_matrix_out_of_for ) / sqrt( length( 650 ));
    fprintf("size only STD%4.3f percent\n",size_std)
    
    beta_std= std( betas_matrix_out_of_for ) / sqrt( length( 650 ));
    fprintf("beta only STD%4.3f percent\n",beta_std)
    

    %%
    for 
    
    
    
    
    
    
    