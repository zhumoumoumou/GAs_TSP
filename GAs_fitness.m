
function [best_individual, min_dist, fitness] = GAs_fitness(population,g_mat)

    [m, n] = size(population);
    population = [population, population(:,1)];
    
    path_length = zeros(m, 1);
    
    for i=1:n
        path_length = path_length + diag(g_mat(population(:,i), population(:,i+1)));
    end
    
    [min_dist, min_index] = min(path_length);
    best_individual = population(min_index,1:n);
    
    % fitness calculation
    fitness = 1 ./ path_length;
end

