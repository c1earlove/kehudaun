import 'package:flutter/material.dart';
import 'package:yt_client_flutter/main.dart';
import 'package:yt_client_flutter/main_page.dart';
import 'package:yt_client_flutter/utils/color_util.dart';
import 'package:yt_client_flutter/utils/desktop_screen_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.red,
        image: DecorationImage(
          image: AssetImage("assets/images/login_background@1x.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          header(),
          Expanded(child: Content()),
          footer(),
        ],
      ),
    );
  }
}

Widget header() {
  return Container(
    padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Image.asset('assets/images/logo@2x.png', height: 17)],
    ),
  );
}

Widget footer() {
  return Stack(
    alignment: AlignmentGeometry.center,
    children: [
      Container(
        // color: Colors.blue.withOpacity(0.2), // 背景色（带透明度）
        // 可选：添加圆角/边框增强样式
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.black12,
          // borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.blue, width: 1),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(
          screenUtil.wp(68),
          0,
          screenUtil.wp(92),
          0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/gonggao@2x.png', width: 28),
                Text(
                  '消息推送：上海屹通网银客户端全新升级……',
                  style: TextStyle(
                    color: ColorUtils.fromHex('#627087'),
                    fontSize: screenUtil.sp(22),
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/phone@2x.png', width: 28),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '服务热线：',
                        style: TextStyle(
                          color: ColorUtils.fromHex('#627087'),
                          fontSize: screenUtil.sp(22),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      TextSpan(
                        text: ' 021-63093688 ',
                        style: TextStyle(
                          color: ColorUtils.fromHex('#627087'),
                          fontSize: screenUtil.sp(32),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class Content extends StatelessWidget {
  const Content({super.key});

  void _goWeb(BuildContext context) {
    // 核心：Navigator.push 跳转页面
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(left: 195, right: 147),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenUtil.wp(536),
            height: screenUtil.hp(400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/login_version@2x.png',
                  height: screenUtil.hp(55),
                ),
                Text(
                  '欢迎使用\n上海屹通网银客户端',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: screenUtil.sp(56),
                    color: ColorUtils.fromHex('#040911'),
                  ),
                ),
                Text(
                  '更安全/更便捷/更高效，全面检测网银环境，一键修复多种问题',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: screenUtil.sp(24),
                    color: Colors.grey,
                  ),
                ),
                Image.asset(
                  'assets/images/login_qa@2x.png',
                  height: screenUtil.hp(30),
                ),
              ],
            ),
          ),
          Container(
            height: screenUtil.hp(400),
            width: screenUtil.wp(460),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '网银登录入口 ',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: screenUtil.sp(22),
                    color: ColorUtils.fromHex('#627087'),
                  ),
                ),
                HoverButton(
                  title: '企业网银',
                  imageSrc: 'assets/images/login_qiye@2x.png',
                  hoverGradient: LinearGradient(
                    colors: [
                      ColorUtils.fromHex('#74BFFE'),
                      ColorUtils.fromHex('#376BFD'),
                    ],
                  ),
                  normalGradient: LinearGradient(
                    colors: [
                      ColorUtils.fromHex('#D0DCF1'),
                      ColorUtils.fromHex('#D0DCF1'),
                    ],
                  ),
                  onPressed: () => _goWeb(context),
                ),
                HoverButton(
                  title: '个人网银',
                  imageSrc: 'assets/images/login_person@2x.png',
                  hoverGradient: LinearGradient(
                    colors: [
                      ColorUtils.fromHex('#74BFFE'),
                      ColorUtils.fromHex('#376BFD'),
                    ],
                  ),
                  normalGradient: LinearGradient(
                    colors: [
                      ColorUtils.fromHex('#D0DCF1'),
                      ColorUtils.fromHex('#D0DCF1'),
                    ],
                  ),
                ),
                // goButton(
                //   imageSrc: 'assets/images/login_person@2x.png',
                //   text: '企业网银',
                //   onClick: () {
                //     _goWeb(context);
                //   },
                // ),
                // goButton(
                //   imageSrc: 'assets/images/login_qiye@2x.png',
                //   text: '个人网银',
                // ),
              ],
            ),
          ),
        ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     SizedBox(
      //       height: screenUtil.hp(400),
      //       width: screenUtil.wp(536),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Image.asset('assets/images/login_version@2x.png', height: 55),
      //           const Text('欢迎使用\n上海屹通网银客户端', style: TextStyle(fontSize: 28)),
      //           const Text(
      //             '更安全/更便捷/更高效，全面检测网银环境，一键修复多种问题',
      //             style: TextStyle(fontSize: 14, color: Colors.grey),
      //           ),
      //           Image.asset('assets/images/login_qa@2x.png', height: 30),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       height: screenUtil.hp(400),
      //       width: screenUtil.wp(460),
      //       decoration: const BoxDecoration(
      //         color: Color.fromRGBO(255, 255, 255, 0.3),
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(8),
      //           bottomLeft: Radius.circular(8),
      //           topRight: Radius.circular(100),
      //           bottomRight: Radius.circular(8),
      //         ),
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           const Text('网银登录入口 '),
      //           goButton(
      //             imageSrc: 'assets/images/login_person@2x.png',
      //             text: '个人网银',
      //             onClick: () {
      //               _goWeb(context);
      //             },
      //           ),
      //           goButton(
      //             imageSrc: 'assets/images/login_qiye@2x.png',
      //             text: '企业网银',
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

Widget goButton({
  required String imageSrc,
  required String text,
  VoidCallback? onClick,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onClick,
    child: Container(
      margin: const EdgeInsets.only(left: 36, right: 48),
      padding: const EdgeInsets.only(left: 10, right: 30, top: 25, bottom: 25),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(208, 220, 241, 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageSrc, width: 52),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenUtil.sp(20),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          Image.asset('assets/images/jt-l@2x.png', width: 50),
        ],
      ),
    ),
  );
}

class HoverButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final String imageSrc;
  // 必传参数：正常态渐变色
  final Gradient normalGradient;
  // 必传参数：hover态渐变色
  final Gradient hoverGradient;

  const HoverButton({
    super.key,
    required this.title,
    this.onPressed,
    required this.imageSrc,
    required this.normalGradient,
    required this.hoverGradient,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isMouseHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isMouseHover = true;
      }),
      onExit: (event) => setState(() {
        _isMouseHover = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Container(
          margin: const EdgeInsets.only(left: 36, right: 48),
          padding: const EdgeInsets.only(
            left: 10,
            right: 30,
            top: 25,
            bottom: 25,
          ),
          decoration: BoxDecoration(
            gradient: _isMouseHover
                ? widget.hoverGradient
                : widget.normalGradient,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(widget.imageSrc, width: 52),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: _isMouseHover ? Colors.white : ColorUtils.fromHex('#1F314F'),
                      fontSize: screenUtil.sp(20),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Image.asset('assets/images/jt-l@2x.png', width: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// Image.network("https://image.baidu.com/front/aigc?atn=aigc&fr=home_hover&imgcontent=%7B%22aigcQuery%22%3A%22%22%2C%22imageAigcId%22%3A%22%22%7D&isImmersive=1&pd=image_content&quality=1&ratio=4%3A3&sa=searchpromo_shijian_photohp_inspire&tn=aigc&top=%7B%22sfhs%22%3A1%7D&word=身穿丝绸的美女，魔幻电影，浓密的头发，神秘的咖啡店，8k超高清，大师级作品，优雅、全球照明，魔幻电影照明，3d渲染的高品质魔幻电影，咖啡店，8k，高品质，高清，更多细节，电影打光，神秘，多细节，水晶"
