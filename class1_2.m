clc
clear all
%% init
Am=1; Ac=1;N=2^12;
fc=10000;fm=1000;fs=40*1000;Tp=0.01;
dt=1/fs;df=1/Tp;
t=0:dt:(Tp-dt);
mt=Am*sin(2*pi*fm.*t);
mc=Ac*cos(2*pi*fc.*t);
%% DSB
figure
s_DSB=mt.*mc;
s_DSB_C=s_DSB.*mc;
plot(t,s_DSB);title('DSB信号');
%% LSB
wc=1.5*2*pi*fm/fs;
B=fir1(16,wc/pi)
s_out=filter(B,1,s_DSB_C);
%% LBF out
figure
plot(t,s_out);title('解调信号');
%% LBF f
[h w]=freqz(B,1,N);
figure
plot(w*fs/(2*pi),20*log10(abs(h)));
title('LBF频率响应');
%% FFT
FFT_s_DSB_C=fft(s_DSB_C,N);
FFT_s_out=fft(s_out,N);
figure
subplot(2,1,1)
plot([0:N-1]/N*fs,abs(FFT_s_DSB_C));title('乘法器输出FFT')
subplot(2,1,2)
plot([0:N-1]/N*fs,abs(FFT_s_out));title('滤波器输出FFT')
%% A-f
figure
subplot(2,1,1)
plot(t,abs(s_out));title('解调信号幅度谱');
subplot(2,1,2)
plot(t,abs(s_DSB_C));title('乘法器输出信号幅度谱');
%% else P move
figure
pp=[pi/8 pi/4 pi/3 pi/2];
ppp=[8 4 3 2];
for i=1:4
mc_=Ac*cos(2*pi*fc.*t+pp(i));
s_out_=filter(B,1,s_DSB.*mc_);
subplot(2,2,i)
shows=sprintf('%s%d','相位偏移:pi/',ppp(i));
plot(t,s_out_);title(shows);
ylim([-.5 .5])
end