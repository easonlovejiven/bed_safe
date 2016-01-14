class Uploader < CarrierWave::Uploader::Base
  storage :file

  def cache_dir
    Rails.root.join 'public/upload_tmps'
  end

  # 生成文件路径
  def store_dir
    "uploads/commcons/#{Date.today.to_s(:db)}"
  end

  # 生成文件名称
  def filename
    "#{Time.now.to_s(:number)}_#{rand(100000)}.#{file.extension}" if original_filename.present?
  end

end