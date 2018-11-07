ActiveAdmin.register StoreFile do
    #t.string "locate"
    #t.date "inspect_time"
    #t.string "path"
    #t.integer "version"
    #t.integer "user_id"
    #t.datetime "created_at", null: false
    #t.datetime "updated_at", null: false
    #t.string "client"
    #t.string "parser_path"
    #t.string "slug"
    #t.string "title"
    #t.boolean "recently", default: true
    #t.integer "devices_number"
    #t.index ["slug"], name: "index_store_files_on_slug", unique: true
    #t.index ["user_id"], name: "index_store_files_on_user_id"
  permit_params :client, :locate, :inspect_time, :version

  menu label: '巡检记录', priority: 2

  index do 
    selectable_column
    column '客户', :client
    column '地市', :locate
    column '巡检时间', :inspect_time
    column '巡检人员', :user
    column '设备数量', :devices_number
    actions ({name: '操作'})
  end

  # 过滤
  filter :client, label: '客户'
  filter :locate, label: '地市'
  filter :inspect_time, as: :date_range, label: '巡检时间'

  # 区域
  scope('最新版本', default: true) { |scope| scope.where(recently: true) }
  scope :all

  # 排序
  config.sort_order = 'inspect_time_desc'

  # 分页
  config.per_page = [10, 50, 100]

end

