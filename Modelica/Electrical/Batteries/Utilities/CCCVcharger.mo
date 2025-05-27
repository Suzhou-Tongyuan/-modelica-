within Modelica.Electrical.Batteries.Utilities;
model CCCVcharger 
  "具有恒定电流-恒定电压特性的充电器"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current I "恒定充电电流";
  parameter SI.Time startTime=0 "开始充电时间";
  parameter SI.Time rampTime=60 "充电电流斜坡时间";
  parameter SI.Voltage Vend "充电结束电压";
  Boolean CV(start=false, fixed=true) "表示恒定电压充电";
equation
  CV=v>=Vend;
  if CV then
    v=Vend;
  else
    i = -I*(if time<startTime then 0 else min(1,(time - startTime)/rampTime));
  end if;
  annotation (defaultComponentName="cccvCharger", 
    Icon(graphics={   Rectangle(
        extent={{-100,-100},{100,100}}, 
        lineColor={0,0,127}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}}, 
        textString="%name", 
        textColor={0,0,255}), 
        Polygon(
          points={{20,80},{-50,-20},{0,-20},{-20,-80},{50,20},{0,20},{20,80}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
理想充电器，从恒定电流切换到恒定电压特性。
</p>
</html>"));
end CCCVcharger;