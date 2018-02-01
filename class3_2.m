clc;
clear; 
fc=1000;
fm=100;
fs=8000; 
info=randi([0,1],1,1000);
bpsk_d=2.*info-1; 
bpsk_b=rectpulse(bpsk_d,100);%矩形 
t=(0:1:length(bpsk_b)-1)/fs;
sc=cos(2*pi*fc*t); 
figure;
bpsk_s=bpsk_b.*sc;
subplot(3,1,1);
plot(t,sc);title('载波¨'); xlabel('时间（s）');axis([0,0.1, -2,2]) ;
subplot(3,1,2);plot(t,bpsk_b);title('基波信号'); xlabel('时间（s）');axis([0,0.1,-2,2]) ;
subplot(3,1,3);
plot(t,bpsk_s);title('BPSK已调信号');xlabel('时间（s）');axis([0,0.05,-2,2])


wc_bpf=[2*pi*(fc-fm)/fs,2*pi*(fc+fm)/fs]; 
bpf_hn=fir1(256,wc_bpf/pi); 
bpf_bpsk_s=filter(bpf_hn,1,bpsk_s);
fft_n=8192; 
bpsk_f=fft(bpsk_s,fft_n); 
bpf_bpsk_f=fft(bpf_bpsk_s,fft_n); 
fhz=(0:fft_n-1)/fft_n*fs;
figure;
subplot(2,1,1);
plot(fhz,abs(bpsk_f));title('BPSK信号频谱');xlabel('频率（HZ）'); axis([400,1600,0,1000]);grid on; 
subplot(2,1,2);
plot(fhz,abs(bpf_bpsk_f));title('BPSK信号经过带通滤波器'); xlabel('频率（HZ）');axis([400,1600,0,1000]);grid on; 


 [bps_hf,w]=freqz(bpf_hn,1,4096); 
 figure;
 plot(w/(2*pi)*fs,10*log10(bps_hf));title('带通滤波器频率响应');xlabel('频率（HZ）'); axis([400,1600,-60,2]);grid on; 
 
 bpsk_dm=bpf_bpsk_s.*sc; 
 wc_lpf=2*pi*fm/fs*2;
 lpf_hn=fir1(32,wc_lpf); 
 bpsk_dm_s=filter(lpf_hn,1,bpsk_dm);
 figure;
 subplot(2,1,1);plot(t,bpf_bpsk_s) ;title('经过带通滤波器以后的BPSK已调信号'); xlabel('时间（s）');axis([0.04,0.12,-1.5,1.5]) ;
 subplot(2,1,2);
 plot(t,bpsk_dm_s);title('解调后的信号'); xlabel('时间（s）');axis([0.04,0.12,-1,1]);
 grid on;  

clc; 
clear; 
info=randi([0,1],1,1000); 
bpsk_d=2*info-1; 
 
scatterplot(bpsk_d);title('BPSK星座图，无噪声')
xlabel('同相分量');ylabel('正交分量');
axis([-2,2,-3,3]) 
grid on; 
snr_db=30; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=real(bpsk_d+noise); 
scatterplot(bpsk_nd);title('BPSK星座图，Es/N0=30dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=20; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=real(bpsk_d+noise); 
scatterplot(bpsk_nd) ;title('BPSK星座图，Es/N0=20dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=10; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=real(bpsk_d+noise); 
scatterplot(bpsk_nd) ;title('BPSK星座图，Es/N0=10dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=3; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=real(bpsk_d+noise); 
scatterplot(bpsk_nd) ;title('BPSK星座图，Es/N0=0dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 


clc; 
clear; 
x_info=randi([0,1],1,1000); 
y_info=randi([0,1],1,1000);
qpsk_d=(2*x_info-1)+1i*(2*y_info-1); 
 
scatterplot(qpsk_d) ;title('QPSK星座图，无噪声')
xlabel('同相分量');ylabel('正交分量');
axis([-2,2,-3,3]) 
grid on; 
snr_db=30; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=qpsk_d+noise; 
scatterplot(bpsk_nd) ;title('QPSK星座图，Es/N0=30dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=20; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=qpsk_d+noise; 
scatterplot(bpsk_nd) ;title('QPSK星座图，Es/N0=20dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=10; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=qpsk_d+noise; 
scatterplot(bpsk_nd) ;title('QPSK星座图，Es/N0=10dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
snr_db=3; 
snr=10^(snr_db/10); 
sigma_n=sqrt(1/snr); 
noise=sigma_n*(randn(1,1000)+1i*randn(1,1000)); 
bpsk_nd=qpsk_d+noise; 
scatterplot(bpsk_nd) ;title('QPSK星座图，Es/N0=0dB')
xlabel('同相分量');ylabel('正交分量');
grid on; 
 
clc,clear;
for i = 0:10
    ne = 0;
    nt = 0;
    sigma_n=sqrt(1/i); 
    while (ne<=200)
        x_info=randi([0,1],1,1000); 
        y_info=randi([0,1],1,1000);
        d=(2*x_info-1)+1i*(2*y_info-1); 
        pn = 1/(10^(SNR(i)/10));
        n = sigma_n*(randn(1,1000)+1i*randn(1,1000));
        r = d+n;
        md = r>=0;
        ne = sum(xor(m,md))+ne;
        nt = nt+1000;
    end
    Pe(i) = ne/nt;
end
semilogy(SNR,Pe,'or-');grid on;
hold on;
semilogy(SNR,qfunc(sqrt(10.^(SNR/10))),'b-');grid on;
legend('仿真','理论值');
