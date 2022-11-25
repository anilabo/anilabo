RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  config.authorize_with do
    current_user ||= User.find(session[:user_id])
    redirect_to main_app.root_path unless current_user.admin?
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.excluded_models = ["AnimeCompany"]

  config.model Anime do
    list do
      field :id
      field :title
      field :title_en
      field :title_short1
      field :title_short2
      field :title_short3
      field :year
      field :season
    end

    show do
      field :public_uid
      field :title
      field :thumbnail_url do
        formatted_value do
          bindings[:view].tag(:img, { src: bindings[:object].thumbnail_url } )
        end
      end
      field :title_en
      field :title_short1
      field :title_short2
      field :public_url do
        pretty_value do
          url = bindings[:object].public_url
          bindings[:view].link_to(url, url, target: '_blank', rel: 'noopener noreferrer')
        end
      end
      field :twitter_account do
        pretty_value do
          twitter_account = bindings[:object].twitter_account
          bindings[:view].link_to("@#{twitter_account}", "https://twitter.com/#{twitter_account}", target: '_blank', rel: 'noopener noreferrer')
        end
      end
      field :twitter_hash_tag do
        pretty_value do
          twitter_hash_tag = bindings[:object].twitter_hash_tag
          bindings[:view].link_to("##{twitter_hash_tag}", "https://twitter.com/hashtag/#{twitter_hash_tag}", target: '_blank', rel: 'noopener noreferrer')
        end
      end
      field :sex
      field :sequel
      field :city_code
      field :city_name
      field :year
      field :season
      field :companies
    end

    edit do
      configure :public_uid do
        hide
      end
      configure :anime_companies do
        hide
      end
    end
  end

  config.model Company do
    list do
      field :id
      field :name
      field :name_en
    end

    show do
      field :public_uid
      field :name
      field :name_en
      field :public_url do
        pretty_value do
          url = bindings[:object].public_url
          bindings[:view].link_to(url, url, target: '_blank', rel: 'noopener noreferrer')
        end
      end
      field :animes
      field :address
    end

    edit do
      configure :public_uid do
        hide
      end
      configure :anime_companies do
        hide
      end
    end
  end
end
