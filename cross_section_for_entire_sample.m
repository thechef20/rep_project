% Date created 3/5/21
%Matt Chisto
clear; clc;
A = readtable("matlab_returning_for_crosssectional.csv");
save('cross_sectional_for_entire.mat', 'A')
%%
%loading data
clc;
load("cross_sectional_for_entire.mat")
%paremeters


%individual stock var
stock_symbols_refrences = A{:,3};

individual_stock_return = A{:,5};
individual_stock_market_cap= A{:,4};
stock_year_data = A{:,1};
stock_month_data = A{:,2};
post_ranking_beta = A{:,22};
size_average = A{:,23}; 
time_index = A{:,24};

% Market var
market_reutrns = A{:,7};
risk_free = A{:,6};
%%


time_length = max(time_index);
out_for_reg_3 =[];
out_for_reg_2 =[];
out_for_reg_1 =[];
counter = 0;
for t = 1:1:time_length
    index_values = find(time_index ==t);
    reg_1 = regress(individual_stock_return(index_values),size_average(index_values)); %just for size
    reg_2 = regress(individual_stock_return(index_values),post_ranking_beta(index_values)); %just for beta
    reg_3 = regress(individual_stock_return(index_values),[ size_average(index_values) post_ranking_beta(index_values)]); %size then beta
    
    out_for_reg_1 = [out_for_reg_1 reg_1];
    out_for_reg_2 = [out_for_reg_2 reg_2];
    out_for_reg_3 = [out_for_reg_3 reg_3];
end   
%% finding averages and STD

size_avg = mean(out_for_reg_1')*100
size_std= std(out_for_reg_1')./sqrt(time_length)
%./length


beta_avg = mean(out_for_reg_2')*100
beta_std = std(out_for_reg_2')./sqrt(time_length)

both_avg = mean(out_for_reg_3')*100
both_std = std(out_for_reg_3')./sqrt(time_length)




