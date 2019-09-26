// 任务类型
enum ETTTaskType {
  ETTTaskTypeResourceStudy            ,//资源学习
  ETTTaskTypeInteractionCommunication ,//互动交流
  ETTTaskTypeTestQuestion             ,//试题
  ETTTaskTypePaperTest                ,//成卷测试
  ETTTaskTypeAutonomyTest             ,//自主测试
  ETTTaskTypeMicroCourseStudy         ,//微课程学习
  ETTTaskTypeLiveCourse               ,//直播课
  ETTTaskTypeRegularTask              ,//一般任务
}

// 任务子类型
enum ETTTaskSubtype {
  ETTTaskSubtypeResourceStudy             ,//资源学习类 包括（文档类任务，声音类任务，图片类，视频类/远程高清类）
  ETTTaskSubtypeDiscussion                ,//讨论
  ETTTaskSubtypeWebviewObjectiveItem      ,//webview试题（单选题，多选题，填空题）
  ETTTaskSubtypePaperTest                 ,//成卷测试
  ETTTaskSubtypeAutonomyTest              ,//自主测试
  ETTTaskSubtypeMicroCourse               ,//微课
  ETTTaskSubtypeRegularTaskVoice          ,//一般任务语音
  ETTTaskSubtypeRegularTaskPicture        ,//一般任务图片
  ETTTaskSubtypeRegularTaskText           ,//一般任务文字
  ETTTaskSubtypeLiveCourse                ,//直播课
  ETTTaskSubtypeWebviewSubjectiveItem     ,//webview试题主观题
  ETTTaskSubtypeKnowledgeGuidance         ,//知识导学
  ETTTaskAnswerSheet                      ,//答题卡
  ETTTaskAISingle                         ,//AI任务 单项任务
  ETTTaskAIStudyPlan                      ,//AI任务 学习计划
  ETTTaskHoneycomb                        ,//蜂巢任务
  ETTTaskSingSound                        ,//先声任务
}