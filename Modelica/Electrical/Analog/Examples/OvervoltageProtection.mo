within Modelica.Electrical.Analog.Examples;
model OvervoltageProtection "Zener二极管示例"
  extends Modelica.Icons.Example;

 Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
   offset=0, 
   V=10, 
   f=5) annotation (Placement(transformation(
       extent={{-10,-10},{10,10}}, 
       rotation=270, 
       origin={-66,6})));
 Modelica.Electrical.Analog.Basic.Resistor Rv(R=20) 
   annotation (Placement(transformation(extent={{-56,32},{-36,52}})));
 Modelica.Electrical.Analog.Basic.Resistor RL(R=2000) annotation (Placement(
       transformation(
       extent={{-10,-10},{10,10}}, 
       rotation=270, 
       origin={26,4})));
 Modelica.Electrical.Analog.Basic.Ground ground 
   annotation (Placement(transformation(extent={{-30,-82},{-10,-62}})));
 Modelica.Electrical.Analog.Basic.Capacitor CL(C=1e-7, v(start=0, fixed=true)) annotation (Placement(
       transformation(
       extent={{-10,-10},{10,10}}, 
       rotation=270, 
       origin={62,4})));
  Semiconductors.ZDiode zDiode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,-20})));
  Semiconductors.ZDiode zDiode1(v(start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-20,22})));
equation
 connect(sineVoltage.p, Rv.p) annotation (Line(
     points={{-66,16},{-66,42},{-56,42}}, color={0,0,255}));
 connect(RL.p, CL.p) annotation (Line(
     points={{26,14},{62,14}}, color={0,0,255}));
 connect(RL.n, CL.n) annotation (Line(
     points={{26,-6},{62,-6}}, color={0,0,255}));
  connect(sineVoltage.n, zDiode.p) annotation (Line(
      points={{-66,-4},{-66,-30},{-20,-30}}, color={0,0,255}));
  connect(zDiode.p, ground.p) annotation (Line(
      points={{-20,-30},{-20,-62}}, color={0,0,255}));
  connect(zDiode.p, RL.n) annotation (Line(
      points={{-20,-30},{26,-30},{26,-6}}, color={0,0,255}));
  connect(zDiode1.p, Rv.n) annotation (Line(
      points={{-20,32},{-20,42},{-36,42}}, color={0,0,255}));
  connect(RL.p, Rv.n) annotation (Line(
      points={{26,14},{26,42},{-36,42}}, color={0,0,255}));
  connect(zDiode1.n, zDiode.n) annotation (Line(
      points={{-20,12},{-20,1},{-20,1},{-20,-10}}, color={0,0,255}));
 annotation (experiment(StopTime=0.4), 
   Documentation(info="<html>
<p>该示例是一个简单的过压保护电路。如果电压zDiode_1.n.v太高，二极管Diode zDiode_2就会被击穿。</p>
<p>该示例的仿真时长为0.4秒。用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看示例中sineVoltage.p.v、RL.p.v、zDiode_2.n.v和zDiode_1.n.i的图像。</p>
</html>",revisions="<html>
<ul>
<li><em>2009/1/2</em>
       Kristin Majetta<br>
       添加说明文档</li>
<li><em>2009/1/8   </em>
        Matthias Franke<br>创建
       </li>
</ul>
</html>"));
end OvervoltageProtection;