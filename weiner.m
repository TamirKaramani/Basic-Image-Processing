function weiner(Original,Blurred,PSF,EstPSF)
%%this function uses the weiner deconvolution algorithm to restore a motion blurred image
%NSR value calculation is based on noise variance estimation, and original image variance. 
NoiseVar = 0.0001;
SignalVar = var(Original(:));
NSR = NoiseVar / SignalVar;
%apply weiner to blurred images
RestWeiner1 = deconvwnr(Blurred,fspecial('motion',PSF(1),PSF(2)),NSR);
RestWeiner2 = deconvwnr(Blurred,fspecial('motion',EstPSF(1),EstPSF(2)),NSR);
%plot results
figure('Name','Weiner Restoration','NumberTitle','off');
subplot(2,2,1),imshow(Original);title("Original Image");
subplot(2,2,2),imshow(Blurred);title("Motion Blur Filter PSF\{L="+PSF(1)+" \theta="+PSF(2)+"\}");
subplot(2,2,3),imshow(RestWeiner1,[]);title("Restored Original PSF\{L="+PSF(1)+" \theta="+PSF(2)+"\}");
subplot(2,2,4),imshow(RestWeiner2,[]);title("Restored Estimated PSF\{L="+EstPSF(1)+" \theta="+EstPSF(2)+"\}");
end