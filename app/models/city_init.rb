class CityInit
  attr_accessor :code, :name, :parent_id

  def initialize(params)
    @code = params[:code]
    @name = params[:name]
    @parent_id = params[:parent_id]
  rescue => e
    Rails.logger.error e.inspect
  end

  def self.get_provinces
    provinces = []
    cities = []
    file = File.open(Rails.root.join("data", "city.xml"))
    doc = file.read
    file.close
    doc = Nokogiri::XML(doc)
    doc.xpath('/select').children[1].children.each do |item|
      if item.is_a?(Nokogiri::XML::Element)
        value = item["label"]
        code = item["value"]
        provinces << new(:code => item["value"], :name => item["label"], :parent_id => "CN")

        if item.children.present?
          item.children.each do |it|
            cities << new(:code => it["value"], :name => it["label"], :parent_id => code) if it["label"].present?
          end

        end
      end
    end
    [provinces,cities]
  end

  def self.get_cities_by_province_code(code)
    ps, cs = self.get_provinces
    cs.select {|x| x.parent_id == code.to_s}
  end

  def self.get_province(code)
    ps, cs = self.get_provinces
    p = ps.find {|x| x.code == code.to_s }
    p.present? ? p.name : ""
  end

  def self.get_city(code)
    ps, cs = self.get_provinces
    c = cs.find {|x| x.code == code.to_s }
    c.present? ? c.name : ""
  end

  def self.get_city_and_province_by_name(name)
    ps, cs = self.get_provinces
    c = cs.find {|x| x.name == name.to_s }
    c.present? ? c : nil
  end

  def self.get_province_by_name(name)
    ps, cs = self.get_provinces
    p = ps.find {|x| x.name == name.to_s }
    p.present? ? p : nil
  end

end
