FactoryBot.define do

  factory :post do
    sequence(:name) { |i| "Post name #{i}" }
    sequence(:slug) { |i| "post-name-#{i}" }
    sequence(:descr) { |i| "Post content #{i}" }
    sequence(:date_post) { |i| Time.now }
    sequence(:img_original) { |i| "/images/posts/#{i}/image.jpg" }
    sequence(:img_medium) { |i| "/images/posts/#{i}/image_medium.jpg" }
    sequence(:img_thumb) { |i| "/images/posts/#{i}/image_thumb.jpg" }
    sequence(:img_mini) { |i| "/images/posts/#{i}/image_mini.jpg" }

    factory :post_categories do
      sequence(:name) { |i| "Post name #{i}" }
      sequence(:slug) { |i| "" }
      sequence(:descr) { |i| "Post content #{i}" }
      sequence(:category_id) { |i| "Manga,Anime" }
      sequence(:date_post) { |i| Time.now }
      sequence(:img_original) { |i| "/images/posts/#{i}/image.jpg" }
      sequence(:img_medium) { |i| "/images/posts/#{i}/image_medium.jpg" }
      sequence(:img_thumb) { |i| "/images/posts/#{i}/image_thumb.jpg" }
      sequence(:img_mini) { |i| "/images/posts/#{i}/image_mini.jpg" }
    end

    factory :post_invalid_name_presence do
      sequence(:name) { "" }
    end
    factory :post_invalid_name_minimun do
      sequence(:name) { "d" }
    end
    factory :post_invalid_name_maximum do
      sequence(:name) { "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker." }
    end

    factory :post_invalid_slug do
      sequence(:slug) {"Test de test"}
    end

    factory :post_invalid_descr_presence do
      sequence(:descr) { "" }
    end
    factory :post_invalid_descr_minimum do
      sequence(:descr) { "dadadd" }
    end
  end

end