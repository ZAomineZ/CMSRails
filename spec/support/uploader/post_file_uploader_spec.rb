require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe PostFileUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  describe 'upload file' do

    let(:file) { "image.jpg" }
    let(:uploader) { PostFileUploader.new }

    before do
      PostFileUploader.enable_processing = true
      File.open(file) { |f| uploader.store!(f) }
    end

    after do
      PostFileUploader.enable_processing = false
      uploader.remove!
    end

    it 'should image upload success' do
      expect(File.exist?('/images/posts/1/image.jpg')).to be_truthy
      expect(uploader).to have_permissions(0600)
      expect(uploader).to be_format('jpg')
      expect(uploader).to be_format('png')
      expect(uploader).to be_format('jpeg')
    end

    it "check dimensions to images" do
      expect(uploader.medium).to have_dimensions(500, 400)
      expect(uploader.thumb).to have_dimensions(150, 150)
      expect(uploader.mini).to have_dimensions(50, 50)
    end
  end
end