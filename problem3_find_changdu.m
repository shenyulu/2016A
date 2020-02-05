%第三问搜寻长度主程序（依据需求修改参数）
clear
clc
x=[];
h_deep_ocean = 20;
    %l_maolian=78*10^(-3),105*10^(-3),120*10^(-3),150*10^(-3),180*10^(-3)
    l_maolian=180*10^(-3);
    %m_maolian_for_everymile=3.2, 7, 12.5, 19.5, 28.12
    m_maolian_for_everymile=28.12;
for h = 0:0.0001:2
    waitbar(h/2);
    [phi_veritical,H,R]=H_water_force_mex(h,36,1.5,l_maolian,m_maolian_for_everymile,4996,25.2);
    if abs(sum(H)-h_deep_ocean)<0.01
        break
    end
    x=[x;h,sum(H)];
end
 disp(h)
%disp(R)
%如果LastAngle小于0说明这一节的锚链松弛
LastAngle = 90-phi_veritical(end);
disp(LastAngle)
%作图部分
x_vector=R';
x=cumsum(x_vector);
y_vector = H';
y=cumsum(y_vector);
y1=y(1:end-1);
plot(x,y1,'LineWidth',1.2)
view(180,90)
ylabel('Deep')
xlabel('R')
grid on
R_total = sum(R);