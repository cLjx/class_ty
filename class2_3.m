clear all
clc
%矩形基带信号
fs=10;
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

Pe=1/2*erfc(A/sqrt(2)/delta_n)
