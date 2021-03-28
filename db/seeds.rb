# Usuário comum
common_user = User.create!(email: 'renato@flix.com.br', password: '123456')

# Usuário admin
admin_user = User.create!(email: 'maria@smartflix.com.br', password: '123457', role: :admin)

# Categorias de aula
crossfit = ClassCategory.create!(name: 'Crossfit', description: 'Fica grande', responsible_teacher: 'Felipe Franco')
yoga = ClassCategory.create!(name: 'Yoga', description: 'Tranquilidade', responsible_teacher: 'Mudra')

# Plano
smart = Plan.create!(name: 'Plano Smart', montlhy_rate: 150, monthly_class_limit: 3)
fit = Plan.create!(name: 'Plano Fit', montlhy_rate: 200, monthly_class_limit: 5)

# Categorias de aula do Plano
ClassCategoryPlan.create!(plan: smart, class_category: crossfit)
ClassCategoryPlan.create!(plan: fit, class_category: yoga)