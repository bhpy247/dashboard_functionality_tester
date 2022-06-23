class bubblePointModel {
  String testname = "";
  List<double> p1 = [];
  List<double> p2 = [];
  double bpressure = 0.0;
  String fluidname = "";
  String duration = "";
  String crosssection = "";
  String materialtype = "";
  String splate = "";
  List<double> flow = [];
  double bdiameter = 0.0;
  String durationsecond = "";
  double thresold = 0.0;
  List<double> ans = [];
  String testtime = "";
  String testdate = "";
  List<double> dp = [];
  double fluidvalue = 0.0;
  List<double> dt = [];
  double tfact = 0.0;
  List<double> t = [];
  String application = "";
  int thikness = 0;
  String indistry = "";
  double samplediameter = 0.0;
  String materialclassification = "";

  bubblePointModel(
      {this.testname = "",
        this.p1 = const [],
        this.p2 = const [],
        this.bpressure = 0.0,
        this.fluidname = "",
        this.duration = "",
        this.crosssection = "",
        this.materialtype = "",
        this.splate = "",
        this.flow = const [],
        this.bdiameter = 0.0,
        this.durationsecond = "",
        this.thresold = 0.0,
        this.ans = const [],
        this.testtime = "",
        this.testdate = "",
        this.dp  = const [],
        this.fluidvalue = 0.0,
        this.dt = const [],
        this.tfact = 0.0,
        this.t = const [],
        this.application = "",
        this.thikness = 0,
        this.indistry = "",
        this.samplediameter = 0.0,
        this.materialclassification = "",
      });

  bubblePointModel.fromJson(Map<String, dynamic> json) {
    testname = json['testname'];
    p1 = json['p1'].cast<int>();
    p2 = json['p2'].cast<int>();
    bpressure = json['bpressure'];
    fluidname = json['fluidname'];
    duration = json['duration'];
    crosssection = json['crosssection'];
    materialtype = json['materialtype'];
    splate = json['splate'];
    flow = json['flow'].cast<int>();
    bdiameter = json['bdiameter'];
    durationsecond = json['durationsecond'];
    thresold = json['thresold'];
    ans = json['ans'].cast<double>();
    testtime = json['testtime'];
    testdate = json['testdate'];
    dp = json['Dp'].cast<double>();
    fluidvalue = json['fluidvalue'];
    dt = json['Dt'].cast<double>();
    tfact = json['tfact'];
    t = json['t'].cast<int>();
    application = json['application'];
    thikness = json['thikness'];
    indistry = json['indistry'];
    samplediameter = json['samplediameter'];
    materialclassification = json['materialclassification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testname'] = this.testname;
    data['p1'] = this.p1;
    data['p2'] = this.p2;
    data['bpressure'] = this.bpressure;
    data['fluidname'] = this.fluidname;
    data['duration'] = this.duration;
    data['crosssection'] = this.crosssection;
    data['materialtype'] = this.materialtype;
    data['splate'] = this.splate;
    data['flow'] = this.flow;
    data['bdiameter'] = this.bdiameter;
    data['durationsecond'] = this.durationsecond;
    data['thresold'] = this.thresold;
    data['ans'] = this.ans;
    data['testtime'] = this.testtime;
    data['testdate'] = this.testdate;
    data['Dp'] = this.dp;
    data['fluidvalue'] = this.fluidvalue;
    data['Dt'] = this.dt;
    data['tfact'] = this.tfact;
    data['t'] = this.t;
    data['application'] = this.application;
    data['thikness'] = this.thikness;
    data['indistry'] = this.indistry;
    data['samplediameter'] = this.samplediameter;
    data['materialclassification'] = this.materialclassification;
    return data;
  }
}
