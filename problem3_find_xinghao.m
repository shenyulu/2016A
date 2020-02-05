%��������Ѱ�ͺ����������������޸Ĳ�����
    clear
clc
x=[];
h_deep_ocean = 18;
    %l_maolian=78*10^(-3),105*10^(-3),120*10^(-3),150*10^(-3),180*10^(-3)
    l_maolian=105*10^(-3);
    %m_maolian_for_everymile=3.2, 7, 12.5, 19.5, 28.12
    m_maolian_for_everymile=7;
for h = 0:0.00001:1
    [phi_veritical,H,R]=H_water_force_mex(h,36,1.5,l_maolian,m_maolian_for_everymile,4996,22.05);
    if abs(sum(H)-h_deep_ocean)<0.01
        break
    end
    x=[x;h,sum(H)];
end
 disp(h)
%disp(R)
%���LastAngleС��0˵����һ�ڵ�ê���ɳ�
LastAngle = 90-phi_veritical(end);
disp(LastAngle)
%��ͼ����
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
