close all;
clc;clear;
for i=0:7 
    ne=0;nt=0;
    snr=10^(i/10);
    N0=7/4/snr;
    vr=sqrt(N0/2);
    while ne<400
        H=[1 1 0;1 0 1;0 1 1;1 1 1;eye(3)]';
        G=[eye(4),H(:,1:4)'];
        m=randint(1,4);
        c=mod(m*G,2);
        s=2*c-1;
        n=vr*randn(1,7);
        r=s+n;
        y=(r>0);
        sy=mod(H*y',2);
        if isequal(sy,[0,0,0]')==0
            hi=1;
            while hi<8
                if isequal(sy,H(:,hi))
                    break;
                end
                hi=hi+1;
            end
            if hi<8
                y(hi)=~y(hi);
            end
        end
        ne=sum(xor(y,c))+ne;
        nt=nt+7;
    end
    BER(i+1)=ne/nt
end
semilogy(0:7,BER,'-rd');grid on;
Snrd = 0:7;
snr = 10.^(Snrd./10);
hold on;
EBER = qfunc(sqrt(2*snr));
semilogy(Snrd,EBER,'-O');
legend('BPSK','ÒëÂëºó');
