%�ڶ���������
    LastAngle=[];
for m_zhongwuqiu =3078:6000
for h = 0:0.00001:2
   % for h = 0:0.00001:1
    %waitbar(h);
    [phi_veritical,H,R]=H_zwq_mex(h,36,m_zhongwuqiu);
    %���LastAngleС��0˵����һ�ڵ�ê���ɳ�
    LastAngle = 90-phi_veritical(end);
    if abs(sum(H)-18)<0.01
        break
    end
end
    disp(m_zhongwuqiu)
if  LastAngle <= 16 && abs(phi_veritical(5)) < 5
    break
end
end
%disp(R)
disp(LastAngle)
%��ͼ����
x_vector=R';
x=cumsum(x_vector);
y_vector = H';
y=cumsum(y_vector);
y1=y(1:end-1);
plot(x,y,'LineWidth',1.2)
view(180,90)
ylabel('Deep')
xlabel('R')
grid on