
function [population_new] = GAs_crossover_OX(population, P_crossover)

    % OX
     [m, n] = size(population);
    population_new = population;
    
    % Random pairwise matching of individuals to be crossoverd
    cross_list = find(rand(m,1) < P_crossover);
    cross_list = cross_list(randperm(length(cross_list)));
    cross_list = reshape(cross_list(1:(2*floor(end/2))), [], 2);
    
    cross_pair_n = size(cross_list, 1);
    
    % crossover boundary
    boundary = sort(randi(n,[cross_pair_n, 2]), 2);
    
    for i=1:cross_pair_n
        
        parent_index = cross_list(i, :);
        parent = population(parent_index,:);
        
        points = boundary(i, 1):boundary(i, 2);
        
        c_points = setdiff(1:n, points);
        
        children = zeros(2, n);
        
        children(:, points) = parent(:, points);
        
        fill_posi = all( parent(2, :)~=parent(1, points)', 1);
        
        children(1, c_points) = parent(2, fill_posi);
        
        fill_posi = all( parent(1, :)~=parent(2, points)', 1);
        children(2, c_points) = parent(1, fill_posi);
        
        population_new(parent_index,:) = children;
    end
end


