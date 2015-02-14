Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'welcome/index'
  get 'students/populate_branches'
  get 'students/:id/populate_branches' => 'students#populate_branches' 
  get 'jobposts/populate_branches'
  get 'jobposts/:id/populate_branches' => 'jobposts#populate_branches' 
  get 'jobposts/:id/view_applicants' => 'jobposts#view_applicants', as: :view_applicants_jobpost
  get '/populate_branches'  => 'jobposts#populate_branches'
  get 'students/:id/account_settings' => 'students#account_settings', as: :account_settings_student
  get 'students/:id/my_applications' => 'students#my_applications', as: :my_applications_student
  patch 'students/:id/account_settings' => 'students#update_account'

  resources :tpos
  resources :students
  resources :welcome
  resources :sessions
  resources :all_users
  resources :jobposts
  #resources :job_applications, only: :create
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit, :new, :create, :update]

  delete 'logout' => 'sessions#destroy'
  post 'job_applications' => 'job_applications#create', as: :submit_application


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
