FactoryBot.define do
  factory :category do
    sequence(:name) { |i| "Category name #{i}" }
    sequence(:slug) { |i| "category-name-#{i}" }
    sequence(:resume) { |i| "Description category #{i}" }

    factory :category_invalid_name_presence do
      sequence(:name) { "" }
    end
    factory :category_invalid_name_minimum do
      sequence(:name) { |i| "dd" }
    end
    factory :category_invalid_name_maximum do
      sequence(:name) { |i| "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker." }
    end

    factory :category_invalid_resume_presence do
      sequence(:resume) { |i| "" }
    end
    factory :category_invalid_resume_minimum do
      sequence(:resume) { |i| "dd" }
    end
  end
end
