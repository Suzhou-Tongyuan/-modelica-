within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model Generic "部分特利宁滞后模型"
  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  // 固定几何群（长方体）
  parameter SI.Length l=0.1 "通量方向上的长度" annotation (Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Interfaces/GenericParallelFlux.png"));

  parameter SI.Area A=1e-4 "横截面面积" annotation (Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericParallelFlux.png"));
  final parameter SI.Volume V = A * l "通量管道体积";
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}),Documentation(info="<html>
</html>"));
end Generic;