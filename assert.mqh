/**
 * Assertion
 * IS_ASERTが定義済みの場合conditionの評価をおこなう
 * conditionが偽の場合はmessageを表示していプログラムを終了する
 *
 * @param condition 評価式
 * @param message 評価式が偽の場合に表示するメッセージ
 *
 * @example assert(lots > 0, "invalid lots");
 */
#ifdef IS_ASERT
   #define assert(condition, message) \
      if(!(condition)) { \
         Alert("Assertion failed! ", \ 
               #condition, ", ", \ 
               __FILE__, ", ", \
               __FUNCSIG__, ", ", \
               "line:", __LINE__, ", ", \
               message); \
         \
         if(MQLInfoInteger(MQL_PROGRAM_TYPE) == PROGRAM_EXPERT) { \
            ExpertRemove();\
         } \
         else if(MQLInfoInteger(MQL_PROGRAM_TYPE) == PROGRAM_INDICATOR) { \
            if(!ChartIndicatorDelete(0, \
                                     ChartWindowOnDropped(), \
                                     MQLInfoString(MQL_PROGRAM_NAME))) { \
               IndicatorSetString(INDICATOR_SHORTNAME, "assert"); \
               ChartIndicatorDelete(0, \
                                    ChartWindowOnDropped(), \
                                    "assert"); \
            } \
         } \
      }
#else
   #define assert(condition, message)
#endif
