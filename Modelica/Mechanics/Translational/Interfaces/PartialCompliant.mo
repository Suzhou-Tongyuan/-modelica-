within Modelica.Mechanics.Translational.Interfaces;
partial model PartialCompliant 
  "两个一维平动接口的弹性连接"
  extends Translational.Interfaces.PartialTwoFlanges;
  SI.Position s_rel(start=0) 
    "相对距离 (= flange_b.s - flange_a.s)";
  SI.Force f 
    "一维平动之间的力 (沿一维平动轴向正向为正)";

equation
  s_rel = flange_b.s - flange_a.s;
  flange_b.f = f;
  flange_a.f = -f;
  annotation (Documentation(info="<html><p>
这是一个具有两个一维平动的弹性连接的一维传动组件，其中两个一维平动之间的惯性效应不包括在内。 左右一维平动上力的绝对值相同。它可用于建立弹簧、阻尼器等。
</p>
</html>"));
end PartialCompliant;