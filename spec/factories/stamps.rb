FactoryGirl.define do
  factory :stamp do
    feed
    user
  end

  factory :check_stamp, parent: :stamp, class: Stamp do
    kind :check
  end

  factory :cross_stamp, parent: :stamp, class: Stamp do
    kind :cross
  end

  factory :question_stamp, parent: :stamp, class: Stamp do
    kind :question
  end
end
