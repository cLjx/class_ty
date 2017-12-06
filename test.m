%通信原理第一次实验
clear;clc;
fm=1000;
fc=10*fm;
fs=60000;
t=0:1/fs:0.01;
mt=cos(2*pi*fm*t);
ct=cos(2*pi*fc*t);
figure(1);
%plot(mt)
subplot(2,2,1);
plot(t,mt)
title('调制信号的时域波形');
axis([0,0.01,-2,2]);grid on;
subplot(2,2,2);
plot(t,ct)
title('载波信号的时域波形');

% (2)
sdsb=mt.*ct;
sam=(1+mt).*ct;
subplot(2,2,3);
plot(t,sdsb);
hold on;
plot(t,abs(mt),'r');
title('DSB已调的波形');
axis([0,0.01,-2,2]);grid on;

subplot(2,2,4);
plot(t,sam);
hold on;
plot(t,abs(mt+1),'r');
title('AM已调信号的波形');
axis([0,0.01,-2,2]);grid on;

% 用相移法进行SSB调制
mt1=cos(2*pi*fm*t);
cqt=cos(2*pi*fc*t);
Sb1=0.5*mt.*ct-0.5*mt1.*cqt;
Sb2=0.5*mt.*ct+0.5*mt1.*cqt;

N=4096;
fs=10*fc;

figure(2);
subplot(3,1,1);
plot([0:N-1]/N*fs,abs(fft(mt,N)));
xlabel('f(Hz)');
grid on;
title('调制信号频谱');
axis([0,25000,0,400]);

subplot(3,1,2);
plot(([0:N-1]/N)*fs,abs(fft(ct,N)));
xlabel('f(Hz)');
grid on;
title('载波信号频谱');
axis([0,25000,0,500]);

