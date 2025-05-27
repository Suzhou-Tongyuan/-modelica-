within Modelica.Mechanics.MultiBody.Types;
type ResolveInFrameB = enumeration(
    world "在全局坐标系中解析", 
    frame_b "在frame_b中解析", 
    frame_resolve 
      "在frame_resolve中解析(必须连接frame_resolve)") 
  "用于定义绝对矢量在哪个坐标系中解析的枚举类型(全局坐标系、frame_b、frame_resolve)" 
                                             annotation (Documentation(info="<html>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_b</td>
<td>在frame_b中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve中解析矢量(必须连接frame_resolve)</td></tr>
</table>
</html>"));