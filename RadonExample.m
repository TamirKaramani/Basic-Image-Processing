function RadonExample()
%%this function creates binary images, then calculates it's radon transform.
%create binary image composed of 4 white lines on black background
I = zeros(313);
[m,n] = size(I);
for i = 1:m
    for j = 1:n
        I(j,40) = 255;
        I(j,80) = 255;
        I(j,124) = 255;
        I(j,150) = 255;
    end
end
%apply radon transform
R=radon(I);
%plot results
figure('Name','Radon of 4 lines vs Radon of 4 dots','NumberTitle','off');
subplot(2,2,1),imagesc(I),title("4 Lines");
subplot(2,2,3),imagesc(R),title("Radon Transform of 4 lines");
%create binary image compose of 4 white dots on black background
I = zeros(313);
I(40,40) = 255;
I(80,80) = 255;
I(124,124) = 255;
I(150,150) = 255;
%apply radon transform
R = radon(I);
%plot results
subplot(2,2,2),imagesc(I),title("4 dots");
subplot(2,2,4),imagesc(R),title("Radon Transform of 4 dots");
end