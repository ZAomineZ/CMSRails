FactoryBot.define do

  factory :post_slug_empty do
    sequence(:name) { |i| "Post name #{i}" }
    sequence(:slug) { |i| "" }
    sequence(:descr) { |i| "Post content #{i}" }
    sequence(:date_post) { |i| Time.now }
    sequence(:img_original) { |i| "/images/post/#{i}/image.jpg" }
    sequence(:img_medium) { |i| "/images/post/#{i}/image_medium.jpg" }
    sequence(:img_thumb) { |i| "/images/post/#{i}/image_thumb.jpg" }
    sequence(:img_mini) { |i| "/images/post/#{i}/image_mini.jpg" }

  end

end