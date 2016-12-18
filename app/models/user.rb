class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role # принадлежит ролям

  # Устанавливаем роль при создании пользователя
  before_create :set_role

  # Валидации
  validates :user_name, :first_name, :last_name, :middle_name, length: { maximum: 30 }


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # НЕ ПЕРЕВОДИТ В НИЖНИЙ РЕГИСТР

  # Переводим имя, фамилию и отчество пользователя в нижний регистра перед сохранением
  before_save :first_name.downcase
  before_save :last_name.downcase
  before_save :middle_name.downcase
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  private
    def set_role
      if User.first == nil
        self.role = Role.find_by_name('admin')
      else
        self.role = Role.find_by_name('registered')
      end
    end
end