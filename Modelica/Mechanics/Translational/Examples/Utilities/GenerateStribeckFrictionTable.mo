within Modelica.Mechanics.Translational.Examples.Utilities;
function GenerateStribeckFrictionTable 
  "生成 Stribeck 摩擦表，例如 SupportFriction 的摩擦数据"
  extends Modelica.Icons.Function;
  input Real F_prop(final unit="N.s/m", final min=0) 
    "速度相关的摩擦系数";
  input SI.Force F_Coulomb 
    "常数摩擦：库仑摩擦力";
  input SI.Force F_Stribeck "Stribeck 效应";
  input Real fexp(final unit="s/m", final min=0) "指数衰减";
  input Real v_max "从 v=0 ... v_max 生成表";
  input Integer nTable(min=2) = 100 "表格点数";
  output Real table[nTable, 2] "摩擦表";
algorithm
  for i in 1:nTable loop
    table[i, 1] := v_max*(i - 1)/(nTable - 1);
    table[i, 2] := F_Coulomb + F_prop*table[i, 1] + F_Stribeck*Modelica.Math.exp(-fexp* 
      table[i, 1]);
  end for;
  annotation (Documentation(info="<html>
<p>
返回摩擦特性的表格
table[nTable,&nbsp;2]&nbsp;=&nbsp;[0,&nbsp;f1;&nbsp;&hellip;;&nbsp;v_max,&nbsp;fn]，
其中第一列是速度&nbsp;v，范围是 0&nbsp;&hellip;&nbsp;v_max，
第二列是根据 Stribeck 曲线的摩擦力：
</p>

<blockquote><pre>
f = F_Coulomb + F_prop*v + F_Stribeck*exp(-fexp*v);
</pre></blockquote>
</html>"));
end GenerateStribeckFrictionTable;