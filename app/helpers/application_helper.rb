module ApplicationHelper
	def blank_table(colspan=5)
    raw("<tr><td style='color:red;text-align:center;' colspan='#{colspan}'>暂无数据！</td></tr>")
  end
end
