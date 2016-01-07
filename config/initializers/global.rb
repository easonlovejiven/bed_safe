$json = ActiveSupport::JSON

# 设置默认时间日期格式
Date::DATE_FORMATS[:default] = "%Y年%m月%d日"
Date::DATE_FORMATS[:short_date] = "%m.%d"
Time::DATE_FORMATS[:default] = "%Y年%m月%d日 %H:%M:%S"
Time::DATE_FORMATS[:date] = "%Y年%m月%d日"
Time::DATE_FORMATS[:long] = "%Y年%m月%d日 %H:%M"
Time::DATE_FORMATS[:short] = "%m月%d日 %H:%M"
Time::DATE_FORMATS[:only_time] = "%H:%M:%S"
Time::DATE_FORMATS[:full] = "%Y-%m-%d %H:%M:%S"
