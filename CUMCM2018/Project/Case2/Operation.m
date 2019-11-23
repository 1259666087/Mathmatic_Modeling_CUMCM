%2018_Mathmatic_Modling_Problem-B
%%
%ģ��8h�����棻
%Author:YXP
%Email:yxp189@foxmal.com
%Please feel free to contact us for any questions,thank you!
%%
%DATA
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

%%
%Defined 
%GROUP
Group = 1;  %Ŀǰ������

%TIMER
Global_Timer = 0;  %ȫ�ּ�ʱ������0s��ʼ������8h(3600*8s);���ʱ����1s
Gap = 1;    %��ɢ����ʱ����1s;
End_Time = 3600*8;  %����ʱ��8h(3600*8s);

%CNC�ӹ�̨
CNC_State = zeros(1,8);     %CNC�ӹ�����״̬������(0)/�ӹ�����ʱ(remain);
All_free = zeros(1,8);
All_busy = ones(1,8);
CNC_Artifacts = zeros(1,8); %CNC���Ƿ��й�����0-��/1-�У�
CNC_Process = ones(1,8);    %CNC�ӹ�����1-Case1///2-����1��3-����2��

%RGVС��
%%%%%%%%%%%%%%%%%%
%RGV STATE TABLE%
% Order   0     1    2     3         4           5            6
% State	����	�ƶ�1	�ƶ�2	�ƶ�3	������1/3/5/7	������2/4/6/8	��ϴ
%%%%%%%%%%%%%%%%%%
RGV_State = zeros(1,2); %RGVС��Ŀǰ����״̬��(STATE,REMAIN)/(״̬,ʣ��ʱ��)
RGV_position = 1;       %RGVС������λ�ã�(1-4)
RGV_destination = 1;    %RGVС��Ŀ�ĵأ�(1-4)

%CONVEYER���ʹ�
Conveyer_State = ones(1,8); %Conveyer״̬(0-�޻���1-�л�)
%%
clear;clc
%%
%Operation
Start_Position = 1;
Node = [1,2,3,4,5,6,7,8];
Node_num = 8;
Free = [1,2,3,4,5,6,7,8];
Time_Limit = 2000;
Group = 1;
CNC_Artifacts = [0,0,0,0,0,0,0,0];
CNC_Process =   [1,1,1,1,1,1,1,1];
plan = [];
duration = [];

while Global_Timer <= End_Time
    if isequal(All_busy,CNC_State)
        Time_Limit = 1500;
    else
        if isequal(All_free,CNC_State)
            Time_Limit = 1500;
            Free = Node;
        else
            Time_Limit = min(CNC_State(find(CNC_State)));
            Free = Node(find(~CNC_State));
            [plan,duration] = Decsion(Start_Position,Free,Time_Limit,Group,CNC_Artifacts,CNC_Process);
        end 
    end
    
    Size_free = size(Free);
    Start =  zeros(1,8);
    if  ~isempty(plan)  %�а�������㿪ʼʱ��
        for i=1:Size_free(2)
            Start(plan(i)) = duration(i);
            if CNC_Artifacts(plan(i)) == 1
                Start(plan(i)) = Start(plan(i)) - Clean_Duration(Group);
            end
        end
    end
    
    if ~isequal(Start,All_free)
        for i=1:Node
            
            
    
    
    for i=1:Node_num        
         if CNC_State(i)~= 0
            CNC_State(i) = CNC_State(i) - 1;
         end
    end
    
    Global_Timer = Global_Timer + 1;
end



