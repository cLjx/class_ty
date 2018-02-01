close all;
clear;
%������
fs=10;
x1=rcosflt(1,1,fs,'fir',1);
x2=rcosflt(1,1,fs,'fir',0.75);
x3=rcosflt(1,1,fs,'fir',0.5);
x4=rcosflt(1,1,fs,'fir',0.25);
figure(1);
subplot(221);
plot(0:length(x1)-1,x1);
title('�����ź�ʱ���Σ���=1');grid on;
subplot(222);
plot(0:length(x1)-1,x2);
title('�����ź�ʱ���Σ���=0.75');grid on;
subplot(223);
plot(0:length(x1)-1,x3);
title('�����ź�ʱ���Σ���=0.5');grid on;
subplot(224);
plot(0:length(x1)-1,x4);
title('�����ź�ʱ���Σ���=0.25');grid on;
%���λ����ź�
m=randint(1,1000)*2-1;
srp=rectpulse(m,fs);
[Psr,f1]=periodogram(srp,window,8192,fs);
figure(3);
subplot(311);
plot((0:20*fs-1)/fs,srp(1:20*fs));
axis([0,20,-1.5,1.5]);
subplot(312);
plot(f1,Psr);
subplot(313);
Pdb1=10*log10(Psr);
plot(f1,Pdb1);
%����ϵ��1
src=rcosflt(m,1,fs,'fir',1);
%src=rcosdesign(1,1,m);
[Psc,f2]=periodogram(src,window,8192,fs);
figure(5);
subplot(311);
plot((0:20*fs-1)/fs,src(1:20*fs));
axis([0,20,-1.5,1.5]);
title('����ϵ��1')
subplot(312);
plot(f2,Psc);
subplot(313);
Pdb2=10*log10(Psc);
plot(f2,Pdb2);
%����ϵ��0.5
src2=rcosflt(m,1,fs,'fir',0.5);
[Psc2,f3]=periodogram(src2,window,8192,fs);
figure(7);
subplot(311);
plot((0:20*fs-1)/fs,src(1:20*fs));
title('����ϵ��0.5')
axis([0,20,-1.5,1.5]);
subplot(312);
plot(f3,Psc2);
subplot(313);
Pdb3=10*log10(Psc);
plot(f3,Pdb3);

%��ͼa=1,SNRdb=0,SNRdb=20,SNRdb=30,
SNRdb=30;
xt1=src(1:100*fs);
SNR=10.^(SNRdb/10);
pn=1/SNR;
n1=sqrt(pn)*randn(length(xt1),1);
xn1=xt1+n1;
eyediagram(xn1,3*fs);
title('SNR=30dB')

SNRdb=20;
xt2=src(1:100*fs);
SNR=10.^(SNRdb/10);
pn=1/SNR;
n2=sqrt(pn)*randn(length(xt2),1);
xn2=xt2+n2;
eyediagram(xn2,3*fs);
title('SNR=20dB')

SNRdb=10;
xt3=src(1:100*fs);
SNR=10.^(SNRdb/10);
pn=1/SNR;
n3=sqrt(pn)*randn(length(xt3),1);
xn3=xt3+n3;
eyediagram(xn3,3*fs);
title('SNR=10dB')

SNRdb=0;
xt3=src(1:100*fs);
SNR=10.^(SNRdb/10);
pn=1/SNR;
n3=sqrt(pn)*randn(length(xt3),1);
xn3=xt3+n3;
eyediagram(xn3,3*fs);
title('SNR=0dB')

xt1=src(1:100*fs);
eyediagram(xt1,3*fs);
title('����������')
