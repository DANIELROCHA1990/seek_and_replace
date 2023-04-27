Rails.application.routes.draw do
  post 'replace_pdf', to: 'pdf#replace'
  get 'search_pdf', to: 'pdf#search'
  root to: 'pdf#search'
end
