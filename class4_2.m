close all;
clc;clear;

Snrd = 0:8;
for i=0:8; 
    ne=0;nt=0;
    snr=10^(i/10);
    N0=15/11/snr;
    vr=sqrt(N0/2);
    while ne<400
             H=[0 0 1 1;0 1 0 1;0 1 1 0;
                 0 1 1 1;1 0 0 1;1 0 1 0;
                 1 0 1 1;1 1 0 0;1 1 0 1;
                 1 1 1 0;1 1 1 1;eye(4)]';
             G=[eye(11),H(:,1:11)'];
             m=randint(1,11);
             c=mod(m*G,2);
             s=2*c-1;
             n=vr*randn(1,15);
             r=s+n;
             y=(r>0);
             sy=mod(H*y',2);
              if isequal(sy,[0,0,0]')==0
                   hi=1;
                    while hi<16
                         if isequal(sy,H(:,hi))
                             break;
                         end
                         hi=hi+1;
                    end
                    if hi<16
                    y(hi)=~y(hi);
              end
        end
        ne=sum(xor(y,c))+ne;
        nt=nt+15;
  end
  BER(i+1)=ne/nt
end
semilogy(Snrd,BER,'-rd');grid on;
snr1 = 10.^(Snrd./10);
hold on;
EBER = qfunc(sqrt(2*snr1));
semilogy(Snrd,EBER,'-O');
legend('BPSK','ÒëÂëºó');
