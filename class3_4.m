clc,clear;
SNR=1:10;
N=1000000;

p=0;P=0;
Num=zeros(1,10);
for i=1:10
    sigma_n=sqrt(1/i);
    x_info=randi([0,1],1,N); 
        y_info=randi([0,1],1,N);
        s=(2*x_info-1)+1i*(2*y_info-1); 
        pn = 1/(10^(SNR(i)/10));
        n = sigma_n*(randn(1,N)+1i*randn(1,N));
        e = s+n;
    e(e>=0)=1;
    e(e<0)=-1;
    x=xor((e+1)/2,(real(s)+1)/2);
    num=sum(x);
    Num(i+1)=num;
    pe=num/length(s)
    Pe=1/2*erfc(sqrt((10.^(i/10))/2))
    p(1,i+1)=pe
    P(1,i+1)=Pe
end
i=0:10;
figure 
% semilogy(i,10*log(p),'b',i,10*log(P),'r');
semilogy(i,P,'r');
hold on
plot(i,p,'o');
title('系带传输误码率')
legend('理论结果','仿真结果')
grid on

