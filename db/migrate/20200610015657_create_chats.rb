class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      # t.references :userでUserモデルに対して自動的に外部キーが設定され、インデックスを付与
      # foreign_key: trueで外部キー制約
      # referencesとbelongs_toは全く同じ
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      # チャットメッセージのカラム
      t.text :message

      t.timestamps
    end
  end
end
