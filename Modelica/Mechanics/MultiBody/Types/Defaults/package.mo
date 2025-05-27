within Modelica.Mechanics.MultiBody.Types;
package Defaults "通过常量设置MultiBody库的默认设置"
  extends Modelica.Icons.Package;

  // 颜色默认值
  constant Types.Color BodyColor = {0, 128, 255} "具有质量的物体形状的默认颜色(浅蓝色)";
  constant Types.Color RodColor = {155, 155, 155} "无质量杆形状的默认颜色(灰色)";
  constant Types.Color JointColor = {255, 0, 0} "基本关节的默认颜色(红色)";
  constant Types.Color ForceColor = {0, 128, 0} "力箭头的默认颜色(深绿色)";
  constant Types.Color TorqueColor = {0, 128, 0} "扭矩箭头的默认颜色(深绿色)";
  constant Types.Color SpringColor = {0, 0, 255} "弹簧的默认颜色(蓝色)";
  constant Types.Color SensorColor = {255, 255, 0} "传感器的默认颜色(黄色)";
  constant Types.Color FrameColor = {0, 0, 0} "坐标系轴和标签的默认颜色(黑色)";
  constant Types.Color ArrowColor = {0, 0, 255} "箭头和双箭头的默认颜色(蓝色)";

  // 箭头和坐标系默认值
  constant Real FrameHeadLengthFraction = 5.0 
    "坐标系箭头头部长度/箭头直径";
  constant Real FrameHeadWidthFraction = 3.0 
    "坐标系箭头头部宽度/箭头直径";
  constant Real FrameLabelHeightFraction = 3.0 
    "坐标系标签的高度/箭头直径";
  constant Real ArrowHeadLengthFraction = 4.0 
    "箭头头部长度/箭头直径";
  constant Real ArrowHeadWidthFraction = 3.0 
    "箭头头部宽度/箭头直径";

  // 其他默认值
  constant Real BodyCylinderDiameterFraction = 3 
    "构件圆柱直径的默认值，作为构件球直径的一部分";
  constant Real JointRodDiameterFraction = 2 
    "杆直径的默认值，作为连接到杆的关节球直径的一部分";

  /*
  constant Real N_to_m(unit="N/m") = 1000
  "默认力箭头比例(长度=力/N_to_m_default)";
  constant Real Nm_to_m(unit="N.m/m") = 1000
  "默认扭矩箭头比例(长度=扭矩/Nm_to_m_default)";
  */
  annotation(Documentation(info = "<html>
<p>
该包含常量用作MultiBody库的默认设置。
</p>
</html>"));
end Defaults;