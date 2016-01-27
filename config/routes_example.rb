Caishuo::Application.routes.draw do

  get "events/shipan", as: :contest, to: "events/shipan#index"

  root 'index#index'

  mount Caishuo::API, at: "/" # App API

  get 'dasai' => "dasai#index"
  get "go", as: :go, to: "index#go"

  get 'surveys/zhaocha' => 'surveys#zhaocha'
  get 'sms_reports/open_callback' => 'sms_reports#get_status'
  get 'sms_content/open_callback'
  post 'surveys' => "surveys#create"

  #resources :surveys, only: [:create]

  # image_machine
  get 'image_machine/basket/:basket_id/:timestamp.jpg', to: "image_machine#basket", defaults: { format: 'jpg' }
  get 'image_machine/stock/:stock_id/:timestamp.png', to: "image_machine#stock", defaults: { format: 'jpg' }

  get 'image_mirrors/p2p_product_img', to: "image_mirrors#p2p_product_img"

  resources :feed_articles, only: [:index, :show]
  get 'tags/:tag', to: 'articles#index', as: :tag
  get 'open/weixin' => 'api/weixin#check_signature'
  post 'open/weixin' => 'api/weixin#receive'

  resource :forward, only: [:index]
  get '/u/:name', to: 'forward#index'
  get '/s/:name', to: 'forward#index'

  resources :articles, only: [:index, :show] do
    resources :comments
  end

  resources :categories, only: [] do
    resources :articles,  only: [:index, :show]
  end

  resources :topics, only: [:index, :show] do
    resources :comments
    collection do
      get :list
    end
  end

  resources :baskets do
    resources :comments
    resources :orders, only: [:new] do
      collection do
        get :sell
      end
    end

    member do
      get :add
      get :base
      get :info
      put :update_stocks
      put :update_stocks_reason
      put :update_title
      put :update_attrs
      post :comment
      get :show_review
      get :custom
      post :customize
      get :adjust_logs
      get :tip
    end
    collection do
      post :search_add
      # post :search
      get :my
    end
  end

  resources :stocks, only: [:show, :index] do
    resources :comments
    collection do
      post :search
    end
    member do
      get :trade
    end

    resources :news, module: :stocks
    resources :announcements, module: :stocks
  end

  resources :news, only: [:show]

  namespace :rest do
    resources :notifications, only: [:create]
    resources :p2p_strategies, only: [:index] do
      collection do
        post 'profit'
      end
    end
    resources :p2p_products, only: [:index]
  end


  namespace :account do
    resources :sessions
    resources :confirmations do
      collection do
        get :rebind_email
      end
    end
    resources :registrations
    resource :user
    resource :profile
    resource :password
    resources :protocols
  end

  get 'login' => 'account/sessions#new', as: :login
  post 'login' => 'account/sessions#create'
  get 'signup' => 'account/registrations#new', as: :signup
  match 'logout', to: 'account/sessions#destroy', via: [:get, :delete], as: :logout

  resources :setting, except: [:update] do
    collection do
      get :password
      post :update_email
      get :profile
      get :mobile
      post :update_profile, :update_base_profile
      get :avatar
      get :hongbao
      get :mobile
      get :check_bind_email
      get :bind
      patch :invite_code
    end
    member do
      put :save_avatar
    end
  end

  get 'users/baskets' => 'user/baskets#index'
  get "users/positions" => "user/positions#index"
  get "unicorn_signup" => "index#unicorn_signup"

  get 'p/(:id)/baskets' => 'profiles#baskets'
  get 'p/(:id)/followed_baskets' => 'profiles#followed_baskets', as: :profile_followed_baskets
  get 'p/(:id)/followed_stocks' => 'profiles#followed_stocks'
  get 'p/(:id)/followed_users' => 'profiles#followed_users', as: :profile_followed_users
  get 'p/(:id)/followers' => 'profiles#followers', as: :profile_followers
  get 'p/(:id)/both_followed' => 'profiles#both_followed'
  post 'p/(:id)/toggle_follow' => 'profiles#toggle_follow', as: :profile_toggle_follow
  post 'p/:id/switch_follow' => 'profiles#switch_follow', as: :profile_switch_follow
  get 'p/(:id)' => 'profiles#show', as: :profile

  resources :profiles, only: [] do
    member do
      get :feeds
    end
  end

  resources :users do
    member do
      get 'profile'
      get 'fans'
      get 'follows'
      get 'feeds'
    end
    collection do
      get :stocks
      get :brokers
    end
  end

  resources :messages
  get "user_brokers/pass" => "accounts#pass"
  get "accounts/positions" => "user/positions#index"
  get "accounts/orders" => "user/orders#index"
  get "accounts/overview", controller: "accounts/overview", action: "index"

  # 新的账号绑定
  resources :accounts, only: [:index, :show, :destroy, :create] do

    collection do
      get :pass

      get :positions
    end
    member do
      post :is_login
      post :login
      post :refresh_orders
      post :refresh_positions
      post :refresh_cash
      get :order_details
    end

    scope module: :accounts do
      # 投资概览
      resources :overview, only: [:index] do
        collection do
          get :positions
          get :orders
          get :news
        end
      end

      resources :positions, only: [:index] do
        collection do
          get :basket_positions
          get :adjust
          get :adjust_add_stock
          get :trade_basket_stock
          get :stocks
        end
      end
    end

  end

  resources :brokers do
    resources :accounts, only: [:new, :create]
  end

  resources :notifications do
    collection do
      get :reminder
      get :comment
      get :system
      get :mention
    end
  end

  resources :orders, :only => [:create, :new, :show] do
    member do
      post :confirm
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :landings, only: [:index, :create] do
    collection do
      get :list
      get :succ
    end
  end

  resources :about, only: [] do
    collection do
      get :about_us
      get :contact_us
      get :join_us
      get :feedback
      get :guide
      get :problem
      get :account
      get :binding
      get :access
      get :hk_bank
      get :transfer
      get :help
      get :basket
      get :faq
      get :knowledge
      get :knowledge_hk
      get :knowledge_us
      get :term
    end
  end

  # 我的主题/投资概览等等用户相关
  namespace :user do
    resources :baskets, only: [:index]

    resources :positions, only: [:index] do
      collection do
        get :profits
      end
    end
    resources :orders, only: [:index] do
      member do
        get :details
      end
    end
    resources :positions, only: [:index] do
      collection do
        get :basket_positions
      end
    end
  end

  namespace :ajax do
    resources :articles, only: [] do
      member do
        get :comments
      end
    end
    resource :data do
      get :contest_cash
      get "events/:short_id", action: :events
    end
    resource :global, controller: :global, only: [] do
      get :search, :screenshot, :market_infos, :market_time, :search_user, :search_stock, :search_basket, :stock_search
    end
    resource :region, controller: :region, only: [] do
      get :cities
      get :get_cities
      get :fetch_cities
    end
    resources :users, only: [] do
      member do
        post :follow
        post :unfollow
        post :toggle_follow
        put :save_avatar
        put :crop_avatar
        put :setting_crop
        get :bubble
      end
      collection do
        get :check_username
        get :check_email
        get :check_email_exists
        get :check_mobile_exists
        get :check_mobile_register
        get :check_invite_code
        get :logined
        get :check_captcha
        get :check_password
        get :unread_notifications
        get :property_datas
        get :investment_percent
        get :sell_basket
        get :check_email_or_name
        get :easy_networth_chart
        get :following_stocks
        get :query
        put :send_sms_code
        put :bind_mobile
        put :bind_or_update_mobile
        put :bind_mobile_and_password
        put :bind_mobile_account
        put :bind_or_update_email
        post :resend_bind_or_update_email
        get :check_mobile_binded
        get :check_mobile_or_email
      end
    end
    resources :accounts do
      member do
        get :equities
        get :incomes
      end
    end
    resources :staffers, only: [] do
      collection do
        get :check_email
      end
    end
    resources :feeds, only: [:create] do
      member do
        post :like
        post :favorite
        get :comments
      end
      collection do
        post :comment
        post :uploadify
      end
    end

    resources :baskets, only: [] do
      member do
        put :save_img
        put :crop_pic
        get :comments
        post :destroy_draft
        post :follow
        post :returns_chart
        get :chart_datas
        post :increment_view
        post :deploy
        post :archive
        post :recover
        post :tagged
        post :untagged
        get :opinioners
      end
      collection do
        get :fuzzy_query
        post :stocks_pre_index
        post :baskets_pre_index
        post :search_add
        post :est_min_money
        get :infos
        get :batch
        get :contest
      end
    end
    resources :opinions, only: [:create] do
      collection do
        get :datas
      end
    end
    resources :stocks, only: [] do
      collection do
        get :search
        get :recommend
        get :query
        get :prices
      end
      member do
        get :chart
        get :infos
        post :unfollow
        post :follow
        post :follow_with_render
        post :follow_or_unfollow
        get :quote_prices
        get :klines
        get :minutes
        post :suggest_render
        post :unsuggest
        get :rt
        get :news
        get :announcements
        get :rt_logs
        get :trading_flows
        get :flow_charts
        get :bubble_trading_flows
        get :bubble
        get :industry_percent_flows
        get :friends_with_followed
      end
    end
    resources :stock_indexes, only: [ :index ]
    resources :comments, only: [] do
      member do
        post :like
        post :reply
        post :article_reply
        post :topic_reply
        post :delete
        get :all_replies
      end
    end
    resources :notifications do
      member do
        post :delete
      end
      collection do
        post :mark_read
      end
    end
    resources :message_talks do
      collection do
        get :counter
        post :mark_read
      end
    end
    resources :orders, only: [] do
      collection do
        get :data
        get :orders_infos
      end
      member do
        get :details
        get :status
        post :cancel
      end
    end
    resources :follow_stocks, only: [:destroy] do
      member do
        post :update_notes
        post :tag
        post :trade_stock
      end
      collection do
        post :update_sort
      end
    end
    resources :follow_stock_tags, only: [:create] do
      member do
        post :rename
        post :delete
        post :add
      end
      collection do
        post :update_sort
      end
    end
    resources :feedbacks, only: [:create] do
      collection do
        post :report_user
      end
    end
    resources :topics, only: [] do
      member do
        post :incre_view
        get :chart
      end
    end

    resources :contests do
      member do
        post :sign_next
      end
    end
  end

  #authenticate :user, lambda { |u| u.admin? } do
    mount Resque::Server, :at => "/resque"
  #end

  namespace 'admin' do
    devise_for :staffers, class_name: 'Admin::Staffer'
    get 'surveys' => 'surveys#index'
    get 'sms_reports' => 'sms_reports#index'
    get 'sms_contents' => 'sms_contents#index'
    get 'channel_statistics' => 'channel_statistics#index'
    resources :jike do
      collection do
        get :list
        post :submit
        post :resubmit
      end
      member do
        put :cancel
      end
    end
    resources :target_messages do
      member do
        get :counter
      end
    end
    resources :guess_stocks, only: [:index] do
      member do
        post :change_winned
      end
    end

    resources :staffers, path: :employees
    resources :stock_changes, as: :md_data_stock_changes
    resources :spider_news_categories, as: :md_source_spider_news_categories
    resources :spider_news_sources, as: :md_source_spider_news_sources do
      member do
        get :run
      end
    end
    resources :pushs, only: [:index, :create, :new]
    resources :recommends do
      member do
        post :approve
        post :resend
      end
    end
    resources :contests do
      member do
        get :cash
        match :cash, action: :update_cash, via: [:put, :patch]
        get :import
        get :sync_asset
        match :import, action: :do_import, via: [:put, :patch]
      end
    end
    resources :players do
      member do
        get :login
        get :position
        get :cash_history
      end
      collection do
        get :cash
      end
    end
    namespace 'tag' do
      resources :commons do
        member do
          get :baskets
        end
        collection do
          post :positions
        end
      end
      resources :groups do
        collection do
          post :positions
        end
      end
    end
    resources :hongbaos, only: :index
    resources :pt_applications do
      member do
        get :approve
        get :reject, :notice
      end
    end
    resources :active_docks
    resources :market_templetes
    resources :sms_logs do
      member do
        post :change_audit
      end
    end
    resources :roles do
      collection do
        post :ajax_delete_role
      end
    end
    resources :permissions do
      collection do
        get :update_permission_by_role
        get :show_permission_by_role
        post :ajax_delete_permission
        post :update_per
      end
    end
    resources :role_permissions do
      collection do
        get :update_permission
      end
    end
    resources :suggests, only: [:index, :edit, :update] do
      member do
        put :save_img
        put :crop_pic
        get :pic
      end
    end
    resources :articles do
      collection do
        get :sync_list
        put :save_img
        put :crop_pic
      end
      member do
        get :sync
        get :toggle_viewable
      end
    end
    resources :messages do
      collection do
        post :ajax_del_message
      end
    end
    resources :p2p_strategies do
      member do
        get :refresh_img
      end
      collection do
        get :refresh_all_img
      end
    end
    resources :admin_logs
    resources :base_stocks do
      collection do
        post :import_c_name
        get :get_qualified_info
        get :get_snapshot_info
        get :list
        post :reset_bar_by_exchange
        post :fill_bar_by_exchange
        post :reset_4days_bar_by_exchange
        post :reset_cn_rt
        get :unqualified_list
        post :reset_cn_qualified
        post :reset_neeq_qualified
        post :reset_tf_cache
        post :reset_halted_trade_time
        post :halted_fetch
        post :reset_minute_charts
        post :reset_rt
        post :reset_qq_hq
        get :realtime
      end
      member do
        get :setting
        post :reset_bar
        post :fill_bar
        post :reset_quote
        get :split_and_dividend_list
        post :reset_4days_bar
      end
      resources :quotes, only: [:index]
    end

    resources :landings, only: [:index]

    resources :comments, only: [:index] do
      member do
        post :change_deleted
      end
      collection do
        post :ajax_del_comment
      end
    end

    resources :users, only: [:index] do
      member do
        post :change_company_user
        post :reactivate
        get :quick_login
        post :blocked
      end
      collection do
        get :data
        get :search
        get :search_user
      end
    end

    resources :user_bindings, only: [:index, :update, :edit] do
      member do
        put :reconcile
      end
    end
    resources :reconcile_request_lists, only: [:index, :update, :edit] do
      member do
        put :reconcile
      end
    end
    resources :weekly_reports do
      collection do
        post :deliver
      end
    end
    resources :baskets do
      member do
        get :recommend
        get :discommend
        get :audit
        post :audit_pass
        post :audit_not_pass
        put :save_img
        put :crop_pic
        get :cover
        put :hide
      end
      collection do
        get :stocks_data
      end
    end
    resources :configs, only: [:index] do
      collection do
        post :set_unconfirmed_orders_hours
      end
    end
    resources :orders, only: [:index, :show, :update] do
      member do
        get :log
        put :execution
      end
    end
    resources :ca_dividends
    resources :ca_splits
    resources :trading_accounts do
      collection do
        get :health
        get :tries
      end
      member do
        get :order_history
        get :execution_history
        get :cash_history
        get :position
        get :remote_today_orders
        get :remote_today_executions
        get :remote_positions
        post :audited
        post :unaudited
        post :sync_cash
      end
    end
    resources :position_archives do
      collection do
        post :archive
      end
    end
    resources :order_details
    resources :user_day_properties
    resources :user_profits
    resources :exec_details
    resources :account_values
    resources :account_value_archives
    resources :invitation_codes
    resources :stock_adjusting_factors
    resources :stock_industries
    resources :jy_industries
    resources :jy_components
    resources :stock_components
    resources :account_position_risks
    resources :historical_quotes
    resources :historical_quote_cns
    resources :historical_quote_retries
    resources :plates
    resources :plate_stocks
    resources :ib_id_change_logs
    namespace :md do
      resources :longhus
      resources :stock_trading_flows
      resources :leader_stock_alters
      resources :plate_trading_flows
    end
    resources :quotes
    resources :leads do
      member do
        post :send_email
        get :edit_info
        put :update_info
      end
      collection do
        get :multi_set
        get :multi_send
        post :import
        get :cancel_import
      end
    end
    resources :feedbacks, only: [:index]
    resources :brokers do
      member do
        post :open
        get :sync_trading_date
      end
    end
    resources :symbol_change_logs
    resources :topics do
      member do
        put :save_img
        put :crop_pic
        put :save_big_img
        put :crop_big_pic
        post :add_stock
        post :update_baskets
        post :toggle_visible
        get :baskets
        get :pool
        get :pending_pool
        post :adjust_basket
        post :move_top
        post :reset_articles
      end
      collection do
        post :positions
      end

      resources :topic_news, only: [:create, :destroy, :update]

      resources :topic_stocks, only: [:update, :destroy]
      resources :topic_articles, only: [:update]
    end
    resources :home_settings, only: [:index] do
      collection do
        get :topic
        get :basket
        get :stock_search
        get :banners
        get :mobile_banners
        get :home_adverts
        get :mobile_p2p_banners
        post :update_topic
        post :update_basket
        post :update_stock_search
        get :users
        post :add_user
        post :del_user
        post :users_position
        get :expire_cache
        get :activities
        post :contest_count
        get :mobile_ad
      end
    end
    resources :banners, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        put :save_img
        put :crop_pic
        patch :update_sort
      end
    end
    resources :mobile_banners, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        patch :update_sort
        post :set_ad
      end
    end
    resources :home_adverts do 
      member do
        post :switch_change
      end
    end
    
    resources :mobile_p2p_banners, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        put :save_img
        put :crop_pic
        patch :update_sort
        post :set_ad
      end
    end
    resources :basket_adjustments, only: [:index, :show]
    resources :basket_weight_logs, only: [:index]
    resources :basket_stock_snapshots, only: [:index]

    resources :majia_users

    resources :forbidden_names, only: [:index, :create, :destroy]
    resources :adjusted_stocks, only: [:index]
    resources :pre_contestants, only: [:index]
    resources :p2p_ads do
      collection do
        get :edit_all
        put :update_all
      end
    end

    resources :panels do
      collection do
        get :edit_all
        put :update_all
      end
    end

    resources :aces do
      collection do
        get :edit_all
        put :update_all
      end
    end

    resources :hot_stocks do
      collection do
        get :edit_all
        put :update_all
      end
    end

    resources :featured_baskets do
      collection do
        get :edit_all
        put :update_all
      end
    end

    resources :feeds, only: [:create, :index] do
      collection do
        get 'filters'
        get 'contents'
        get 'hub', 'auto', 'time_rules'
        get 'fixed'
        post 'fixed', action: :fixed_action
        get 'hub/:id', action: :hub_show
        get 'hub_imgs/:id', action: :hub_imgs
        get "history", "fresh", 'rule', 'content_rule'
        post 'hub/:id/toggle', action: :toggle_hub_state
        post 'hub/:id/weight', action: :hub_weight
        get 'hub/:id/push', action: :push_hub, as: :push_hub
        post 'hub/:id/confirm_push', action: :confirm_push_hub
      end
    end
    resources :feed_hubs, only: [:edit, :update]

    resources :feed_categories, as: :md_feed_categories

    # resources :guess_indices, only: [:index]

    controller :dev, as: :dev, path: :dev, only: [] do
      get "templates(/:id)",  action: :templates
      match "test_email", via: [:get, :post]
      get "templates(/:id)" => :templates
      get "ajax/dialog", action: :ajax_dialog
      get "test_feed"
    end

    controller :trading, as: :trading, path: :trading, only: [] do
      get "status", action: :status
    end

    scope :data, controller: :data do
      get :currency
      get :user_active
      get :user_retain
    end

    resources :channel_codes do
      collection do
        get :notice
      end
    end

    resources :uploaders, only: [:create]

    namespace 'es' do
      resources :sources
      get ':site/news', to: "news#index"
      resources :news, only: [:index, :show, :edit, :update, :destroy] do
        collection do
          get :sources
          get 'sync_source/:id', action: :sync_source, as: :sync_source
        end
        member do
          put :sync
        end
      end
      get ':site/announcements', to: "announcements#index"
      resources :announcements, only: [:index, :show, :edit, :update, :destroy]
      resources :comments, only: [:index, :show, :destroy]
      resources :spider_news do
        collection do
          get 'log'
        end
      end
    end


  end
  devise_scope :admin_staffer do
    get 'admin/activate', to: "admin/registrations#activate"
    post '/admin/change_email', to: 'admin/confirmations#change_email'
    get "nimda", to: 'admin/home#index', as: :admin_root
  end

  get "mobile/ajax/global/search" => "ajax/global#search"
  get "mobile/ajax/global/stock_search" => "ajax/global#stock_search"
  post "mobile/ajax/contests/:id/sign_next" => "ajax/contests#sign_next"
  get 'mobile/pages/:type/:id' => "mobile/pages#show"
  get "mobile/ajax/data/events/:short_id" => "ajax/data#events"

  namespace :mobile do
    resources :p2p do
      collection do
        get :day_profits
        get :return_rule
        get :caishuo_protocol
        get :user_protocol
        get :risk_protocol
        get :common_issues
      end
    end
    get 'p2p/product/:id' => "p2p#product"
    get 'p2p/investment_record/:id' => "p2p#investment_record"
    get 'p2p/product_feature/:type' => "p2p#product_feature"

    resources :plates, only: [:show]
    namespace :account do
      resources :sessions
      resources :confirmations
      resources :registrations do
        collection do
          post :exists
          get :info
          match :info, action: :update_info, via: [:put, :patch]
          get :fetch_cities
        end
      end
      resources :users do
        put 'send_sms_code', on: :collection
      end
      resource :profile
      resources :protocols
      resources :topics
      resources :password do
        collection do
          post :update_password
          post :update_password_by_mobile
          post :update_password_by_email
          post :send_reset_password_email
          get  :reset_password
          get  :finish
          get  :change_password
        end
      end
    end

    namespace :ajax do
      resources :p2p, only: [] do
        collection do
          get :inverst_records
          get :day_profits
        end
      end
    end

    get 'login' => 'account/sessions#new', as: :login
    post 'login' => 'account/sessions#create'
    get 'signup' => 'account/registrations#new', as: :signup
    match 'logout', to: 'account/sessions#destroy', via: [:get, :delete], as: :logout

    namespace :events do
      # resources :shipan, only: [:index, :show] do
      #   collection do
      #     get :trading
      #     get :ranks
      #     get :my
      #   end
      # end
      resources :guess_indices, only: [:index, :create] do
        collection do
          get :download
        end
      end
      # resources :guess_stocks, only: [:index, :create]
      # resources :wanshengjie, only: [:index]
      resources :notices, only: [:index]
      resources :money, only: [:index]
    end

    # 市场推广
    namespace :market do
      get "download" => "download#index"
      get "download/redirect" => "download#redirect"
    end

    root 'baskets#index'
    get 'surveys/zhaocha' => 'surveys#zhaocha'
    post 'surveys' => "surveys#create"
    resources :app, only: [:index]
    # get 'app', to: redirect{ |path_params, req| "/market/download?#{req.GET.to_query}" }
    resources :stocks, only: [:index, :show] do
      resources :announcements, module: :stocks
    end
    resources :baskets, only: [:index, :show] do
      member do
        get :content
        get :info
      end
    end
    resources :topics, only: [:show]
    resources :downloads do
      collection do
        get :redirect
      end
    end
    namespace :shares do
      resources :baskets, only: [:show] do
        member do
          get :graph
          get :info
          get :content
          get :chart_datas
        end
      end
      resources :stocks, only: [:show] do
        member do
          get :quote_prices
          get :klines
          get :graph
          get :graph_datas
          get :chart_datas
        end
      end

      resources :snapshots, only: [] do
        collection do
          get "account/:jdday/:encoded_params" => :account
          get "account_analysis/:jdday/:encoded_params" => :account_analysis
        end
      end

      resources :brokers do
        resources :accounts
      end
    end
    resources :help, only: [] do
      collection do
        get :feedback
      end
    end
    resources :feedbacks, only: [:create]

    namespace :data do
      get "baskets/:id/chart_datas", action: :basket_chart_datas
      get "stocks/:id/chart_datas", action: :stock_chart_datas
      get "stocks/:id/quote_prices", action: :stock_quote_prices
      get "stocks/:id/klines", action: :stock_klines
    end

    resources :filters, only: [] do
      collection do
        get :zjbklx_1
        get :zjbklx_2
        get :industry_1, :concept_1
        get :ggzjlx_1
        get :ggzjlx_2
        get :ggcg_1
        get :ggcg_2
        get :lhb_1
        get :lhb_2
        get :lhb_3
        get :lhb_4
        get :lhb_5
        get :lhb_6
        get :score_1
        get :score_2
        get :wr_1, :wr_2, :macd_1, :macd_2
      end
    end

    resources :accounts, only: [] do
      member do
        get :compare_all, :compare_friends, :analysis
      end
    end

  end
  resources :app, only: [:index]

  namespace :events do
    resources :shipandasai
    resources :money, only: [:index]
    resources :shipan, only: [:index] do
      collection do
        get :trading
        get :ranks
        get :rules
      end
    end
  end

  namespace :internal do
    resources :orders, only: [] do
      member do
        post :completed
      end
    end
    resources :trading_accounts, only: [] do
      member do
        post :extend_status
      end
    end
  end

  resources :contests, only: [:show] do
    resources :comments
  end

  get "/auth/:provider/callback" => "auth#callback"
  get "/auth/:provider/remove_bind" => "auth#remove_bind"

  get '/captcha' => "captcha#captcha"

  namespace :open do
    resources :topics, only: [:show]
  end

  namespace :market do
    namespace :zxg do
      resources :topics, only: [:show]
    end
  end

  namespace :screenshot do
    resources :baskets, only: [] do
      member do
        get :mini_chart
      end
    end
  end

  get '*unmatched_route', :to => 'application#no_route', defaults: { format: 'html' }

end
