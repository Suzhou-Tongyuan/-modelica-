within Modelica.Mechanics.MultiBody.Types;
type Color = Modelica.Icons.TypeInteger[3] (each min=0, each max=255) 
   "颜色的RGB表示" 
  annotation (
    Dialog(colorSelector=true), 
    choices(
      choice={0,0,0} "{0,0,0}       \"黑色\"", 
      choice={155,0,0} "{155,0,0}     \"深红色\"", 
      choice={255,0,0} "{255,0,0}    \"红色\"", 
      choice={255,65,65} "{255,65,65}   \"浅红色\"", 
      choice={0,128,0} "{0,128,0}     \"深绿色\"", 
      choice={0,180,0} "{0,180,0}     \"绿色\"", 
      choice={0,230,0} "{0,230,0}     \"浅绿色\"", 
      choice={0,0,200} "{0,0,200}     \"深蓝色\"", 
      choice={0,0,255} "{0,0,255}     \"蓝色\"", 
      choice={0,128,255} "{0,128,255}   \"浅蓝色\"", 
      choice={255,255,0} "{255,255,0}   \"黄色\"", 
      choice={255,0,255} "{255,0,255}   \"粉红色\"", 
      choice={100,100,100} "{100,100,100} \"深灰色\"", 
      choice={155,155,155} "{155,155,155} \"灰色\"", 
      choice={255,255,255} "{255,255,255} \"白色\""), 
  Documentation(info="<html>
<p>
类型 <strong>Color</strong> 是一个具有3个元素的整数向量，{r, g, b}，指定了形状的颜色。
{r, g, b} 分别是 \"红色\"、\"绿色\" 和 \"蓝色\" 的颜色部分。
注意，r、g 和 b 的取值范围为 0&nbsp;&hellip;&nbsp;255。
</p>
</html>"));