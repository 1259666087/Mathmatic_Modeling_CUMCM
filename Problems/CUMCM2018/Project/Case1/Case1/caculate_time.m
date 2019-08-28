function [Duration,Result,Skip] = caculate_time(Position,Route,Limit_Time,Group,CNC_Artifacts)
%caculate_time �����ض�·�ߵ�ʱ�仨��
%   �����ض�·�ߵ�ʱ�仨��

%Import data
Move_Duration = ...%�ƶ���ʱ;��-��ͬ���룻��-��ͬ���
    [20	23	18;...
    33	41	32;...
    46	59	46;];

Process_Duration = ...%�ӹ���ʱ;��-��ͬ�����ţ���-��ͬ���
    [560 580 545;...
    400	280	455;...
    378	500	182;];

Load_Duration = ...%�����ϣ�װ�أ���ʱ����һ��-1/3/5/7���ڶ���-2/4/6/8��
    [28	30 27;...
    31 35 32;];

Clean_Duration = ...%��ϴ��ʱ����-��ͬ���
    [25	30 25];

%Caculate
Duration = 0;   %���ó�ֵ0��
Step_Duration = 0;
Move = 0;
Temp_Position = Position;
Skip = 0;
Result = [];
num = 1;

Size_Free = size(Route);%�����Free�Ǿ������ر��ź��·��
LoadClean_Time = zeros(1,Size_Free(2));  %�����ƶ������װ��+��ϴʱ��
for i=1:Size_Free(2)    %�����ƶ������װ��+��ϴʱ��
    LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %�����������ʱ�䣻
    if CNC_Artifacts(Route(i)) == 1
        LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %��ϴʱ��
    end
end

for i=1:Size_Free(2)
    Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
    if Move ~= 0
        Step_Duration = Step_Duration + Move_Duration(Move,Group);
    end
    Step_Duration = Step_Duration + LoadClean_Time(i);
    if (Duration+Step_Duration) <= Limit_Time
        Duration = Duration + Step_Duration;
        Temp_Position = (Route(i)+mod(Route(i),2))/2;
        Result(num) = Route(i);
        num = num+1;
    else
        Skip = (Size_Free(2)-num)+1;
        for j=1:(Size_Free(2)-num)+1
            Result(num) = 0;
            num = num+1;%%%����Ҳ������Ϊ����ֵ����ʾ��һ���ֲ����ظ������ˡ�
        end
        break;
    end
end

end

