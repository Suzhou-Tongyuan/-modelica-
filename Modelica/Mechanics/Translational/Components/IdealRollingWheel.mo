within Modelica.Mechanics.Translational.Components;
model IdealRollingWheel 
  "简单的不考虑惯性的理想滚动轮的一维模型"
  extends Modelica.Mechanics.Rotational.Components.IdealRollingWheel;
  annotation (
    Documentation(info="<html>
<p>将转动和平动耦合在一起，就像一个理想的滚动轮一样，指定了车轮半径。</p>
</html>"));
end IdealRollingWheel;