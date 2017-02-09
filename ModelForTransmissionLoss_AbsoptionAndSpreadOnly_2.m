% This script uses Source Level and Transmission Losses to determine the
% distance an acoustic signal would be able to propagate through water at a
% depth, d, of 3000 feet, temperature at 4 degrees C, and signal frequency
% set to be 60 Hz.

% Assumptions Made for this Model:
% The assumptions for this model are based on readings found in the book
% "Principles of Underwater Acoustics" 3rd Ed.  Most, but not all
% assumptions are labeled below.  Of those not labeled, depth is assumed to
% be at 3000 feet, based on where some of the data in the book was
% meaasured, and water temperature is 4 degrees celcius, or 39 degrees
% fahrenheit.  This model also assumes that we are trapping the acoustic
% signal in a sound channel in the sea and our frequency is 100 Hz.
clear all;
close all;
clc;

P = 300; % Assume the source acoustic power is 600 Watts ( Assumed Value ).
Nm = 0; % Initialize the amount of nautical miles to test over
SL = 1; % Initialize the variable for source level so we may enter the while loop
TL = 0; % Initialize the variable for transmission loss so we may enter the while loop
Io = P/(4*pi); % Inital intensity of the signal assuming the acoustic power of the source.
i = 0;
while ( SL > TL )
i = i + 1;
Nm = Nm + 1; % Add one to the number of miles until SL is lower than TL ( indicating the max range )
r = (2025*Nm); % Describe the intensity over a range of 2025 yards (1 nautical mile)

Pe = 500; % Amount of electrical power (Watts) put into the projector ( Assumed value )
E = 0.45; % The efficiency of the projector ( Assumed value )
DIt = 10; % The transmitting directivity index of the projector ( Assumed value )

% Note: All above assumed values were made based upon values in the book
% "Principlese of Underwater Sound", Section 4.1, pg. 76.

SL = 171.5 + (10*log10(Pe)) + (10*log10(E)) + DIt;

TLs = 10*log10(r); % Calculate the transmission loss due to cylindrical spreading
Alpha = 6.7e-11; % Absorption coefficient based the medium (seawater) (dB/kyd) ( Assumed Value )
                 % "Principlese of Underwater Sound", Section 5.3, pg. 104.

f = 60; % Operating frequency in Hz.
f = f/1000; % Converts the frequency to kHz.
Alphaf = ((0.1*(f^2))/(1+(f^2))) + ((40*(f^2))/(4100+(f^2))) + (2.75e-4*(f^2)) + 0.003;
% Absorption coefficient (dB/kyd) based on the frequency of the signal (in kHz)

% Note: At very low frequencies (<5kHz)(as in our aplication) the absorption
% coefficient based on frequency is always around 0.003, "Principlese of Underwater Sound", Section 5.3, pg. 107.

d = 3000; % depth in feet
d = d/3; % Convert depth to yards.
ao = 0.02; % ao is absorption coefficient at surface (depth = 0) and is assumed based on
            % "Principlese of Underwater Sound", Section 5.3, pg. 109, fig. 5.5.
Alphad = ao*(1-(1.93e-5*d)); % Absorption as a function of depth. (dB/kyd)

Iw = P/(4*pi*(r^2)); % Intensity of the sound as a function of range in W/m^2
Idb = 10*log10(Iw/1e-12); % Intensity of the sound as a function of range in dB
Alphai = ((10*log10(Io))-(10*log10(Idb))); % Absorption as a function of intensity (dB/kyd)

% Change all coefficients of absorption to dB/yd.
Alpha = Alpha/1000;
Alphaf = Alphaf/1000;
Alphad = Alphad/1000;
Alphai = Alphai/1000;

TL(i)= TLs + ((Alpha + Alphaf + Alphad + Alphai)*(r));
SLplot(i) = SL - TL(i);
end
Nm = 1:Nm;
SL = num2str(max(SL),'%.1f');
fprintf('Given the assumptions and calculations of Transmission Loss, the\n')
fprintf('maximum distance the sound wave could travel is %d nautical miles based on a Source Level of\n',max(Nm))
fprintf('%s dB.\n',SL)

figure(1);
clf;
semilogy(Nm,TL,'--')
hold on;
semilogy(Nm,abs(SLplot),'--r')
xlabel('Distance (Nautical Miles)');
ylabel('Signal Power (dB)');
title('Source Level and Transmission Loss vs. Distance');
