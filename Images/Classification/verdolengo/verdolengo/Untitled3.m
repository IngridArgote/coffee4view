% A=imread('amostra1.jpg');
% B=rgb2lab(A);
% C=B(:,:,3);
% D=B(:,:,2);
% E=zeros(50);
% for i=1:50
%     for j=1:50
%         if C(i,j)<=30
%            E(i,j)=0;
%         else
%             E(i,j)=1;
%         end
%         F(i,j)=C(i,j)*E(i,j);
%     end
% end
           


A=imread('C:\Users\Rover\OneDrive\caf\graos\passa\amostra1.jpg');
B=rgb2lab(A);
C=B(:,:,3);
D=B(:,:,1);
E=zeros(50);
for i=1:50
    for j=1:50
        if C(i,j)<=0
           E(i,j)=0;
        else
            E(i,j)=1;
        end
        G(i,j)=C(i,j)*E(i,j);
    end
end
subplot(1,2,1)
imshow(A)
subplot(1,2,2)
imshow(G)

% A=imread('C:\Users\Rover\OneDrive\caf\graos\passa\amostra1.jpg');
% B=rgb2lab(A);
% C=B(:,:,3);
% D=B(:,:,2);
% E=zeros(50);
% for i=1:50
%     for j=1:50
%         if C(i,j)<=30
%            E(i,j)=0;
%         else
%             E(i,j)=1;
%         end
%         H(i,j)=C(i,j)*E(i,j);
%     end
% end
% 
% A=imread('C:\Users\Rover\OneDrive\caf\graos\verde\amostra1.jpg');
% B=rgb2lab(A);
% C=B(:,:,3);
% D=B(:,:,2);
% E=zeros(50);
% for i=1:50
%     for j=1:50
%         if C(i,j)<=30
%            E(i,j)=0;
%         else
%             E(i,j)=1;
%         end
%         I(i,j)=C(i,j)*E(i,j);
%     end
% end
% % subplot(1,2,1)
% % imshow(A)
% % subplot(1,2,2)
% imshow(E)