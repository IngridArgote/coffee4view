clear all
clc

A=imread('C:\Users\Rover\OneDrive\caf\graos\passa\amostra1.jpg');

for i=1:50
    for j=1:50
        if A(i,j)>=200
           A(i,j,:)=0;
        end
    end
end
R=A(:,:,1);
G=A(:,:,2);
B=A(:,:,3);
a=1;
for i=1:50
    for j=1:50
        if A(i,j,:)>0
            Entrada(a,:)=[R(i,j) G(i,j) B(i,j)];
            a=a+1;
        end
    end
end