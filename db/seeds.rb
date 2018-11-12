# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(email: '365433079@qq.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

City.create(name: '黄冈')
City.create(name: '黄石')
City.create(name: '荆门')
City.create(name: '荆州')
City.create(name: '宜昌')
City.create(name: '十堰')
City.create(name: '孝感')
City.create(name: '咸宁')
City.create(name: '恩施')
City.create(name: '鄂州')
City.create(name: '随州')
City.create(name: '天门')
City.create(name: '仙桃')
City.create(name: '潜江')

