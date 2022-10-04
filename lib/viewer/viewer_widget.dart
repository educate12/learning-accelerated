import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/no_video_memos_widget.dart';
import '../components/report_paper_widget.dart';
import '../flutter_flow/flutter_flow_pdf_viewer.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/admob_util.dart' as admob;
import '../flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ViewerWidget extends StatefulWidget {
  const ViewerWidget({
    Key? key,
    this.paper,
  }) : super(key: key);

  final PapersRecord? paper;

  @override
  _ViewerWidgetState createState() => _ViewerWidgetState();
}

class _ViewerWidgetState extends State<ViewerWidget> {
  PagingController<DocumentSnapshot?, LessonsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  bool? interstitialAdSuccess;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('VIEWER_PAGE_viewer_ON_PAGE_LOAD');
      logFirebaseEvent('viewer_Revenue-Cat');
      final isEntitled = await revenue_cat.isEntitled('etwelve_papers_videos');
      if (isEntitled == null) {
        return;
      } else if (!isEntitled) {
        await revenue_cat.loadOfferings();
      }

      if (isEntitled) {
        logFirebaseEvent('viewer_Backend-Call');

        final usersUpdateData = createUsersRecordData(
          subscriptionPaid: true,
        );
        await currentUserReference!.update(usersUpdateData);
      } else {
        logFirebaseEvent('viewer_Ad-Mob');

        admob.loadInterstitialAd(
          "will_be_put_later",
          "ca-app-pub-3598581928071894/4574471261",
          true,
        );

        logFirebaseEvent('viewer_Ad-Mob');

        interstitialAdSuccess = await admob.showInterstitialAd();

        logFirebaseEvent('viewer_Backend-Call');

        final usersUpdateData = createUsersRecordData(
          subscriptionPaid: false,
        );
        await currentUserReference!.update(usersUpdateData);
      }
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'viewer'});
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PapersRecord>(
      future: PapersRecord.getDocumentOnce(widget.paper!.reference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: SpinKitFadingCube(
                color: FlutterFlowTheme.of(context).secondaryColor,
                size: 25,
              ),
            ),
          );
        }
        final viewerPapersRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            iconTheme: IconThemeData(
                color: FlutterFlowTheme.of(context).secondaryColor),
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                logFirebaseEvent('VIEWER_PAGE_Icon_22uw4niw_ON_TAP');
                logFirebaseEvent('Icon_Navigate-Back');
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 24,
              ),
            ),
            title: Text(
              viewerPapersRecord.year!.toString(),
              style: FlutterFlowTheme.of(context).bodyText2.override(
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.asset(
                      'assets/images/login_bg@2x.png',
                    ).image,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: DefaultTabController(
                                  length: 3,
                                  initialIndex: 0,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        labelColor: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        unselectedLabelColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .subtitle1
                                            .override(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                            ),
                                        indicatorColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                        tabs: [
                                          Tab(
                                            text: 'Paper',
                                          ),
                                          Tab(
                                            text: 'Paper Memo',
                                          ),
                                          Tab(
                                            text: 'Video Memo',
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            FlutterFlowPdfViewer(
                                              networkPath: viewerPapersRecord
                                                  .questionPaper!,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1,
                                              horizontalScroll: false,
                                            ),
                                            FlutterFlowPdfViewer(
                                              networkPath:
                                                  viewerPapersRecord.memo!,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1,
                                              horizontalScroll: false,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 5, 10, 5),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: PagedListView<
                                                    DocumentSnapshot<Object?>?,
                                                    LessonsRecord>(
                                                  pagingController: () {
                                                    final Query<Object?> Function(
                                                            Query<Object?>)
                                                        queryBuilder =
                                                        (lessonsRecord) => lessonsRecord
                                                            .where('paper',
                                                                isEqualTo:
                                                                    viewerPapersRecord
                                                                        .reference)
                                                            .where('videoMemo',
                                                                isEqualTo: true)
                                                            .orderBy(
                                                                'questionNumber');
                                                    if (_pagingController !=
                                                        null) {
                                                      final query =
                                                          queryBuilder(
                                                              LessonsRecord
                                                                  .collection);
                                                      if (query !=
                                                          _pagingQuery) {
                                                        // The query has changed
                                                        _pagingQuery = query;
                                                        _streamSubscriptions
                                                            .forEach((s) =>
                                                                s?.cancel());
                                                        _streamSubscriptions
                                                            .clear();
                                                        _pagingController!
                                                            .refresh();
                                                      }
                                                      return _pagingController!;
                                                    }

                                                    _pagingController =
                                                        PagingController(
                                                            firstPageKey: null);
                                                    _pagingQuery = queryBuilder(
                                                        LessonsRecord
                                                            .collection);
                                                    _pagingController!
                                                        .addPageRequestListener(
                                                            (nextPageMarker) {
                                                      queryLessonsRecordPage(
                                                        queryBuilder: (lessonsRecord) =>
                                                            lessonsRecord
                                                                .where('paper',
                                                                    isEqualTo:
                                                                        viewerPapersRecord
                                                                            .reference)
                                                                .where(
                                                                    'videoMemo',
                                                                    isEqualTo:
                                                                        true)
                                                                .orderBy(
                                                                    'questionNumber'),
                                                        nextPageMarker:
                                                            nextPageMarker,
                                                        pageSize: 15,
                                                        isStream: true,
                                                      ).then((page) {
                                                        _pagingController!
                                                            .appendPage(
                                                          page.data,
                                                          page.nextPageMarker,
                                                        );
                                                        final streamSubscription =
                                                            page.dataStream
                                                                ?.listen(
                                                                    (data) {
                                                          final itemIndexes =
                                                              _pagingController!
                                                                  .itemList!
                                                                  .asMap()
                                                                  .map((k, v) =>
                                                                      MapEntry(
                                                                          v.reference
                                                                              .id,
                                                                          k));
                                                          data.forEach((item) {
                                                            final index =
                                                                itemIndexes[item
                                                                    .reference
                                                                    .id];
                                                            final items =
                                                                _pagingController!
                                                                    .itemList!;
                                                            if (index != null) {
                                                              items
                                                                  .replaceRange(
                                                                      index,
                                                                      index + 1,
                                                                      [item]);
                                                              _pagingController!
                                                                  .itemList = {
                                                                for (var item
                                                                    in items)
                                                                  item.reference:
                                                                      item
                                                              }.values.toList();
                                                            }
                                                          });
                                                          setState(() {});
                                                        });
                                                        _streamSubscriptions.add(
                                                            streamSubscription);
                                                      });
                                                    });
                                                    return _pagingController!;
                                                  }(),
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  builderDelegate:
                                                      PagedChildBuilderDelegate<
                                                          LessonsRecord>(
                                                    // Customize what your widget looks like when it's loading the first page.
                                                    firstPageProgressIndicatorBuilder:
                                                        (_) => Center(
                                                      child: SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child:
                                                            SpinKitFadingCube(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryColor,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                    noItemsFoundIndicatorBuilder:
                                                        (_) => Center(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.6,
                                                        child:
                                                            NoVideoMemosWidget(),
                                                      ),
                                                    ),
                                                    itemBuilder: (context, _,
                                                        listViewIndex) {
                                                      final listViewLessonsRecord =
                                                          _pagingController!
                                                                  .itemList![
                                                              listViewIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 5),
                                                        child: Container(
                                                          width: 100,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryColor,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          5,
                                                                          5,
                                                                          5),
                                                                  child: Text(
                                                                    '${listViewLessonsRecord.questionNumber} ${listViewLessonsRecord.topic}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Ubuntu',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .keyboard_arrow_right_outlined,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryColor,
                                                                size: 24,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        logFirebaseEvent('VIEWER_PAGE_Text_eogmjarw_ON_TAP');
                        logFirebaseEvent('Text_Bottom-Sheet');
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                height: 500,
                                child: ReportPaperWidget(
                                  paper: viewerPapersRecord.reference,
                                ),
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      },
                      child: Text(
                        'Report this Paper',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Ubuntu',
                              color: Color(0xFFFF0000),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
