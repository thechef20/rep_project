%Matthew Chisotlin
% Last Edited 2/24/21
%% Setup Section
% setting dataset for part 1 (please don't run unless you have
% data_with_with_market_attached.csv)
% MARET is market returns without dividendes (this while projected is w/o
% div)
clear; clc;
A = readtable("data_with_with_market_attached.csv");
save('data_with_with_market_attached.mat', 'A')
%%
%loading data
clc;
load ("data_with_with_market_attached.mat")
%paremeters
n_upper = 60; %max number of months
n_lower = 24; %min number of months
%%

%individual stock var
stock_symbols_refrences = A{:,1};
individual_stock_return = A{:,4};
individual_stock_market_cap= A{:,5};
stock_year_data = A{:,6};
stock_month_data = A{:,7};
hml = A{:,16};
smb = A{:,17};
rmw = A{:,18};
cma = A{:,14};


% Market var
market_reutrns = A{:,11};
risk_free = A{:,15};

%% Actual Code 

upper_counter =0;
lower_counter = 0;
pre_rank_matrix = nan(length(stock_symbols_refrences),12); %if I wanted individual beta we would extend this to 7
for i =1:length(stock_symbols_refrences)-1
    current_stock = stock_symbols_refrences(i);
    next_stock =stock_symbols_refrences(i+1);
    r_and_m_name = [stock_year_data(i)  stock_month_data(i) current_stock individual_stock_market_cap(i) individual_stock_return(i) risk_free(i) market_reutrns(i) cma(i) hml(i) smb(i) rmw(i)];%year and month and name
    
    if current_stock == next_stock
        if lower_counter-1 >= n_lower
            if upper_counter > n_upper
                upper_counter = n_upper;
            end
            market = [market_reutrns(i-n_lower-upper_counter:i) market_reutrns(1+i-n_lower-upper_counter:i+1)];
            individual = [individual_stock_return(i-n_lower-upper_counter:i)]; 
            beta = regress(individual , market)';
            sum_o_beta = sum(beta);
            pre_rank_matrix(i,:)= [r_and_m_name sum_o_beta];
            upper_counter = upper_counter + 1; 
        else
            pre_rank_matrix(i,:)= [r_and_m_name NaN];
        end
        
        lower_counter = lower_counter+1;
    else
        pre_rank_matrix(i,:)= [r_and_m_name NaN];
        upper_counter =0;
        lower_counter = 0;
    end
    
    
    
end 
%%
pre_rank_table = array2table(pre_rank_matrix,'VariableNames',{'annual','mmonth','kypermno','mtcap','mretx','risk_free','maret','cma','hml','smb','rmw','pre_ranked_beta'});%we changed myear to annual because of the porflio data uses annual
writetable( pre_rank_table, 'pre_rank_table.csv')

%% Post Ranking Betas

    if current_stock == next_stock
        for yr = start_yr:1:end_yr
            for month  = 1:1:12
                market = [market_reutrns(i-n_lower-upper_counter:i)];%this line needs to be changed, do we still need the coutner?
                post_ranking_beta_reg = [post_ranking_beta(i-n_lower-upper_counter:i)]; 
                lambda = regress(individual , market)';
            end
        end
    end 
    
