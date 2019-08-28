function [plan,duration] = Decsion(Start_Position,Free,Time_Limit,Group,CNC_Artifacts,CNC_Process)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%2018_Mathmatic_Modling_Problem-B
%%
%Author:YXP
%Email:yxp189@foxmal.com
%Please feel free to contact us for any questions,thank you!
%%
%Clean
% clear;clc;
%%
%Data
% Start_Position = 1;
% Free = [1,2,3,4,5,6,7,8];
% Time_Limit = 800;
% Group = 1;
% CNC_Artifacts = [0,1,0,1,1,1,1,1];
% CNC_Process =   [2,3,3,3,2,3,2,3];
%%
%Operation Function
[Plan,Duration_matrix] = plan_route(Start_Position,Free,Time_Limit,Group,CNC_Artifacts,CNC_Process);
Duration = max(Duration_matrix')';
%%
%Various Index
%%%%%%%%%%
Pluse_order = find(Duration);
[~,T_I] = min(Duration(Pluse_order));%��ʱ�����;������ʱ���ж�
%%%%%%%%%%
BW_matrix = sum((~~Plan)')';
AVE = Duration./BW_matrix;%ƽ��ʱ����㣻
[~,A_I] = min(AVE);
%%%%%%%%%
%ȫ��������ɵ����ֵ
Size_Route = size(Duration);
Size_Free = size(Free);
num = 1;
Max_idex = [];
Max_Achive = max(BW_matrix);
for i=1:Size_Route(1)
    if BW_matrix(i) == Max_Achive
        Max_idex(num,:) = i;
        num = num +1;
    end
end
[~,F_I] = min(Duration(Max_idex,:));
%%
%OUTPUT
%�����о�
disp('Pluse-TOTAL-Choice');
plan(1,:) = Plan(Pluse_order(T_I),:);
disp (plan(1,:));
disp (Duration(Pluse_order(T_I),:));
duration(1,:) = Duration_matrix(Pluse_order(T_I),:);
disp (duration(1,:));
%ƽ���о�
disp('AVERAGE-Choice');
plan(2,:) = Plan(A_I,:);
disp (plan(2,:));
disp (Duration(A_I,:));
duration(2,:) = Duration_matrix(A_I,:);
disp (duration(2,:));
%����о�/��ɶ��о�
disp('FULL-Choice');
if isempty(F_I)
    disp('No Achive Case!');
else
    plan(3,:) = Plan(Max_idex(F_I,:),:);
    disp (plan(3,:));
    disp (Duration(Max_idex(F_I,:),:));
    duration(3,:) = Duration_matrix(Max_idex(F_I,:),:);
    disp (duration(3,:));
end

end

