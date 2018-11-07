ActiveAdmin.register City do
  menu label: '城市', priority: 4

  permit_params :name
  index do
    selectable_column
    column '名称', :name
    actions
  end

  config.filters = false
end
  
