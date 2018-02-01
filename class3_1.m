close all;
clear,clc;
fc=1000;
Rs=100;
fs=8*fc;
Sm=randi([0,1],1,1000)*2-1;
Srb=rectpulse(Sm,fs/Rs);
N=4096;
t=(0:length(Srb)-1)/fs;
c=cos(2*pi*fc*t);
Sbpsk=Srb.*c;
%矩形基带信号时的BPSK调制信号
figure(1);
subplot(311);
plot(t,c);
axis([0.02,0.08,-1.1,1.1]);
title('载波');xlabel('时间（s）');
subplot(312);
plot(t,Srb);
axis([0.02,0.08,-1.1,1.1]);
title('基带信号');xlabel('时间（s）');
subplot(313);
plot(t,Sbpsk);
axis([0.02,0.08,-1.1,1.1]);
title('BPSK已调信号');xlabel('时间（s）');

%带通
wc1=[2*pi*(fc-Rs)/fs,2*pi*(fc+Rs)/fs];
B1=fir1(256,wc1/pi);
[h,w]=freqz(B1,1,2048);

%低通
wc2=2*2*pi*Rs/fs; 
B2=fir1(16,wc2/pi);   %低通滤波器系统函数系数

%带通滤波器的频率响应
figure(2);
plot(w*fs/(2*pi),20*log10(abs(h)));
axis([400,1600,-120,1]);grid on;
title('带通滤波器频率响应');xlabel('频率（Hz）');

%经过带通
m1=filter(B1,1,Sbpsk); 
S=m1.*c;   
m2=filter(B2,1,S);%解调
%BPSK信号经过带通滤波器后的波形和解调后的基带波形（矩形基带信号）
figure(3);
subplot(211);
plot(t,m1);
axis([0.04,0.12,-1.5,1.5]);
title('经过带通滤波器后的BPSK已调信号');xlabel('时间（s）');
subplot(212);
plot(t,m2);
axis([0.04,0.12,-0.7,0.7]);grid on;
title('解调后的基带信号');xlabel('时间（s）');
%矩形基带信号时的BPSK调制信号频谱
Fs=fft(Sbpsk,N);
M1=fft(m1,N);
figure(4);
subplot(211);
plot(fs*(0:N-1)/N,abs(Fs));
axis([400,1600,0,800]);grid on;
title('BPSK信号频谱');xlabel('频率（Hz）');
subplot(212);
plot(fs*(0:N-1)/N,abs(M1));
axis([400,1600,0,800]);
title('BPSK信号频谱-经过带通滤波器后');xlabel('频率（Hz）');

