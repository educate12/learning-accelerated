import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CongratsWidget extends StatefulWidget {
  const CongratsWidget({Key? key}) : super(key: key);

  @override
  _CongratsWidgetState createState() => _CongratsWidgetState();
}

class _CongratsWidgetState extends State<CongratsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'congrats'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/createAccount_bg@2x.png',
                      ).image,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Congrats!',
                            style: FlutterFlowTheme.of(context).title2.override(
                                  fontFamily: 'Outfit',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: Text(
                          'You have successfully created an account, please remember you can use this account to log into any etwelve app or website, we use the same database, so you don\'t need to create a new account.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0.55),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'CONGRATS_COMPLETE_PROFILE_BTN_ON_TAP');
                              logFirebaseEvent('Button_Navigate-To');

                              context.pushNamed(
                                'home',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 100),
                                  ),
                                },
                              );
                            },
                            text: 'Complete Profile',
                            options: FFButtonOptions(
                              width: 170,
                              height: 50,
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF39D2C0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
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
    );
  }
}
