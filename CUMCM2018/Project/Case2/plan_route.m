function [Plan,Duration] = plan_route(Position,Free,Limit_Time,Group,CNC_Artifacts,CNC_Process)
%Plan_Route �ҵ�ָ�����У����ŵİ��š�
% ������������λ�ã����е�CNC������ʱ�����ƣ�
%2018_Mathmatic_Modling_Problem-B
%%
%Author:YXP
%Email:yxp189@foxmal.com
%Please feel free to contact us for any questions,thank you!
%%
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
Size_free = size(Free);
num = 1;
Choice = Free;

for i=1:Size_free(2)
    if  (CNC_Artifacts(i)==1)%&&(CNC_Process(i)==2)
        Choice(Size_free(2)+num) = Free(i);
        num = num+1;
    end
end

Test = perms(Free);
Size_Test = size(Test);
Duration = zeros(factorial(Size_free(2)),Size_free(2));
Result = zeros(factorial(Size_free(2)),Size_free(2));
% Temp_Duration = 0;
% Temp_Result = 0;
% Skip = 0;

%�����ѡ������Ϊ����ѡ�������
i = 1;

%for i=1:Size_Test(1)
while i <= Size_Test(1)
    [Duration(i,:),Result(i,:),Skip] = caculate_time(Position,Test(i,:),Limit_Time,Group,CNC_Artifacts,CNC_Process);
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

