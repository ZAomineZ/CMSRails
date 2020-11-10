require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe PostFileUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  describe 'upload file' do

    let(:post) { double('post', :id => 1) }
    let(:uploader) { PostFileUploader.new(post, :img_original) }

    before do
      PostFileUploader.enable_processing = true
      File.open(Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/rails.png')))) { |f| uploader.store!(f) }
    end

    after do
      PostFileUploader.enable_processing = false
      uploader.remove!
    end

    it 'should image upload success' do
      file = File.join(Rails.root, '/images/post/1')

      expect(file).to be_truthy
      expect(uploader).to have_permissions(0666)
      expect(uploader).not_to be_format('jpg')
      expect(uploader).to be_format('png')
      expect(uploader).not_to be_format('jpeg')
    end

    it "check dimensions to images" do
      expect(uploader.medium).to have_dimensions(500, 400)
      expect(uploader.thumb).to have_dimensions(150, 150)
      expect(uploader.mini).to have_dimensions(50, 50)
    end
  end
end