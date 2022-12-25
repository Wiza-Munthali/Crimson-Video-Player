import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(_width, _height),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(FluentIcons.arrow_left_48_filled)),
            actions: [
              ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: ((context) => SimpleDialog(
                            titlePadding: const EdgeInsets.only(
                                bottom: 5, top: 20, left: 10),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(FluentIcons
                                    .document_bullet_list_24_regular),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "EULA",
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp),
                                )
                              ],
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Last updated: 24 November 2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""This End-User License Agreement (referred to as the "EULA") is a legally binding agreement between you, the Licensee, an individual customer or entity, and the Wiza Munthali, the company, and the author of Crimson Video Player, the Software, which may include associated media, printed materials, and online or electronic documentation. This Agreement is a legally binding contract that includes terms that limit your legal rights and Licensors' liability to you, and shall govern all access to and use of this Software. You hereby agree, without limitation or alteration, to all the terms and conditions contained herein.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""By installing, copying, or otherwise using the Licensed Product (Software), the Licensee agrees to be bound by the terms and conditions outlined in this EULA. However, if the Licensee does not agree to the terms and conditions outlined in this EULA, the said Licensee may not download, install, or use Software.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Definitions
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Definitions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r""""EULA" shall refer to this End-User-License-Agreement, including any amendment to this Agreement.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r""""Licensee" shall refer to the individual or entity that downloads and uses the Software.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r""""Licensor" shall refer to the company or author, Wiza Munthali, located at Blantyre, Malawi.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r""""Software/Licensed product" shall mean Crimson Video Player, the Licensed Product provided pursuant to this EULA.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Grant
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Grant of License",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Subject to the terms of this EULA, the Wiza Munthali hereby grants to the Licensee, a royalty-free, revocable, limited, non-exclusive license during the term of this EULA to possess and to use a copy of the Software. The Software is being distributed by Wiza Munthali. Licensee is not allowed to make a charge for distributing this Software, either for profit or merely to recover media and distribution costs.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Intellectual Property
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Intellectual Property",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""You hereby unconditionally agree that all right, title and interest in the copyrights and other intellectual property rights in the Licensed Product reside with the Licensors. The trademarks, logos, designs, and service marks appearing on the Licensed Product are registered and unregistered marks of Licensor.  Accordingly, nothing in this EULA or the Licensed Product grants you any right to use any form of intellectual property contained in the Licensed Product.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Therefore, all rights, titles, interests, and copyrights in and/or to the Software, including but not limited to all images, graphics, animations, audio, video, music, text, data, code, algorithm, and information, are owned by the Licensor. Accordingly, the Software is protected by all applicable copyright laws and international treaties, and the Licensee is expected to use the Software concerning all intellectual property contained therein, except as otherwise provided for in this EULA.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Description of Rights and Limitations
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Description of Rights and Limitations",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text.rich(TextSpan(
                                    text: r"""Installation and Use:""",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                                    children: [
                                      TextSpan(
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp),
                                          text:
                                              r""" Licensee may install and use the Software on a shared computer or concurrently on different computers, and make multiple back-up copies of the Software, solely for Licensee's use within Licensee's business or personal use.""")
                                    ])),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text.rich(
                                  TextSpan(
                                      text:
                                          r"""Reproduction and Distribution:""",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.sp),
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20.sp),
                                            text:
                                                r""" Licensee may not duplicate or re-distribute copies of the Software, without the Licensors express written permission. """)
                                      ]),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text.rich(
                                  TextSpan(
                                      text: r"""Licensee Limitation:""",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.sp),
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20.sp),
                                            text: r""" The Licensee may not:""")
                                      ]),
                                ),
                              ),

                              //Bullet points
                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""1. Use the Licensed Product for any purpose other than personal and non-commercial purposes;""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""2. Use the Licensed Product for any illegal or unlawful purpose;""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""3. Gather factual content or any other portion of the Licensed product by any automated means, including but not limited to database scraping or screen scraping; or""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""4. Reverse engineer, decompile, or disassemble Software, except and only to the extent that such activity is expressly permitted by applicable law notwithstanding the limitation.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Update and Maintenance
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Update and Maintenance",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Wiza Munthali shall provide updates and maintenance on a as-needed basis.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //General Provisions
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "General Provisions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Wiza Munthali has no obligation to Software support, or to continue providing or updating any of the Software.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //General Provisions
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Termination",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""In the event of termination, all licenses provided under this EULA shall immediately terminate, and you agree to discontinue accessing or attempting to access this Licensed product.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Accordingly, this EULA may be:""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Bullet points
                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""1. Automatically terminated if the Licensee fails to comply with any of the terms and conditions under this EULA;""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""2. Terminated by Wiza Munthali; or""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 10),
                                child: Text(
                                  r"""3. Terminated by the Licensee.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Either Wiza Munthali or the Licensee may terminate this EULA immediately upon written notice to the other party, including but not limited to electronic mail.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Non-Transferability""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""The Licensee has the option to permanently transfer all rights under this Agreement, provided the recipient agrees to the terms of this EULA. Accordingly, this EULA is not assignable or transferable by the Licensee without the prior written consent of Wiza Munthali; and any attempt to do so shall be void.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Notice
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Notice",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Any notice, report, approval or consent required under this EULA shall be in writing and deemed to have been duly given if delivered by recorded delivery to the respective addresses of the parties.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Integration
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Integration",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Both parties hereby agree that this EULA is the entire and exclusive statement and legal acknowledgement of the mutual understanding of the parties and supersedes and cancels any previous written and oral agreement and/or communication relating to the subject matter of this EULA.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Severability
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Severability",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""No delay or failure to exercise, on the part of either party, any privilege, power or rights under this EULA shall operate as a waiver of any of the terms and provisions of this EULA. Accordingly, no single or partial exercise of any right under this Agreement shall preclude further exercise of any other right under this EULA. Suppose any of the outlined provisions of this EULA is deemed to be unenforceable or invalid in whole or in part by a court of competent jurisdiction. In that case, such provision shall be limited to the minimum extent necessary for this EULA to remain in full force and effect and enforceable. The remaining provisions of this Agreement shall not be rendered unenforceable or invalid. They shall continue to be enforceable and valid in isolation of the unenforceable and invalid provisions of this EULA.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Warranty and Disclaimer
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Warranty and Disclaimer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""Wiza Munthali, and author of this Software, expressly disclaim any warranty for the Crimson Video Player. The Licensed Product and all applicable documentation is provided as-is, without warranty of any kind, whether express or implied, including, without limitation, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement. Accordingly, the Licensee accepts any risk arising out of the use or performance of the Software.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Limited Liability
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Limited Liability",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""The Licensee agrees that Wiza Munthali shall not be liable to Licensee, or any other related person or entity claiming any loss of profits, income, savings, or any other consequential, incidental, special, punitive, direct or indirect damage, whether arising in contract, tort, warranty, or otherwise. Even if Wiza Munthali has been advised of the possibility of such damages. These limitations shall necessarily apply regardless of the primary purpose of any limited remedy. Under no circumstances shall Wiza Munthali aggregate liability to the Licensee, or any other person or entity claiming through the Licensee, exceed the actual monetary amount paid by the Licensee to Wiza Munthali for the Software.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Indemnification
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Indemnification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""You hereby agree to indemnify and hold Wiza Munthali harmless from and against all liabilities, damages, losses or expenses, including but not limited to reasonable attorney or other professional fees in any claim, demand, action or proceeding initiated by any third-party against Wiza Munthali, arising from any of your acts, including without limitation, violating this EULA or any other agreement or any applicable law.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Entire Agreement
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Entire Agreement",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""This Agreement rightly constitutes the entire understanding between the Wiza Munthali and the Licensee and all parties involved. It supersedes all prior agreements of the parties, whether written or oral, express or implied, statement, condition, or a representation or warranty.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),

                              //Governing Law and Jurisdiction
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  "Governing Law and Jurisdiction",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22.sp),
                                ),
                              ),

                              //Text
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Text(
                                  r"""This EULA shall be deemed to be construed under the jurisdiction of the courts located in Malawi, without regard to conflicts of laws as regards the provisions thereof. Any legal action relating to this EULA shall be brought exclusively in the courts of Malawi, and all parties consent to the jurisdiction thereof. Furthermore, the prevailing party in any action to enforce this EULA shall be entitled to recover costs and expenses including, without limitation, legal fees. Accordingly, this EULA is made within the exclusive jurisdiction of the Malawi, and its jurisdiction shall supersede any other jurisdiction of either party's election.""",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                          ))),
                  child: Row(
                    children: [
                      Icon(FluentIcons.document_bullet_list_24_regular),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text("License")
                    ],
                  )),
            ],
          ),
          body: Center(
            child: Container(
              height: _height,
              width: _width,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Container(
                  height: _height,
                  width: _width - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image/logo.png',
                              height: 200.h,
                              width: 200.w,
                            ),
                            Text(
                              "Crimson Video Player",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 48.sp, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Crimson video player is a free open source video player, made by Wiza Munthali",
                                style: TextStyle(fontSize: 24.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Crimson video player supports all video formats and is based on popular video playing platforms to combine all the beloved features",
                                style: TextStyle(fontSize: 24.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
