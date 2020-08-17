function J = CostFunction (x)
kp=x(1);    ki=x(2);    kd=x(3);
csvwrite('kp.dat',kp);  csvwrite('ki.dat',ki);  csvwrite('kd.dat',kd);
sim('Tugas4_07111740000034.slx')
% Cost function based on ISE, IAE and ITAE
w1 = 0.6; w2 = 0.1; w3 = 0.3;
ISE=w1*sum((err.signals.values).^2);
IAE=w2*sum(abs(err.signals.values));
ITAE=w3*sum(err.time.*abs(err.signals.values));
J = ISE + IAE + ITAE;
end