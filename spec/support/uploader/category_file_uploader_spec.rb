require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe CategoryFileUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  describe 'upload file success with image valid' do

    let(:category) { double('category', :id => 1) }
    let(:uploader) { CategoryFileUploader.new(category, :avatar_image) }

    before do
      CategoryFileUploader.enable_processing = true
      File.open(Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/rails.png')))) { |f| uploader.store!(f) }
    end

    after do
      CategoryFileUploader.enable_processing = false
      uploader.remove!
    end

    it 'should image upload success' do
      file = File.join(Rails.root, '/images/category/1')

      expect(file).to be_truthy
      expect(uploader).to have_permissions(0666)
      expect(uploader).not_to be_format('jpg')
      expect(uploader).to be_format('png')
      expect(uploader).not_to be_format('jpeg')
    end

    it "check dimensions to images" do
      expect(uploader).to have_dimensions(150, 150)
      expect(uploader.icon).to have_dimensions(50, 50)
    end
  end
end