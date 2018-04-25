%CSD code for pure decimals
%both decimals and integers must be processed from lower bits to higher bits
clear; clc;
input=[0.001,-0.003,0.035];
%输入必须在【-1，1】这个区间内,不能为0
format compact
format short
N=21;%输出三位，精确度20位基本上够了

for i = 1:length(input)
    t=input(i);
    flag=1;
    if t<0
        flag=-1;
        t=-t;
    end
    unit=zeros(1,N);
    for j = 1:N-1
        t=t*2;
        if t>=1
            unit(j+1)=1;
            t=t-1;
        end
    end
    for j = N:-1:2
        if unit(j)==2
            unit(j)=0;
            unit(j-1)=unit(j-1)+1;
        elseif unit(j)==1 && unit(j-1)==1
            unit(j)=-1;
            unit(j-1)=0;
            unit(j-2)=unit(j-2)+1;
        end
    end
    if flag==-1
        unit=-unit;
    end
    %unit
    %输出比特位以供参考
    position=[];
    for j=1:N
        if unit(j)~=0
            position=[position,[1-j;unit(j)]];
            if position(2,end)>0
                position(2,end)='+';
            else
                position(2,end)='-';
            end
            if size(position,2)==3
                break;
            end
        end
    end
    if size(position,2)==3
        fprintf('%g = %s2^(%d) %s2^(%d) %s2^(%d)\n',input(i),position(2,1),position(1,1),position(2,2),position(1,2),position(2,3),position(1,3))
    elseif size(position,2)==2
        fprintf('%g = %s2^(%d) %s2^(%d)\n',input(i),position(2,1),position(1,1),position(2,2),position(1,2))
    else
        fprintf('%g = %s2^(%d)\n',input(i),position(2,1),position(1,1))
    end
end