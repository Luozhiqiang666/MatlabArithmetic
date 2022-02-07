clear;
clc;
%% 绘制函数的图形
x = -3:0.1:3;
y = 11*sin(x) + 7*cos(5*x);
figure
plot(x,y,'b-')
hold on  % 不关闭图形，继续在上面画图










%模拟退火算法
%%参数设置
T = 100;        %初始温度
times = 200;        %迭代次数
Lk = 100;  % 每个温度下的迭代次数
alpha = 0.95;   %温度衰减系数
x_lb = -3; % x的下界
x_ub = 3; % x的上界

maxY = zeros(1);
maxX = zeros(1);
%%生成初始值
%xi = x_lb + (x_ub-x_lb)*rand();
xi = 2.5;
yi = F(xi);
%画图部分
hx = scatter(xi,yi,'*r');  % scatter是绘制二维散点图的函数（这里返回h是为了得到图形的句柄，未来我们对其位置进行更新）
hm = scatter(maxX,maxY,'or');

xj = zeros(1);
yj =zeros(1);
%%迭代
%disp("xi:"+xi);
%disp("*****************************************");
for t=1:times
    %外循环
    for i=1:Lk      
        %内循环
        
        %%生成新解
        new_x = xi+randn()*T;   
        
        if new_x < x_lb 
            r = rand();
            new_x = r*xi + (1-r)*x_lb;
        elseif new_x > x_ub
            r = rand();
            new_x = r*xi +(1-r)*x_ub;
        end
        
        xj = new_x;
        yj = F(xj);
        %%判断新解是否接受
        if yj>=yi
            xi = xj;
            yi = yj;
        else
            if rand() < exp( -(abs(yi - yj)/T) )
                xi = xj;
                yi = yj;
            end
        end
        
        %判断和更改最大值
        if yi > maxY
            maxY = yi;
            maxX = xi;
        end
        
        hx.XData = xi;
        hx.YData = yi;
        
        hm.XData = maxX;
        hm.YData = maxY;
        pause(0.005);
    end
    
    T = T*alpha;    %降低温度
    disp(T);
    %disp("maxY:"+maxY);
    %disp("*****************************************");
end
disp("Final Resual:");
disp("("+maxX+","+maxY+")");