function [Plan,Duration] = plan_route(Position,Free,Limit_Time,Group,CNC_Artifacts)
%Plan_Route �ҵ�ָ�����У����ŵİ��š�
% ������������λ�ã����е�CNC������ʱ�����ƣ�

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

%Decision
Test = perms(Free);
Size_Test = size(Test);
Temp_Duration = 0;
Temp_Result = 0;
Skip = 0;

%�����ѡ������Ϊ����ѡ�������
i = 1;

%for i=1:Size_Test(1)
while i < Size_Test(1)
    [Duration(i,:),Result(i,:),Skip] = caculate_time(Position,Test(i,:),Limit_Time,Group,CNC_Artifacts);
    %���ڼ��ٵ���
    if Skip~=0
        Temp_Duration = Duration(i,:);
        Temp_Result = Result(i,:);
        TT = i+factorial(Skip)-1;
        for j=i+1:TT
            Duration(j,:)= Temp_Duration;
            Result(j,:) = Temp_Result;
            i = i+1;
        end
    end
    i = i+1;
end

Plan = Result;

end

