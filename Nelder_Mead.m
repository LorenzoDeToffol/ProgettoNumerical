function[] = Nelder_Mead(n_iter, N_vertex, x0, rho, chi, gamma, sigma)
%% Explaining the function inputs and outputs
% Input:
% - n_iter: scalar value that indicates the number of iteration of the model
% - N_vertex: scalar value that indicates the number of vertices of our simplex
% - x0: vector 1x2 of our starting points
% - rho: parameter for the Reflection phase
% - chi: parameter for the Expansione phase
% - gamma: parameter for the Contraction phase
% - sigma: parameter for the Shrinkage phase

% Output:
% - 
% - 


% Function to be used
func = @(x) x+1;

% Defining vertices of the Simplex
vertex = randi([1, 10], N_vertex + 1, 2);
vertex(1,:) = x0;

%% Tentativo ordinamento da testare
% Computing the values of the function in the vertices
values = func(vertex);

% Save the indices of the sorted values
[~, sortedIndices] = sort(values);

% Sorted matrix of vertices
vertex = vertex(sortedIndices, :);

% Iterating method
for i = 1:n_iter
    % Computing the centroid
    xbar = mean(vertex);
    %% 1: Reflection phase
    xR = xbar + rho*(xbar-vertex(end));
    if func(vertex(1,:)) <= func(xR) && func(xR) < func(vertex(end-1, :))
        vertex(end,:) = xR;
    %% 2: Expansion phase
    elseif func(xR) < func(vertex(1,:))
        xE = xbar + chi*(xR - xbar);
        
        if func(xE) < func(xR) 
           vertex(end,:) = xE;

        end
    %% 3: Contraction phase
    elseif func(xR) > func(vertex(end-1,:))
        if func(xR) > func(vertex(end,:))
            
            xC = xbar - gamma*(xbar - vertex(end, :));
        else 

            xC = xbar - gamma*(xbar - xR);
        end
    %% 4: Shrinkage phase
    if func(xC) < func(vertex(end, :)) 

        vertex(end,:) = xC;
    else
        vertex = vertex(1, :) + sigma*(vertex - vertex(1, :));
    end


    end
    

end

end
