%function [out] = PRBS(n,x)
%clc
%clear all

disp('PRBS Test Signal Generator')
n = input('Jumlah Bit : ');         %Jumlah bit
x = input('Polinomial : ');         %Cth x = [4 5 6 8] --> 4 gerbang XOR
stt = ones(1,n);                    %state
seq(1,:) = stt;                     %state sequence
m = length(x);                      %jumlah gerbang XOR

for i = 2:2^n-1;                    %iterasi sequence 
    shift = xor(stt(x(1)), stt(x(2)));%Shift
    if m > 2;                       %jika gerbang XOR > 2
        for j = 1:m-2;              %iterasi output
            shift = xor(stt(x(j+2)), shift);%Shift
        end
    end
    for k = n:-1:2                  %iterasi shift
        stt(k) = stt(k-1);          %shift register
    end
    stt(1) = shift;                 %Shift
    seq(i,:) = stt;                 %state sequence
end

out = seq(:,n)';                     %Output Sequence
stairs(out);title('PRBS Test Signal');axis([0 2^n -0.1 1.1]); 
%Plot PRBS Test Signal
%end