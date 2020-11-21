require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe PostFileSwfUploader, type: :uploader do
  include CarrierWave::Test::Matchers

  describe 'upload file success with image valid' do

    let(:post) { double('post', :id => 1) }
    let(:uploader) { PostFileSwfUploader.new(post, :file_swf) }

    before do
      PostFileSwfUploader.enable_processing = true
      File.open(Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/jeux/jeu.swf')))) { |f| uploader.store!(f) }
    end

    after do
      PostFileSwfUploader.enable_processing = false
      uploader.remove!
    end

    it 'should image upload success' do
      file = File.join(Rails.root, '/jeux')

      expect(file).to be_truthy
      expect(uploader).to have_permissions(0666)
      expect(uploader).not_to be_format('jpg')
      expect(uploader).not_to be_format('png')
      expect(uploader).not_to be_format('jpeg')
      expect(uploader).not_to be_format('jpeg')
    end
  end
end