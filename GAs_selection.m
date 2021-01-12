
function [population_new] = GAs_selection(population,fitness)

    [population_size, ~] = size(population);
    
    % Roulette Selection Method
    cum_fitness = cumsum(fitness);
    theshold = rand(1, population_size) * cum_fitness(end);
    [~, select_index] = max(theshold < cum_fitness);
    
    population_new = population(select_index,:);
end