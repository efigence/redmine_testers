# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'testers', to: 'testers#index'
get 'testers/new_report', to: 'testers#new_report', as: 'testers_new_report'
get 'testers/test_list', to: 'testers#test_list', as: 'test_list'
get 'testers_manage', to: 'testers_manage#index', as: 'testers_panel',  path: 'testers/manage_reports'
post 'testers_manage/:id', to: 'testers_manage#update', as: 'update_order'
get 'order/:id' => 'testers_manage#destroy', as: 'destroy_order'
get 'order/edit/:id' => 'testers_manage#edit', as: 'edit_order'
resources :testers, only: [:create]
resources :testers_manage, only: [:show]
