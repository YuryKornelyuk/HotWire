class AddPositionToNotes < ActiveRecord::Migration[7.0]
  def up
    add_column :notes, :position, :integer, null: false, default: 1
    # Добавляем ограничение на добавление ы БД записис с одинаковыми значениями пары user_id и position
    # deferrable initially deferred - означает, что ограничение будет проверяться только при попытке добавить запись в БД
    # сразу для всех записей, а не по одной
    execute <<~SQL.squish
      alter table notes add constraint notes_position_user_id_unique unique (position, user_id) deferrable initially deferred;
    SQL
  end

  def down
    execute <<~SQL.squish
      alter table notes drop constraint notes_position_user_id_unique;
    SQL
    remove_column :notes, :position
  end
end