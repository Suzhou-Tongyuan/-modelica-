within Modelica.Electrical.QuasiStatic.Types;
record Reference "参考角度"
  SI.Angle gamma;
  function equalityConstraint "参考角度的等式约束"
    input Reference reference1;
    input Reference reference2;
    output Real residue[0];
  algorithm
    assert(abs(reference1.gamma - reference2.gamma) < 1E-6*2*Modelica.Constants.pi, 
      "参考角度应该相等！");
    annotation (Documentation(info="<html>
参考角度的等式约束，根据 Modelica 3.4 规范的<a href=\"https://specification.modelica.org/v3.4/Ch9.html#equation-operators-for-overconstrained-connection-based-equation-systems1\">第9.4节（用于过约束基于连接的方程系统的等式运算符）</a>。
</html>"));
  end equalityConstraint;
  annotation (Documentation(info="<html>
参考角度，在准静态交流连接器中使用。
</html>"));
end Reference;