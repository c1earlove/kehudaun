import 'package:flutter/material.dart';

/// 桌面端通用 hover 切换背景按钮
class CommonHoverBgButton extends StatefulWidget {
  // 必传参数：正常背景图片
  final ImageProvider normalBg;
  // 必传参数：hover背景图片
  final ImageProvider hoverBg;
  // 可选参数：按钮宽度
  final double width;
  // 可选参数：按钮高度
  final double height;
  // 可选参数：按钮文字
  final String text;
  // 可选参数：点击事件
  final VoidCallback? onTap;
  // 可选参数：文字样式
  final TextStyle? textStyle;
  // 可选参数：按钮圆角
  final double borderRadius;

  const CommonHoverBgButton({
    super.key,
    required this.normalBg,
    required this.hoverBg,
    this.width = 120,
    this.height = 48,
    this.text = "按钮",
    this.onTap,
    this.textStyle,
    this.borderRadius = 8,
  });

  @override
  State<CommonHoverBgButton> createState() => _CommonHoverBgButtonState();
}

class _CommonHoverBgButtonState extends State<CommonHoverBgButton> {
  bool _isMouseHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isMouseHover = true),
      onExit: (event) => setState(() => _isMouseHover = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            image: DecorationImage(
              image: _isMouseHover ? widget.hoverBg : widget.normalBg,
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            widget.text,
            style:
                widget.textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
