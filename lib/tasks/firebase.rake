namespace :firebase do
  desc 'firebase tokenのセット'

  task set_token: :environment do
    FirebaseIdToken::Certificates.request unless FirebaseIdToken::Certificates.present?
  end
end
