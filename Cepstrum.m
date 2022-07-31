function [EstAngle,Len]=Cepstrum(Blurred)
%%this function uses the cepstrum technique to obtain the length and angle
%%of motion blurred images.
%the cepstrum formula based on the article
CP = fftshift(ifft2(log10(1 + abs(fft2(Blurred)))));
%find 2 global minima of cepstrum
[r,c] = find(CP == min(CP(:)));
[Maxr,Maxc] = find(CP == max(CP(:)));
%calculate estimated parameters of motion blurred image length and angle of motion
if length(r)==2&&length(c)==2
    Len=(sqrt((r(1)-r(2))^2+(c(1)-c(2))^2))/2;
    EstAngle=atan(abs(r(1)-r(2))/abs(c(1)-c(2)))*180/pi;
else
    Len=(sqrt((r(1)-Maxr)^2+(c(1)-Maxc)^2));
    EstAngle=atan(abs(r(1)-Maxr)/abs(c(1)-Maxc))*180/pi;
end
%plot cepstrum and results
figure('Name','Cepstrum','NumberTitle','off');
sgt=sgtitle("Cepstrum of blurred Image estimated parameters: length "+Len+", angle "+EstAngle);
sgt.FontSize = 10;
surf(CP,'FaceAlpha',0.5,'EdgeColor','none');
end
