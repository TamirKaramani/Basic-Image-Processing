function [Original,Blurred] = motionblur(I,L,theta,~)
%%this function recieves the PSF parameters of the desired
%%motion blur and apply them on the input image.
%read original image and convert to type double
Original = im2double(imread(I));
%apply motion blur filter Length=L angle=theta
Blurred = imfilter(Original,fspecial('motion',L,theta), 'conv', 'circular');
%controls wether to plot the result or not
if nargin<4
%apply fft on original image
FFT = fft2(Original);
%apply fft on blurred image
FFTBlur = fft2(Blurred);
%plot results
figure('Name','Motion Blurr','NumberTitle','off');
subplot(2,2,1),imshow(Original),title("Original Image");
subplot(2,2,2),imshow(Blurred),title("Blurred Image");
subplot(2,2,3),imshow(log(abs(fftshift(FFT))+1),[]),title("FFT of Original Image");
subplot(2,2,4),imshow(log(abs(fftshift(FFTBlur))+1),[]),title("FFT of Blurred Image");
sgtitle("motion blur filter\{L="+L+" \theta="+theta+"\}");
end
end


