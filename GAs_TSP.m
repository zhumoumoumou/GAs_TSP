clear
clc

%Max Generation Number
max_gen = 200;
city_num = 10;
population_size = 100;
P_crossover = 0.4;
P_mutation = 0.2;  

% Use OX crossover stratagy, or PBX
OX = 1;

cord = rand(2, city_num);
cord_x = cord(1, :);
cord_y = cord(2, :);

% Adjacency matrix
g_mat = sqrt((cord_x - cord_x').^2 + (cord_y - cord_y').^2);


population = zeros(population_size,city_num);
for i=1:population_size
    population(i,:) = randperm(city_num); 
end

min_dist_by_gen = zeros(max_gen,1);
individuals = zeros(max_gen,city_num);
for gen=1:max_gen
    
    [reserved,~,fitness] = GAs_fitness(population,g_mat);

    population = GAs_selection(population,fitness);
    
    if (exist('OX', 'var') && OX == 1)
        population = GAs_crossover_OX(population,P_crossover);
    else
        population = GAs_crossover_PBX(population,P_crossover);
    end

    population = GAs_mutation(population,P_mutation);
    
    % Make sure the population include the best one
    % For better convergence performance
    population(randi(population_size), :) = reserved;
    
    % record data
    [individuals(gen,:),min_dist_by_gen(gen),~] = GAs_fitness(population,g_mat);
end


[min_dist, route_index] = min(min_dist_by_gen);
best_individual = individuals(route_index,:);

figure(1)
plot(min_dist_by_gen)
title('路径总距离变化趋势图');
ylabel('路径总距离');
xlabel('代际数目');

figure(2)
plot(cord_x, cord_y, '*', 'MarkerSize', 10);
title(['最短回路，长度=' num2str(min_dist)])
xlabel('x');
ylabel('y');
axis equal
hold on

best_cityx = cord_x(best_individual);
best_cityy = cord_y(best_individual);

best_cityx(end+1) = cord_x(best_individual(1));
best_cityy(end+1) = cord_y(best_individual(1));
plot(best_cityx,best_cityy, 'red');
legend('城市', '路径');
grid on
hold off

