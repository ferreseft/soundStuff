% This script uses a range to determine the maximum allowable transmission
% loss of a specific acoustic signal with power 'P'.

% Assumptions Made for this Model
% 1) Power of acoustic signal (Are we actually able to use a signal of such
%       power?)
% 2) Directivity index is 0 dB (sound propagates parallel to water surface)
% 3) The receiver is as ideal as possible
% 4) No other loss occurs during transmission
clear all;
close all;
clc;

P = 600; % Assume the source acoustic power is 1000 Watts
r = 1:(1852*2); % Describe the intensity over a range of 1852 meters (1 nautical mile)
Io = P/(4*pi);  % Setting the initial intensity for reference at a point 1 meter from source
                % Note: Reason for choosing this distance for reference was
                % based on information read in various books.  It seems
                % standard to use this distance as a reference point.

Iw = P./(4*pi*(r.^2)); % Intensity of the sound as a function of range in W/m^2
Idb = 10*log10(Iw/1e-12); % Intensity of the sound as a function of range in dB

SL = 171.5 + (10*log10(P)); % Assuming that the sound is propagated
                            % parallel with the surface and therefore
                            % the directivity index is 0 dB.

TLs = 20*log10(r); % Calculate the transmission loss due to spreading
TLa = -1*((10*log10(Io))-(10*log10(Idb))); % Transmission loss due to absorption from the medium (dB/km)
                                           % Note: the -1 is to have the
                                           % transmission loss act as a
                                           % positive value for total
                                           % transmission.
TL = (TLa*1e-3) + TLs; % Calculate the total transmission loss (dB)
                       % Note:  the 1e-3 is to change from km to meters for
                       % TLa                       
fprintf('The most transmission loss we can endure is %d dB.\n',Idb(size(r,2)));
for ( i = 1:size(r,2) )
while ( TL(i) < Idb(size(r,2)) ) % Determine when the transmission loss is more than the sound intensity
    rmax = r(i); % Determine the max range in meters
    break;
end
end

rmaxNM = rmax/1852; % Calculate the max range in nautical miles

fprintf('This allows for a transmission up to %d meters or %d nautical miles.\n',rmax,rmaxNM);
figure(1);
clf;
semilogy(r,TL); % Plot the Transmission loss as a function of the range. (dB/meter)
hold on
semilogy(rmax,TL,'.r');
%% Begin to add the absorption based on frequency here to show how range will vary with frequency.
