clc;clear
N=100000;
s=randint(1,N)*2-1;
fs=20;t=0:(1/fs):N-(1/fs);
st=rectpulse(s,fs);
figure;
subplot(3,1,1);plot(t,st);axis([0,20,-2,2]);
xlabel('时间(s)');title('基带信号');
f=1000;
[pst1,f]=periodogram(st,window,4096,fs);
subplot(3,1,2);plot(f,pst1);axis([0,5,0,15]);
xlabel('频率（Hz)');title('功率谱');
subplot(3,1,3);plot(f,10*log(pst1));axis([0,5,-200,200]);
xlabel('频率（Hz)');title('功率谱（dB）');

p=0;P=0;
Num=zeros(1,14);
for i=0:13
    e=awgn(s,i)
    e(e>=0)=1;
    e(e<0)=-1;
    x=xor((e+1)/2,(s+1)/2);
    num=sum(x);
    Num(i+1)=num;
    pe=num/length(s)
    Pe=1/2*erfc(sqrt((10.^(i/10))/2))
    p(1,i+1)=pe
    P(1,i+1)=Pe
end
i=0:13;
figure 
% semilogy(i,10*log(p),'b',i,10*log(P),'r');
semilogy(i,P,'r');
hold on
plot(i,p,'o');
title('系带传输误码率')
legend('理论结果','仿真结果')
grid on

