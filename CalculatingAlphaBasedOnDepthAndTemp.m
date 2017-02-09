close all;
clc;

% Determine absorption coefficients with varying depth and temperature

% Frequency is a constant in this case.
f = 300; % Frequency of the signal in Hertz (Hz)

% Set temperature ranges for varying depths (degrees C)
% Temperature based on a rough estimate based upon
% research found on the internet.
T_0_to_500m = [17,22]; % Temp for range of 0 to 0.5 km
T_500_to_750m = [10,15]; % Temp for range of 0.5 to 0.75 km
T_750_to_1000m = [4,9]; % Temp for range of 0.75 to 1 km
T_1000_to_end = [0,4]; % Temp for range of 1 km to ocean floor

% Set a range for the depth.
depth = [0:0.01:2.99]; % Chose a range of 0-2.5 km

% Pre-allocate space for the Temperature and absoprtion coefficient
% variables to make the program more efficient.
TempC = zeros(size(depth));
alpha = ones(size(depth));

% Create an array of various depth/temperature pairs
for ( i = 1:size(depth,2) )
    if ( depth(i) <= 0.5 )
        TempC = randi(T_0_to_500m);
    elseif ( depth(i) > 0.5 && depth(i) <= 0.75 )
        TempC = randi(T_500_to_750m);
    elseif ( depth(i) > 0.75 && depth(i) <= 1 )
        TempC = randi(T_750_to_1000m);
    else 
        TempC = randi(T_1000_to_end);
    end
     
% Calculate the absorption coefficient in decibels per kilometer (dB/km).
alpha(i)= 4.9e-4*(f^2)*(exp(-1*((TempC/27)+(depth(i)/17))));
end