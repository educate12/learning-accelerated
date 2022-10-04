import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding3Widget extends StatefulWidget {
  const Onboarding3Widget({Key? key}) : super(key: key);

  @override
  _Onboarding3WidgetState createState() => _Onboarding3WidgetState();
}

class _Onboarding3WidgetState extends State<Onboarding3Widget> {
  TextEditingController? textController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Onboarding3'});
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.arrow_back_ios,
          color: FlutterFlowTheme.of(context).primaryColor,
          size: 24,
        ),
        title: Text(
          'Grade',
          style: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Ubuntu',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 20,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
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
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'This program is not available for all Grades yet.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'This will be used for your application.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Ubuntu',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Form(
                                      key: formKey,
                                      autovalidateMode: AutovalidateMode.always,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 10),
                                            child: StreamBuilder<
                                                List<SubjectsRecord>>(
                                              stream: querySubjectsRecord(
                                                queryBuilder:
                                                    (subjectsRecord) =>
                                                        subjectsRecord.where(
                                                            'LA',
                                                            isEqualTo: true),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: SpinKitFadingCube(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryColor,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<SubjectsRecord>
                                                    rowSubjectsRecordList =
                                                    snapshot.data!;
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      rowSubjectsRecordList
                                                          .length, (rowIndex) {
                                                    final rowSubjectsRecord =
                                                        rowSubjectsRecordList[
                                                            rowIndex];
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (FFAppState()
                                                                .LAselectedSUB ==
                                                            rowSubjectsRecord
                                                                .reference)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2,
                                                                        0,
                                                                        2,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                    child: Text(
                                                                      rowSubjectsRecord
                                                                          .subjectName!,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Ubuntu',
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        if (FFAppState()
                                                                .LAselectedSUB !=
                                                            rowSubjectsRecord
                                                                .reference)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2,
                                                                        0,
                                                                        2,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            10,
                                                                            5),
                                                                    child: Text(
                                                                      rowSubjectsRecord
                                                                          .subjectName!,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Ubuntu',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryColor,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
                                            ),
                                          ),
                                          TextFormField(
                                            controller: textController,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              'textController',
                                              Duration(milliseconds: 100),
                                              () => setState(() {}),
                                            ),
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Grade',
                                              hintText: 'i.e 12',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryColor,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Ubuntu',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                            keyboardType: TextInputType.number,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                if (textController!.text !=
                                                        null &&
                                                    textController!.text != '')
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'ONBOARDING3_PAGE_NEXT_BTN_ON_TAP');
                                                      if (textController!
                                                                  .text !=
                                                              null &&
                                                          textController!
                                                                  .text !=
                                                              '') {
                                                        if (FFAppState()
                                                                .LAselectedSUB !=
                                                            null) {
                                                          logFirebaseEvent(
                                                              'Button_Backend-Call');

                                                          final usersUpdateData =
                                                              createUsersRecordData(
                                                            grade: int.parse(
                                                                textController!
                                                                    .text),
                                                            lASubject: FFAppState()
                                                                .LAselectedSUB,
                                                          );
                                                          await currentUserReference!
                                                              .update(
                                                                  usersUpdateData);
                                                          logFirebaseEvent(
                                                              'Button_Navigate-To');

                                                          context.pushNamed(
                                                            'Onboarding4',
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .rightToLeft,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        100),
                                                              ),
                                                            },
                                                          );
                                                        } else {
                                                          logFirebaseEvent(
                                                              'Button_Alert-Dialog');
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Subject Required!!'),
                                                                content: Text(
                                                                    'Please select Subject, it\'s required for application.'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ok'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                      } else {
                                                        logFirebaseEvent(
                                                            'Button_Alert-Dialog');
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Correct Grade Required!'),
                                                              content: Text(
                                                                  'Please enter Grade, it\'s required for your application and profile personalization.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    text: 'Next',
                                                    options: FFButtonOptions(
                                                      width: 150,
                                                      height: 50,
                                                      color: Colors.transparent,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Ubuntu',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Text(
                                '> We use your grade for applications purposes, our program is not available for all Grades. This is not optional.\n\n> Other users won\'t be able to see your grade.\n\n> By filling your grade you give us consent to use your grade as stated above.\n\n> We will make sure your information is safe.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Ubuntu',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
