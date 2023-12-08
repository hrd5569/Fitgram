class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      #フォローしたユーザーのid
      t.integer :follower_id
      #フォローしているユーザーのid
      t.integer :followed_id

      t.timestamps
    end
  end
end
