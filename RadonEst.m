function [EstAngle,Len]=RadonEst(Blurred)
%%this function estimates the PSF parameters of an input blurred image.
%find dimentions of Blurred image
[~,N]=size(Blurred);
%apply hann filter to remove boundary artefacts
Hann = imfilter(Blurred,hann(3));
%apply fft on blurred image after hann filtering
FFT = log(abs(fftshift(fft2(Hann)))+1);
%apply radon transform on fft
Radon = radon(FFT);
%find estimated angle compatible to maximum of radon response
[~,col] = find(Radon == max(Radon(:)));
EstAngle = col-1;
%apply radon transform at estimated angle
RadonAtEstAngle = radon(FFT,EstAngle);
%fina all local minima and calculate value of mean of all distances between any 2 close minima points
Minima = islocalmin(RadonAtEstAngle);
LocationMinima = find(Minima == 1);
d = mean(diff(LocationMinima));
%calc estimated length
Len = round(N/d);
Y = circshift(max(Radon),-1);
figure('Name','Max Values Radon Transform of FFT','NumberTitle','off');plot(Y);xlim([0 180]);xlabel('\theta');ylabel('Magnitude');
Indx = find(Y == max(Y));
dt=datatip(plot(Y),Indx,max(Y));
dt.Location='southeast';
sgtitle("Estimated angle using Radon is "+Indx);
end