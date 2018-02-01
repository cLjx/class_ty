%%QPSK
clc;
clear all;
close all;
nsymbol = 50000;%%ÿ��������·������ķ��ͷ�����
data = randi([0,1],1,nsymbol*2); %%����1�У�nsymbol�о��ȷֲ��������0,1
qpsk_mod1 = zeros(1,nsymbol);
qpsk_mod2 = zeros(1,nsymbol);
data_receive1 = zeros(1,nsymbol);
data_receive2 = zeros(1,nsymbol);
data_receive = zeros(1,nsymbol*2);
Wrongnumber = 0;
SymbolWrongnumber = 0;

for i=1:nsymbol               %%����
    symbol1 = data(2*i-1);
    symbol2 = data(2*i);
    if symbol1 == 0 & symbol2 == 0 
        qpsk_mod1(i) = 1;  
        qpsk_mod2(i) = 0;
    elseif symbol1 == 0 & symbol2 == 1 
        qpsk_mod1(i) = 0;  
        qpsk_mod2(i) = 1;
    elseif symbol1 == 1 & symbol2 == 1 
        qpsk_mod1(i) = -1;  
        qpsk_mod2(i) = 0;
    elseif symbol1 == 1 & symbol2 == 0  
        qpsk_mod1(i) = 0;  
        qpsk_mod2(i) = -1;
    end
end
   
    
 SNR_dB = 1:10;%%%�����dB��ʽ
 SNR = 10.^(SNR_dB/10);%%�����ת��Ϊ����ֵ
    

 
 for loop= 1:10
    sigma = sqrt(1/(2*SNR(loop)));%%%���ݷ��Ź�������������
    qpsk_receive1 = qpsk_mod1 + sigma * randn(1,nsymbol);
    qpsk_receive2 = qpsk_mod2 + sigma * randn(1,nsymbol); %%��Ӹ���˹������
     for k=1:nsymbol
        if qpsk_receive2(k) > qpsk_receive1(k) 
       data_receive2(k) = 1;
        end
        if qpsk_receive2(k) < qpsk_receive1(k) 
       data_receive2(k) = 0;
        end
        if qpsk_receive2(k) >  -qpsk_receive1(k) 
       data_receive1(k) = 0;
        end
        if qpsk_receive2(k) <  -qpsk_receive1(k) 
         data_receive1(k) = 1;
        end
         data_receive(2*k-1) = data_receive1(k);
         data_receive(2*k) = data_receive2(k);
     end
   for p=1:(nsymbol*2)
       if data_receive(p) ~= data(p)
           Wrongnumber = Wrongnumber + 1;
       end
   end
   for l=1:nsymbol
       if data_receive1(l)~=data(2*l-1);
          SymbolWrongnumber = SymbolWrongnumber + 1;
       elseif data_receive2(l) ~= data(2*l);
           SymbolWrongnumber = SymbolWrongnumber + 1;
       end
   end
   Pe(loop)=SymbolWrongnumber/nsymbol;
   Pb(loop)=Wrongnumber/(nsymbol*2);
   Wrongnumber = 0 ;
   SymbolWrongnumber = 0;
 end

Pe_theory = 1-(1-qfunc(sqrt(SNR))).^2;
Pb_theory = 0.5* erfc(sqrt(SNR/2));
semilogy(SNR_dB,Pb,'o',SNR_dB,Pb_theory,'r')
title('QPSK�ź���AWGN�ŵ��µ��������');
xlabel('�����/dB');ylabel('������');
legend('����ֵ','����ֵ');
grid on;
    
