clc
clear all
close all
k=input('Enter no of message bits k');
n=input('Enter no of code bits n');
g = cyclpoly(n,k);
[H,G,k] = cyclgen(n,g)
%pol = cyclpoly(n,k,'all'); 
disp('Enter message vector');
for i=1:k
    m(1,i)=input('');
end
ccode = encode(m,n,k,'cyclic/fmt',g)
trt = syndtable(H); % Produce decoding table.
disp('Enter recd vector');
for i=1:n
    recd(1,i)=input('');
end
syndrome = rem(recd * H',2);
syndrome_de = bi2de(syndrome,'left-msb'); % Convert to decimal.
disp(['Syndrome = ',num2str(syndrome_de),...
    ' (decimal), ',num2str(syndrome),' (binary)']);
corrvect = trt(1+syndrome_de,:); % Correction vector
%Now compute the corrected codeword.
correctedcode = rem(corrvect+recd,2);