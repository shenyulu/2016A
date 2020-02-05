%第一问主程序
x=[];
for h = 0:0.00001:1
    [phi_veritical,H,R]=H_cal(h,24);
    disp(h)
    if abs(sum(H)-18)<0.01
        break
    end
    x=[x;h,sum(H)];
end
disp(R)
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