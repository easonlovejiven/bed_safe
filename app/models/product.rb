class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :user
  validate :describtion_validates
  validates :name, presence: { message: "不能为空！" },
            uniqueness: { message: "不能重复！" },
            length: { minimum: 2, maximum: 20, message: "长度不正确[建议长度2-20]" }

	# 有命名空间
	# belongs_to :sender_staffer, class_name: "Admin::Staffer", foreign_key: :sender_staffer_id #生产者
  # belongs_to :audit_staffer, class_name: "Admin::Staffer", foreign_key: :audit_staffer_id #送货员

  # 无命名空间 product.product_user/product.product.deliver 得到固定产品的生产者和配送者
  # belongs_to :product_user, class_name: :User, foreign_key: :product_user_id #生产者
  # belongs_to :product_deliver, class_name: :User, foreign_key: :product_deliver_id #送货员

	DISCOUNT = { false => "没有折扣", true => "有折扣" } # 默认是有折扣的
  TOP_AND_DOWN = { false => "已下架", true => "未下架" } # 默认是未下架

  # 按照日期进行搜索
  scope :created_at_gte, -> (date_str) { date_str.present? ? where('created_at >= ?', Date.parse(date_str)) : all }
  scope :created_at_lte, -> (date_str) { date_str.present? ? where('created_at <= ?', Date.parse(date_str) + 1) : all }

  # 统计不同类型的产品数量
  scope :type_count, -> (type_id){where("type_id = ?", type_id).count }

  # 对录入产品信息做个验证
  def describtion_validates
    self.errors.add(:describtion, "产品描述输入有误，请重新录入！") if self.describtion.present? && !self.describtion.include?("值得信任！")
  end

  # 验证手机号是否输入有误
  # validate :mebile_validates
  # def mebile_validates
  #   mobile_errors = []
  #   if self.receive_tel.present?
  #     mobiles = self.receive_tel.split("\r\n") 录入时必须换行
  #     mobiles.uniq.each do |mobile|
  #       mobile_errors << /^1[0-9]{10}$/.match(mobile)
  #     end
  #     self.errors.add(:receive_tel, "手机格式输入有误，请重新录入！") if mobile_errors.include?(nil)
  #   end
  # end

  # scope 用法
  #scope :area, -> {where("id > 2")} #scope 没有参数的
  #scope :get_type, -> (product_id){where("id = ?",product_id)}
  #Product::scope_name 调用方式

  #scope :sort_desc, -> { order(id: :desc) }
  # scope :deleted, -> { where deleted: true }
  # scope :undeleted, -> { where deleted: false }
  # scope :top, -> { where commentable_ids: nil }
  # scope :created_gte, ->(time) { where("created_at >= ?", time) }
  # scope :id_lt, -> (id) { where("id < ?", id) if id > 0 }

  # 回调用法

  # before_save :change_count, if: :discount  条件回调
  # def change_count
  #   # 如果是有折扣的话，然后做另外的处理(其它回调方法 的用法都一样)
  # end

  # after_initialize :new_product  初始化回调
  # def new_product
  #   # 初始化时候出发这个回调(读取/new)
  # end

  # 在这儿做属性的处理的话，在查询的时候，读取对象.属性的时候会调用这个方法，默认会去找这个属性
  # def price
  #   super || 0.0
  # end

  #遍历的时候给每个对象的describtion属性add一条附加信息
  # def describtion
  #   super + "附加信息"
  # end

  # 导入导出文件
  class << self
    def import_c_name(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        bs = find_by(id: row["id"]) || find_by(name: row["name"])
        if bs
          bs.attributes = row.to_hash.slice("name")
          bs.save!
        else
          # 打logo message
          logger.info("ERROR: cannot find name by name=#{row['name']}")
        end
      end
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when '.csv' then Roo::CSV.new(file.path)
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |bs|
          csv << bs.attributes.values_at(*column_names)
        end
      end
    end
  end


end
