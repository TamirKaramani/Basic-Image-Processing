function AmplitudeAndPhaseSwap(In1,In2)
%%This function receives two grayscale images, calculates their fft and builds 
%%new images composed of each image amplitude with the other's phase.
%read original images and convert to type double  
Image1 = im2double(imread(In1));
Image2 = im2double(imread(In2));
%find dimensions and extent of the FFT
[R1, C1] = size(Image1);
[R2, C2] = size(Image2);
R = max(R1, R2);
C = max(C1, C2);
%apply FFT on each image
Image1_FFT = fft2(Image1, R, C);
Image2_FFT = fft2(Image2, R, C);
%extract the magnitudes and phase responses
M1 = abs(Image1_FFT);
M2 = abs(Image2_FFT);
P1 = angle(Image1_FFT);
P2 = angle(Image2_FFT);
% reconstruct new images by swapping the phases responses
Out1 = M1 .* exp(1i*P2);
Out2 = M2 .* exp(1i*P1);
%apply inverse fft on new images
Out1 = abs(ifft2(Out1));
Out2 = abs(ifft2(Out2));
%plot results
close all;
figure('Name','Amplitude And Phase Swap','NumberTitle','off');
sgtitle("Amplitude And Phase Swap");
temp1 = [0,strfind(In1,'\')];
In1=In1(temp1(end)+1:strlength(In1)-4);
temp2 = [0,strfind(In2,'\')];
In2=In2(temp2(end)+1:strlength(In2)-4);
subplot(2,2,1),imshow(Image1),title(In1);
subplot(2,2,2),imshow(Image2),title(In2);
subplot(2,2,3),imshow(Out1(1:R2,1:C2)),title("| A | of "+In1+" and \phi of "+In2);
subplot(2,2,4),imshow(Out2(1:R1,1:C1)),title("| A | of "+In2+" and \phi of "+In1);
end