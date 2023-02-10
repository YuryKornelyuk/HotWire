class Note < ApplicationRecord
  belongs_to :user

  # https://github.com/brendon/acts_as_list#:~:text=the%20associated%20records.-,sequential_updates,-Specifies%20whether%20insert_at
  # Добавляем опцию sequential_updates: false, чтобы не обновлять позиции всех записей при изменении позиции одной записи
  # Заоодно ускоряем работу метода insert_at
  acts_as_list sequential_updates: false

  validates :title, presence: true
  validates :description, presence: true

  # Добавляем валидацию на уникальность пары user_id и position
  validates :position, uniqueness: { scope: :user }
end
