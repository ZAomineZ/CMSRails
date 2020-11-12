FactoryBot.define do

  factory :user do
    sequence(:username) { |i| "John Doe #{i}" }
    sequence(:password) { |i| "password_john_doe" }
    sequence(:role) { |i| "user" }

    # Factory for username field
    factory :user_username_dont_presence do
      sequence(:username) { "" }
    end

    factory :user_username_minimum do
      sequence(:username) { "t" }
    end

    factory :user_username_maximum do
      sequence(:username) { "e Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker." }
    end

    factory :user_username_format do
      sequence(:username) { "{[#]}" }
    end

    # Factory for password field
    factory :user_password_dont_presence do
      sequence(:password) { "" }
    end

    factory :user_password_minimum do
      sequence(:password) { "test" }
    end

    factory :user_password_maximum do
      sequence(:password) { "Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices" }
    end

    factory :user_password_format do
      sequence(:password) { "{[#]}" }
    end
  end

end