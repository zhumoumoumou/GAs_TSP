function [population_new] = GAs_mutation(population, P_mutation)

    [m, n] = size(population);
    population_new = population;
    
    mutation_list = find(rand(m, 1) <= P_mutation);
    swap_index = randi(n, [2, length(mutation_list)]);
    
    for i=1:length(mutation_list)
        % swap
        temp = population_new(mutation_list(i),swap_index(1,i));
        population_new(mutation_list(i),swap_index(1,i)) = population_new(mutation_list(i),swap_index(2,i));
        population_new(mutation_list(i),swap_index(2,i)) = temp;
        
    end
        
end