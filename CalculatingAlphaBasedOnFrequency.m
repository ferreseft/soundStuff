% Determine absorption coefficients with varying frequency

% Temperature and depth are both constant in this case.
depth = 1.5; % Assuming a depth of 1.5 km.
TempC = randi([0,4]); % Temperature at depth of 1.5 km is 0-4 degrees C.

% Set frequency ranges in Hertz(Hz)
f = 1:500; % Choosing a very low frequency range of 1-300 Hz

% Pre-allocate space for the frequency array to make code more efficient.
alpha = zeros(1,size(f,2));

% Calculate the absorption coefficient based on the various frequency
% values.
for ( i = 1:size(f,2) )
alpha= 4.9e-4*(f.^2)*(exp(-1*((TempC/27)+(depth/17))));
end