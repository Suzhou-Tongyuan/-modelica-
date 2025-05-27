within Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities;
function theoreticalNormalGravityWGS84 
  "WGS84椭球体上的地球法线重力在负y方向上"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
  input Modelica.Units.NonSI.Angle_deg phi 
    "地面维度" annotation(Dialog);
protected
  constant SI.Position a = 6378137.0 
    "地球椭球的长半轴";
  constant SI.Position b = 6356752.3142 
    "地球椭球的短半轴";
  constant SI.AngularAcceleration g_e = 9.7803253359 
    "赤道处的理论重力加速度";
  constant SI.AngularAcceleration g_p = 9.8321849378 
    "极地处的理论重力加速度";
  constant Real k = (b / a) * (g_p / g_e) - 1;

  constant Real e2 = (8.1819190842622e-2) ^ 2 
    "第一椭球偏心率的平方";
  constant Real f = 1 / 298.257223563 "椭球扁率";
  constant SI.AngularVelocity w = 7292115e-11 
    "地球的角速度";
  constant Real GM(unit = "m3/s2") = 3986004.418e8 
    "地球的引力常数";
  constant Real m(unit = "1") = w ^ 2 * a ^ 2 * b / GM;
  Real sinphi2(unit = "1");
  SI.AngularAcceleration gn 
    "地球椭球体上的标准重力加速度";
  SI.AngularAcceleration gh 
    "地球椭球体上高度为h处的标准重力加速度";
  SI.Position h "相对于WGS84地球椭球体的高度";
  Real ha(unit = "1") "h/a";
algorithm
  h := r[2];
  sinphi2 := Modelica.Math.sin(Modelica.Units.Conversions.from_deg(phi)) ^ 2;
  gn := g_e * (1 + k * sinphi2) / sqrt(1 - e2 * sinphi2);
  ha := h / a;
  gh := gn * (1 - ha * (2 * (1 + f + m - 2 * f * sinphi2) + 3 * ha));
  gravity := {0, -gh, 0};
  annotation(Documentation(info = "<html><p>
计算给定\"geodticLatitude\"和给定在椭球体表面上的\"height=r[2]\"处的<a href=\"https://earth-info.nga.mil/GandG/publications/tr8350.2/wgs84fin.pdf\" target=\"\">WGS84 ellipsoid earth model</a>的理论重力的函数
</p>
</html>"));
end theoreticalNormalGravityWGS84;