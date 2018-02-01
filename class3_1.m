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
%���λ����ź�ʱ��BPSK�����ź�
figure(1);
subplot(311);
plot(t,c);
axis([0.02,0.08,-1.1,1.1]);
title('�ز�');xlabel('ʱ�䣨s��');
subplot(312);
plot(t,Srb);
axis([0.02,0.08,-1.1,1.1]);
title('�����ź�');xlabel('ʱ�䣨s��');
subplot(313);
plot(t,Sbpsk);
axis([0.02,0.08,-1.1,1.1]);
title('BPSK�ѵ��ź�');xlabel('ʱ�䣨s��');

%��ͨ
wc1=[2*pi*(fc-Rs)/fs,2*pi*(fc+Rs)/fs];
B1=fir1(256,wc1/pi);
[h,w]=freqz(B1,1,2048);

%��ͨ
wc2=2*2*pi*Rs/fs; 
B2=fir1(16,wc2/pi);   %��ͨ�˲���ϵͳ����ϵ��

%��ͨ�˲�����Ƶ����Ӧ
figure(2);
plot(w*fs/(2*pi),20*log10(abs(h)));
axis([400,1600,-120,1]);grid on;
title('��ͨ�˲���Ƶ����Ӧ');xlabel('Ƶ�ʣ�Hz��');

%������ͨ
m1=filter(B1,1,Sbpsk); 
S=m1.*c;   
m2=filter(B2,1,S);%���
%BPSK�źž�����ͨ�˲�����Ĳ��κͽ����Ļ������Σ����λ����źţ�
figure(3);
subplot(211);
plot(t,m1);
axis([0.04,0.12,-1.5,1.5]);
title('������ͨ�˲������BPSK�ѵ��ź�');xlabel('ʱ�䣨s��');
subplot(212);
plot(t,m2);
axis([0.04,0.12,-0.7,0.7]);grid on;
title('�����Ļ����ź�');xlabel('ʱ�䣨s��');
%���λ����ź�ʱ��BPSK�����ź�Ƶ��
Fs=fft(Sbpsk,N);
M1=fft(m1,N);
figure(4);
subplot(211);
plot(fs*(0:N-1)/N,abs(Fs));
axis([400,1600,0,800]);grid on;
title('BPSK�ź�Ƶ��');xlabel('Ƶ�ʣ�Hz��');
subplot(212);
plot(fs*(0:N-1)/N,abs(M1));
axis([400,1600,0,800]);
title('BPSK�ź�Ƶ��-������ͨ�˲�����');xlabel('Ƶ�ʣ�Hz��');

