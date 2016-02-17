# 后台Dashboard Cell
class AdminDashboardCell < Cell::ViewModel
  include ::Cell::Erb

  def show
    render
  end

  def product_information
    @top_count = Product.where(top_and_down: 1).count #未下架
    @down_count = Product.where(top_and_down: 0).count #已下架

    @y_discount = Product.where(discount: 1).count #有折扣
    @m_discount = Product.where(discount: 0).count #没有折扣
  end
  
end
