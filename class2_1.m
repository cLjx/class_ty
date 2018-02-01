clc;clear all
fs=200;Tp=20;T=1;%������Ԫ����
N=Tp/T;
st=randint(1,N)*2-1;
t=(0:N*fs-1)/fs*T;
% size(rectpulse(st,fs))
% size(t)
%% �ź�
singal=rectpulse(st,fs);
plot(t,singal);
ylim([-1.1 1.1])
%% ������
figure
NFFT=2^12;
window=boxcar(length(singal));
[pst f]=periodogram(singal,window,NFFT,10)
P=10*log10(pst);
plot(f,pst)
figure
plot(f,P)
