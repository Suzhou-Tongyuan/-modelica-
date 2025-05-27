within Modelica.Utilities;
package Types "Modelica.Utilities包中用到的类型定义"
  extends Modelica.Icons.TypesPackage;
  type Compare = enumeration(
      Less "String 1 is lexicographically less than string 2", 
      Equal "String 1 is identical to string 2", 
      Greater "String 1 is lexicographically greater than string 2") 
    "定义两个字符串比较的枚举" annotation();

  type FileType = enumeration(
      NoFile "没有文件存在", 
      RegularFile "常规文件", 
      Directory "目录", 
      SpecialFile "特殊文件(管道、FIFO、设备等))") 
    "定义文件类型的枚举" annotation();

  type TokenType = enumeration(
      RealToken, 
      IntegerToken, 
      BooleanToken, 
      StringToken, 
      IdentifierToken, 
      DelimiterToken, 
      NoToken) "定义令牌类型的枚举" annotation();

  record TokenValue "令牌值"
     extends Modelica.Icons.Record;
     TokenType tokenType "令牌类型";
     Real real "如果tokenType == TokenType.RealToken时的值";
     Integer integer "如果tokenType == TokenType.IntegerToken时的值";
     Boolean boolean "如果tokenType == TokenType.BooleanToken时的值";
     String string 
      "如果tokenType == TokenType.StringToken/IdentifierToken/DelimiterToken时的值";
    annotation (Documentation(info="<html>

</html>"  ));
  end TokenValue;
  annotation (Documentation(info="<html>
<p>
中使用的类型定义 Modelica.Utilities.
</p>

</html>"));
end Types;