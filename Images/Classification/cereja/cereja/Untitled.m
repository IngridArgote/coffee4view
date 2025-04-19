
QdoT00Jd1g0Lclear all
clc

a=imread('41375052b59f3108fad5b6a1334294f5_L (1).jpg');
[P T Q]=size(a);
a = imresize(a, [P P]);




%% Espaço de cor LUX
U=zeros(P,P);
X=zeros(P,P);
M=256;
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);

R1=double(R+1);
G1=double(G+1);
B1=double(B+1);

L=(R1.^0.3)*(G1.^0.6)*(B1.^0.1)-1;


for i=1:P
    for j=1:P
        if R(i,j)<L(i,j)
            U(i,j)=(M/2)*(R1(i,j)/(L(i,j)+1));
        else
            U(i,j)=M-(M/2)*((L(i,j)+1)/(R(i,j)+1));
        end
    end
end

for i=1:P
    for j=1:P
        if B(j,i)<L(j,i)
           X(j,i)=(M/2)*(B1(j,i)/(L(j,i)+1));
        else
           X(j,i)=M-(M/2)*((L(j,i)+1)/(B1(j,i)));
        end
    end
end

Lm=max(max(L));
Ln=uint8((L*255)/Lm);

Um=max(max(U));
Un=uint8((U*255)/Um);

Xm=max(max(X));
Xn=uint8((X*255)/Xm);
F=Un-Xn;

[X,Y] = meshgrid(1:P,1:P);
Z = Un;
surf(X,Y,Z)

figure
subplot(2,4,1)
imshow(a)
subplot(2,4,2)
imshow(Un)
subplot(2,4,3)
imshow(Xn)
subplot(2,4,4)
imshow(F)
subplot(2,4,5)
imhist(R)
subplot(2,4,6)
imhist(Un)
subplot(2,4,7)
imhist(Xn)
subplot(2,4,8)
imhist(F)


%% Espaço de cor YCrCb

YCBCR = rgb2ycbcr(a);

Y=a(:,:,1);
Cr=a(:,:,2);
Cb=a(:,:,3);


G=F-Cr;
Z=G+Y;




L2=(double(F).^0.3)*(double(Cr).^0.6)*(double(Y).^0.1)-1;

l2m=max(max(L2));
L2=uint8((L2*255)/l2m);

for i=1:P
    for j=1:P
        if F(i,j)<L2(i,j)
            Cro(i,j)=(1/2)*(Cr(i,j)/(L2(i,j)+1));
        else
            Cro(i,j)=1-(1/2)*((L2(i,j)+1)/(Cr(i,j)+1));
        end
    end
end



% subplot(2,4,5)
% imshow(a)
% subplot(2,4,6)
% imshow(Y)
% subplot(2,4,7)
% imshow(Cr)
% subplot(2,4,8)
% imshow(G)
% vvvv=im2bw(G,0.01);
% figure
% imshow(vvvv)

