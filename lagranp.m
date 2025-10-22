function [coeffs, polyStr] = lagranp(x, y)
% LAGRANP Compute Lagrange polynomial coefficients
%   [coeffs, polyStr] = lagranp(x, y)
%   Inputs:
%       x - vector of x-data points
%       y - vector of corresponding y-data points
%   Outputs:
%       coeffs - vector of polynomial coefficients (highest degree first)
%       polyStr - optional string representation of the polynomial

n = length(x);
if length(y) ~= n
    error('Vectors x and y must be the same length.');
end

% Initialize polynomial coefficients to zero
coeffs = zeros(1, n);

% Loop over each Lagrange basis polynomial
for i = 1:n
    % Start with coefficient 1 for L_i(x)
    Li = 1;
    for j = 1:n
        if j ~= i
            % Multiply current Li by (x - xj)/(xi - xj)
            Li = conv(Li, [1, -x(j)]) / (x(i) - x(j));
        end
    end
    % Add contribution of y(i)*L_i(x) to total polynomial
    coeffs = coeffs + y(i)*Li;
end

% Optional: return polynomial as string (human-readable)
if nargout > 1
    polyStr = poly2str(coeffs, 'x');
end
end
