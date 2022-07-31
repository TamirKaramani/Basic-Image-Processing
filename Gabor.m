function EstAngle=Gabor(Blurred)
%%This function estimates the motion blur parameters using the Gabor transform.  
%apply fft on blurred image
FFT = log(abs(fftshift(fft2(Blurred))) + 1);
%apply gabor filter on fft using gabor array, consist of wavelength of 2*pi/k and orientation vector of angles between 0 to 180 
k = 1.75;
Mag = imgaborfilt(FFT,gabor(2*pi/k,0:180));
%find max norm of magnitued response of gabor filter in order to find the compatible estimated angle
Norm = zeros(1,181);
for i=1:181
    Norm(i) = norm(Mag(:,:,i));
end
R = find(Norm == max(Norm));
EstAngle = R-1;
%plot results
Y = circshift(Norm,-1);
figure('Name','Norm of Magnitueds Gabor Filter of FFT','NumberTitle','off'); plot(Y);xlim([0 180]);xlabel('\theta');ylabel('Norm of Magnitudes');
Indx = find(Y == max(Y));
dt=datatip(plot(Y),Indx,max(Y));
dt.Location='southeast';
sgtitle("Estimated angle using Gabor is "+Indx);
end