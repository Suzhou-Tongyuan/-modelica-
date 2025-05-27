within Modelica.Mechanics.MultiBody.Types;
type RotationSequence = Modelica.Icons.TypeInteger[3] (min={1,1,1}, max={3,3,3}) 
  "带有选择的平面框架旋转序列" annotation (
  preferredView="text", 
  Evaluate=true, 
  choices(
    choice={1,2,3} "{1,2,3} \"Cardan/Tait-Bryan 角度\"", 
    choice={3,1,3} "{3,1,3} \"欧拉角\"", 
    choice={3,2,1} "{3,2,1}"));