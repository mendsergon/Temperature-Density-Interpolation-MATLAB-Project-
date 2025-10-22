% Basic Data Points
T = [200, 250, 300, 350, 400, 450];      % Temperatures in Kelvin
rho = [1.708, 1.367, 1.139, 0.967, 0.854, 0.759]; % Corresponding densities in kg/m^3
T_target = 330; % Target temperature for interpolation
T_extrap = 600; % Temperature for extrapolation



% Lagrange Interpolation
fprintf('Lagrange Interpolation:\n'); % Print header for Lagrange interpolation results
subset1 = [250, 300]; rho1 = [1.367, 1.139]; % Select points for 1st degree polynomial (p1)
subset3 = [250, 300, 350, 400]; rho3 = [1.367, 1.139, 0.967, 0.854]; % Select points for 3rd degree polynomial (p3)
subset5 = T; rho5 = rho; % Use all data points for 5th degree polynomial (p5)

[l1, ~] = lagranp(subset1, rho1); % Calculate Lagrange coefficients for degree 1
rho_L1 = polyval(l1, T_target); % Evaluate p1(330) using the Lagrange polynomial for degree 1

[l3, ~] = lagranp(subset3, rho3); % Calculate Lagrange coefficients for degree 3
rho_L3 = polyval(l3, T_target); % Evaluate p3(330) using the Lagrange polynomial for degree 3

[l5, ~] = lagranp(subset5, rho5); % Calculate Lagrange coefficients for degree 5
rho_L5 = polyval(l5, T_target); % Evaluate p5(330) using the Lagrange polynomial for degree 5

fprintf('p1(330) = %.4f, p3(330) = %.4f, p5(330) = %.4f\n', rho_L1, rho_L3, rho_L5); % Print densities for each polynomial



% Polynomial Fitting Interpolation
fprintf('\nPolynomial Fitting:\n'); % Print header for polynomial fitting results

% The following code was written to get rid of this warning:
% Warning: Polynomial is badly conditioned. Add points with distinct X values,
% reduce the degree of the polynomial, or try centering and scaling as
% described in HELP POLYFIT.

% The code scales the temperature data by adjusting it to have a mean of zero 
% and a standard deviation of one. This makes it easier to fit polynomials
% accurately and reduces warnings. The target temperature is also adjusted
% in the same way for consistent results.

% Scale the data for better numerical stability
mean_T = mean(T); % Calculate mean of the temperatures
std_T = std(T);   % Calculate standard deviation of the temperatures

% Scale the temperature data
T_scaled = (T - mean_T) / std_T; % Standardized temperatures
subset1_scaled = (subset1 - mean_T) / std_T; % Scale subset1
subset3_scaled = (subset3 - mean_T) / std_T; % Scale subset3
subset5_scaled = (subset5 - mean_T) / std_T; % Scale subset5
T_target_scaled = (T_target - mean_T) / std_T; % Scale the target temperature

% Fit polynomials to the scaled data
p1 = polyfit(subset1_scaled, rho1, 1); % Fit a 1st degree polynomial to scaled data for p1
p3 = polyfit(subset3_scaled, rho3, 3); % Fit a 3rd degree polynomial to scaled data for p3
p5 = polyfit(subset5_scaled, rho5, 4); % Fit a 4th degree polynomial to scaled data for p5

% Evaluate the polynomials at the scaled target temperature
rho_P1 = polyval(p1, T_target_scaled); % Evaluate p1(330) using the fitted polynomial for degree 1
rho_P3 = polyval(p3, T_target_scaled); % Evaluate p3(330) using the fitted polynomial for degree 3
rho_P5 = polyval(p5, T_target_scaled); % Evaluate p5(330) using the fitted polynomial for degree 4

% Print the fitted densities at T = 330
fprintf('p1(330) = %.4f, p3(330) = %.4f, p5(330) = %.4f\n', rho_P1, rho_P3, rho_P5); % Print fitted densities



% Cubic Spline Interpolation
fprintf('\nCubic Spline Interpolation:\n'); % Print header for cubic spline interpolation
rho_S = spline(T, rho, T_target); % Calculate density at 330K using cubic spline interpolation

fprintf('Spline(330) = %.4f\n', rho_S); % Print the cubic spline interpolation result



% Extrapolation to T = 600 using Spline
rho_extrap = spline(T, rho, T_extrap); % Extrapolate density at 600K using cubic spline interpolation

fprintf('\nExtrapolated Density at T = 600K using Spline = %.4f\n', rho_extrap); % Print the extrapolated density result



% Plot Results
figure; % Create a new figure for plotting
hold on; % Keep the current plot to add more data
plot(T, rho, 'o', 'DisplayName', 'Data Points'); % Plot original data points as circles
plot(T_target, rho_L5, 'r*', 'DisplayName', 'Lagrange (p5)'); % Plot Lagrange result for p5 as red star
plot(T_target, rho_P5, 'g*', 'DisplayName', 'Polyfit (p5)'); % Plot polynomial fit result for p5 as green star
plot(T, spline(T, rho, T), 'b-', 'DisplayName', 'Spline'); % Plot cubic spline interpolation curve in blue
legend; % Add a legend to the plot
xlabel('Temperature (K)'); % Label the x-axis
ylabel('Density (kg/m^3)'); % Label the y-axis
title('Interpolation Methods Comparison'); % Set title for the plot
hold off; % Release the hold on the plot



