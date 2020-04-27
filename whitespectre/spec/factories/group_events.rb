FactoryBot.define do
  factory :empty_event, class: GroupEvent do

    factory :invalid_event, class: GroupEvent do
      start         { Date.parse('10.05.2020') }
      stop          { Date.parse('01.05.2020') }
    end

    factory :event, class: GroupEvent do
      name          { 'Festival' }
      description   { "<h1>Spring festival</h1>\nThe best fest ever. Really." }
      start         { Date.parse('01.05.2020') }
      stop          { Date.parse('10.05.2020') }
      duration      { 10 }
      latitude      { 45.1231 }
      longitude     { 33.2138 }

      trait :published do
        draft { false }
      end

      trait :deleted do
        deleted_at { DateTime.now }
      end

      factory :published_event, traits: [:published]
      factory :deleted_event, traits: [:deleted]
    end

  end
end

