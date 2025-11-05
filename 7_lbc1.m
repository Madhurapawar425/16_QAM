

clc
clear all
close all

%k = 3; n = 2^m-1; m = n-k;
%[H, G] = hammgen(k); 
k=input('Enter no of message bits k');
n=input('Enter no of code bits n');
G=zeros(k,n);
G(:,1:k)=eye(k);
disp('Enter Parity matrix k x n-k');
for i=1:k
    for j=1:n-k
        G(i,j+k)=input('');
    end
end
d=0:2^k-1;
db=dec2bin(d);
for i=1:2^k
    for j=1:k
        dbb(i,j)=str2num(db(i,j));
    end
end
c(1:2^k,:)=rem(dbb(1:2^k,:)*G,2);
wt=sum(c,2);
H=[G(:,k+1:n)' eye(n-k)];
trt = syndtable(H); 
disp('Enter recd vector');
for i=1:n
    recd(1,i)=input('');
end
syndrome = rem(recd * H',2);
syndrome_de = bi2de(syndrome,'left-msb'); 
disp(['Syndrome = ',num2str(syndrome_de),...
    ' (decimal), ',num2str(syndrome),' (binary)']);
corrvect = trt(1+syndrome_de,:); 
correctedcode = rem(corrvect+recd,2);

