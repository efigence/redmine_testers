# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'testers', to: 'testers#index', path: 'testers/new_report'
get 'testers_manage', to: 'testers_manage#index', as: 'testers_panel',  path: 'testers/manage_reports'
post 'testers_manage/:id', to: 'testers_manage#update', as: 'update_order'
get 'order/:id' => 'testers_manage#destroy', as: 'destroy_order'
get 'order/edit/:id' => 'testers_manage#edit', as: 'edit_order'
resources :testers, only: [:create]
resources :testers_manage, only: [:show]
