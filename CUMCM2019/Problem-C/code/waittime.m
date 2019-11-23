%�����ڻ����ĵȵȴ�ʱ��
clear;clc;
load('Cost.mat');
route_size = size(Result);
Wait_num = 1;
Airuse_num = 1;
Leave_num = 1;

for i=1:route_size(1)
    
    if (Result(i,3)==0) && (Result(i,7)<=0.3)
        if  (Result(i,12) <= 100) &&  (Result(i,12) > 0)
            Waittime(Wait_num,1) = Result(i,12);
            Waittime(Wait_num,2) = i;
            Wait_num = Wait_num + 1;
        end
    end
    
    if (Result(i,3)==1) && (Result(i,12) >0) && (Result(i,12) <= 300 )
            Airusetime(Airuse_num,1) = Result(i,12);
            Airusetime(Airuse_num,2) = i;
            Airuse_num = Airuse_num + 1;
    end
    
    if (Result(i,3)==0) && (Result(i,7)<=120) && (Result(i,12) <= 200 ) && (Result(i,12) > 0 )
            Leavetime(Leave_num,1) = Result(i,12);
            Leavetime(Leave_num,2) = i;
            Leave_num = Leave_num + 1;
    end
    
end

Ave_Wait = sum(Waittime(:,1))/(Wait_num-1);
Ave_Airuse = sum(Airusetime(:,1))/(Airuse_num-1);
Ave_Leave = sum(Leavetime(:,1))/(Leave_num-1);

figure();
histogram(Waittime(:,1));
title('�����ڵȴ�ʱ��ֱ��ͼ','Fontname','����','Fontsize',12);
xlabel('ʱ��(min)');
ylabel('Ƶ��');
figure();
histogram(Airusetime(:,1));
title('�������ӵ�-��ʱֱ��ͼ','Fontname','����','Fontsize',12);
xlabel('ʱ��(min)');
ylabel('Ƶ��');
figure();
Leave_Gap = Leavetime(:,1) - Ave_Airuse - Ave_Wait;
histogram(Leave_Gap);
title('������ӵ�-����ʱ����ʧֱ��ͼ','Fontname','����','Fontsize',12);
xlabel('ʱ��(min)');
ylabel('Ƶ��');


TOTAL = sum(Waittime(:,1) < 16.238628114695985);
Rate = TOTAL/ (Wait_num-1);
