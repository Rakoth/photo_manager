class ImageJob < Struct.new(:photo_id)
  def perform
    Photo.find(photo_id).perform
  end
end
