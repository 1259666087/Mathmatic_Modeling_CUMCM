function [Duration,Result,Skip] = caculate_time(Position,Route,Limit_Time,Group,CNC_Artifacts,CNC_Process)
%caculate_time �����ض�·�ߵ�ʱ�仨��
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

%Caculate
Size_Free = size(Route);%�����Free�Ǿ������ر��ź��·��

Duration = zeros(1,Size_Free(2));   %���ó�ֵ0��
Result = zeros(1,Size_Free(2));
Step_Duration = 0;
Move = 0;
Temp_Position = Position;
Skip = 0;
num = 1;


LoadClean_Time = zeros(1,Size_Free(2));  %�����ƶ������װ��+��ϴʱ��
Case1 = ones(1,8);

if isequal(Case1,CNC_Process)%�����Case1
    for i=1:Size_Free(2)    %�����ƶ������װ��+��ϴʱ��
        LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %�����������ʱ�䣻
        if CNC_Artifacts(Route(i)) == 1
            LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %��ϴʱ��
        end
    end
    
    for i=1:Size_Free(2)
        Step_Duration = 0;
        Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
        if Move ~= 0
            Step_Duration = Step_Duration + Move_Duration(Move,Group);
        end
        Step_Duration = Step_Duration + LoadClean_Time(i);
            if i ~= 1
                Gap = Duration(i-1)+Step_Duration;
            else
                Gap = Duration(i);
            end
        if (Gap) <= Limit_Time
            if i==1
                Duration(i) =  Step_Duration;
            else                
                Duration(i) = Duration(i-1) + Step_Duration;
            end
            Temp_Position = (Route(i)+mod(Route(i),2))/2;
            Result(num) = Route(i);
            num = num+1;
        else
            Skip = (Size_Free(2)-num)+1;
%             for j=1:(Size_Free(2)-num)+1
%                 Result(num) = 0;
%                 Duration(num) = 0;
%                 num = num+1;%%%����Ҳ������Ϊ����ֵ����ʾ��һ���ֲ����ظ������ˡ�GET!
%             end
            break;
        end
    end
else
    for i=1:Size_Free(2)    %�����ƶ������װ��+��ϴʱ��
        LoadClean_Time(i) = LoadClean_Time(i) + Load_Duration(2-mod(Route(i),2),Group);    %�����������ʱ�䣻
        if (CNC_Artifacts(Route(i)) == 1)&&(CNC_Artifacts(Route(i)) == 3)
            LoadClean_Time(i) = LoadClean_Time(i) + Clean_Duration(Group);    %��ϴʱ��
        end
    end
    
    Last_CNC = 0;   %��һ��CNC״̬0-��/1-Case2-1�����򹤼�/2-Case2-2�����򹤼�;
    
    %��������1����������2����
    for i=1:Size_Free(2)
        
        Move = abs(Temp_Position - (Route(i)+mod(Route(i),2))/2);
        if Move ~= 0
            Step_Duration = Step_Duration + Move_Duration(Move,Group);
        end
        Step_Duration = Step_Duration + LoadClean_Time(i);
        
        if CNC_Artifacts(Route(i))==1   %����л�
            
            if (CNC_Process(Route(i))==2) && (i~=Size_Free(2))%���ǡ��Ϊ1����
                Last_CNC = 1;
                if CNC_Process(Route(i+1))==2   %���ǡ��Ϊ1����,�����һ��ҲΪ1����
                    
                    if i==1
                        Duration(i) =  Step_Duration;
                    else                
                    Duration(i) = Duration(i-1) + Step_Duration;
                    end
%                     Duration = Duration + Step_Duration;
                    Temp_Position = (Route(i)+mod(Route(i),2))/2;
                    Result(num) = Route(i);
%                     num = num+1;
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;
%                         end
                    break;
                else%�л������ǡ��Ϊ1����,�����һ��Ϊ2������������һ������
                        if i ~= 1
                            Gap = Duration(i-1)+Step_Duration;
                        else
                            Gap = Duration(i);
                        end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;
%                         end
                        break;
                    end
                end

            else%�����ǰΪ2���� 
                    Last_CNC = 0;
                    if i ~= 1
                        Gap = Duration(i-1)+Step_Duration;
                    else
                        Gap = Duration(i);
                    end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;%%%����Ҳ������Ϊ����ֵ����ʾ��һ���ֲ����ظ������ˡ�GET!
%                         end
                        break;
                    end  
                    
            end
        else  %���û�л���
            if (CNC_Process(Route(i))==3) && (Last_CNC==0)   %���Ϊ2����,��֮ǰû��1����
%                 Duration = inf; %������
%                 Result = zeros(1,Size_Free(2)); %ȫ��0��
                Skip = Size_Free(2) - i;
%                 size_result = size(Result);
%                  for j=1:(Size_Free(2)-size_result(2))
%                         Result(size_result(2)+j) = 0;
%                         Duration(size_result(2)+j) = 0;
%                  end
                break;
            else   %��ǰ�����ǹ���1������֮ǰ�й���1
                    if (CNC_Process(Route(i))==3)
                        Last_CNC=0;
                    end
                    if i ~= 1
                        Gap = Duration(i-1)+Step_Duration;
                    else
                        Gap = Duration(i);
                    end
                    if (Gap) <= Limit_Time
%                     if (Duration(i)+Step_Duration) <= Limit_Time
                        if i==1
                            Duration(i) =  Step_Duration;
                        else                
                            Duration(i) = Duration(i-1) + Step_Duration;
                        end
%                         Duration = Duration + Step_Duration;
                        Temp_Position = (Route(i)+mod(Route(i),2))/2;
                        Result(num) = Route(i);
                        num = num+1;
                    else
                        Skip = (Size_Free(2)-num)+1;
%                         for j=1:(Size_Free(2)-num)+1
%                             Result(num) = 0;
%                             Duration(num) = 0;
%                             num = num+1;%%%����Ҳ������Ϊ����ֵ����ʾ��һ���ֲ����ظ������ˡ�GET!
%                         end
                        break;
                    end  
            end
        end
%         Last_CNC = 0;
    end
  
end

end

